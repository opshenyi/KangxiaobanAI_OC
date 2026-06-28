/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Moved from common/mediacommon/src/main/ets/utils/MediaService.ets
 */

import { AppStorageV2 } from '@kit.ArkUI';
import { media } from '@kit.MediaKit';
import { common, wantAgent } from '@kit.AbilityKit';
import { avSession } from '@kit.AVSessionKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { resourceManager } from '@kit.LocalizationKit';
import { AppStorageKeys, getAppRuntime, Logger, MusicAppState, SongItem, StringResourceUtil } from 'musicbasic';
import SongItemBuilder from '../util/SongItemBuilder';
import { AudioPlayerState, MusicPlayMode } from './MusicData';
import { BackgroundUtil } from '../util/BackgroundUtil';
import { MediaTools } from '../util/MediaTools';

const TAG = 'MediaService';

/**
 * Coordinates local audio playback (AVPlayer), shared UI state (MusicAppState), and system AVSession.
 */
export class MediaService {
  /** UIAbility context from application runtime; used for resources, want agent, and background task. */
  private get abilityContext(): common.UIAbilityContext | undefined {
    return getAppRuntime().context;
  }
  /** Underlying Harmony AVPlayer; undefined until createAVPlayer succeeds. */
  public avPlayer?: media.AVPlayer;
  /** Active AV session for lock screen / headset / system media controls. */
  private session?: avSession.AVSession;
  /** Builds SongItem and fd/url descriptor for AVPlayer.fdSrc. */
  private songItemBuilder: SongItemBuilder = new SongItemBuilder();
  /** Resolved current track metadata for internal use. */
  private songItem: SongItem = new SongItem();
  /** Current repeat / shuffle mode. */
  private playMode: MusicPlayMode = MusicPlayMode.ORDER;
  /** AVPlayer high-level lifecycle state mirror. */
  private state: AudioPlayerState = AudioPlayerState.IDLE;
  /** True until the first fdSrc has been applied on this player instance. */
  private isFirst: boolean = true;
  /** True after successful prepare() for the current fdSrc. */
  private isPrepared: boolean = false;
  /** Current index within the play queue (aligned with MusicAppState.selectIndex after update). */
  private musicIndex: number = 0;
  /** True when displayed progress should track AVPlayer time updates (false during seek). */
  private isCurrent: boolean = true;
  /** When false, prepared state will not auto-start play (e.g. load-only). */
  private isNeedPlay: boolean = true;
  /** Queue index to load once AVPlayer is ready; -1 means none. */
  private pendingLoadIndex: number = -1;
  /** Whether the pending load should skip starting playback. */
  private pendingLoadOnly: boolean = false;

  /** AVPlayer seekDone: marks seek finished and updates AVSession position. */
  private seekCall: (seekDoneTime: number) => void = (seekDoneTime: number) => {
    this.isCurrent = true;
    Logger.info(TAG, `AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
    this.setPlayState({
      position: {
        elapsedTime: this.getCurrentTime(),
        updateTime: new Date().getTime()
      }
    });
  };
  /** AVPlayer error: logs and resets the player. */
  private errorCall: (err: BusinessError) => void = (err: BusinessError) => {
    Logger.error(TAG, `Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
    this.avPlayer?.reset();
  };
  /** AVPlayer timeUpdate: refreshes countdown label and progress in MusicAppState when active. */
  private updateTimeCall: (updateTime: number) => void = (updateTime: number) => {
    if (this.isCurrent) {
      const appState = this.getAppState();
      appState.currentTime = MediaTools.msToCountdownTime(updateTime);
      appState.progress = updateTime;
    }
  };
  /** AVPlayer stateChange: drives prepare/play flow, metadata, and auto-next on completion. */
  private stateCall: (state: string) => Promise<void> = async (state: string) => {
    switch (state) {
      case 'idle':
        Logger.info(TAG, 'AVPlayer state idle called.');
        this.state = AudioPlayerState.IDLE;
        const idleSong = this.getSongItemAtQueueIndex(this.musicIndex);
        if (!idleSong) {
          break;
        }
        this.songItem = await this.songItemBuilder.build(idleSong);
        let url = this.songItemBuilder.getRealUrl();
        if (this.avPlayer && url) {
          let avFileDescriptor: media.AVFileDescriptor = { fd: url.fd, offset: url.offset, length: url.length };
          this.avPlayer.fdSrc = avFileDescriptor;
          Logger.info(TAG, 'loadAsset avPlayer.url:' + this.avPlayer.fdSrc);
        }
        break;
      case 'initialized':
        Logger.info(TAG, 'AVPlayer state initialized called.');
        this.state = AudioPlayerState.INITIALIZED;
        if (this.avPlayer) {
          this.avPlayer.prepare().then(() => {
            Logger.info(TAG, 'AVPlayer prepare succeeded.');
          }, (err: BusinessError) => {
            Logger.error(TAG, `Invoke prepare failed, code is ${err.code}, message is ${err.message}`);
          });
        }
        break;
      case 'prepared':
        Logger.info(TAG, 'AVPlayer state prepared called.');
        this.state = AudioPlayerState.PREPARED;
        this.isPrepared = true;
        const appState = this.getAppState();
        appState.totalTime = MediaTools.msToCountdownTime(this.getDuration());
        appState.progressMax = this.getDuration();
        if (this.avPlayer && this.isNeedPlay) {
          this.ensureBackgroundAudioTask();
          this.avPlayer.play();
        }
        this.setAVMetadata();
        this.isNeedPlay = true;
        Logger.info(TAG, 'AVPlayer prepared succeeded.');
        break;
      case 'playing':
        Logger.info(TAG, 'AVPlayer state playing called.');
        this.state = AudioPlayerState.PLAY;
        this.ensureBackgroundAudioTask();
        break;
      case 'paused':
        Logger.info(TAG, 'AVPlayer state paused called.');
        this.state = AudioPlayerState.PAUSE;
        break;
      case 'completed':
        Logger.info(TAG, 'AVPlayer state completed called.');
        this.state = AudioPlayerState.COMPLETED;
        this.playNextAuto(false);
        break;
      case 'stopped':
        Logger.info(TAG, 'AVPlayer state stopped called.');
        this.state = AudioPlayerState.STOP;
        if (this.avPlayer) {
          this.avPlayer.reset();
        }
        break;
      case 'released':
        Logger.info(TAG, 'AVPlayer state released called.');
        this.state = AudioPlayerState.RELEASED;
        break;
      default:
        Logger.info(TAG, 'AVPlayer state unknown called.');
        this.state = AudioPlayerState.UNKNOWN;
        break;
    }
    this.updateIsPlay(this.state === AudioPlayerState.PLAY);
  };
  /** AVSession remote play: loads first asset or resumes local play. */
  private playCall: () =>void = () => {
    Logger.info(TAG, `on play , do play task`);
    if (this.isFirst) {
      this.loadAsset(this.getValidSelectIndex());
    } else {
      this.play();
    }
  };
  /** AVSession remote pause. */
  private pauseCall: () =>void = () => {
    Logger.info(TAG, `on pause , do pause task`);
    this.pause();
  };
  /** AVSession remote next track. */
  private playNextCall: () =>void = () => {
    Logger.info(TAG, `on playNext , do playNext task`);
    this.playNextAuto(true);
  };
  /** AVSession remote previous track. */
  private playPreviousCall: () =>void = () => {
    Logger.info(TAG, `on playPrevious , do playPrevious task`);
    this.playPrevious();
  };
  /** AVPlayer volumeChange: mirrors volume into MusicAppState. */
  private volumeChangeCall: (volume: number) => void = (volume: number) => {
    Logger.info(TAG, `on volumeChangeCall, do volumeChange task`);
    this.getAppState().volume = volume;
  };

  /** Shared observable app state (queue, play flag, progress) bound to AppStorageV2. */
  private getAppState(): MusicAppState {
    return AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
  }

  /** Starts or refreshes continuous background audio task (required after some track-switch paths). */
  private ensureBackgroundAudioTask(): void {
    BackgroundUtil.startContinuousTask(this.abilityContext);
  }

  /** Called when the app goes to background while playing; keeps continuous task if needed. */
  public onApplicationBackground(): void {
    if (this.getAppState().isPlay) {
      this.ensureBackgroundAudioTask();
    }
  }

  /** Resolves SongItem at queue index via MusicAppState. */
  private getSongItemAtQueueIndex(index: number): SongItem | undefined {
    return this.getAppState().resolveSongAtQueueIndex(index);
  }

  /** Current play queue length from MusicAppState. */
  private getQueueLength(): number {
    return this.getAppState().getQueueLength();
  }

  /** Clamps MusicAppState.selectIndex to a valid queue index (0 if empty or out of range). */
  private getValidSelectIndex(): number {
    const len = this.getQueueLength();
    const idx = this.getAppState().selectIndex;
    if (len === 0) {
      return 0;
    }
    if (idx < 0 || idx >= len) {
      return 0;
    }
    return idx;
  }

  /** Applies deferred loadAsset request after AVPlayer becomes available. */
  private applyPendingLoadRequest(): void {
    if (this.pendingLoadIndex < 0) {
      return;
    }
    const pendingIndex = this.pendingLoadIndex;
    const pendingLoadOnly = this.pendingLoadOnly;
    this.pendingLoadIndex = -1;
    this.pendingLoadOnly = false;
    void this.loadAsset(pendingIndex, pendingLoadOnly);
  }

  /** Creates service, builds SongItemBuilder, and starts async AVPlayer creation. */
  public constructor() {
    this.songItemBuilder = new SongItemBuilder();
    this.initAudioPlayer();
  }

  /** Global singleton stored on AppRuntime.mediaServiceRef. */
  public static getInstance(): MediaService {
    const rt = getAppRuntime();
    if (!rt.mediaServiceRef) {
      rt.mediaServiceRef = new MediaService();
    }
    return rt.mediaServiceRef as MediaService;
  }

  /** Creates AVPlayer, registers callbacks, creates AVSession, and drains pending load. */
  private initAudioPlayer(): void {
    media.createAVPlayer().then(async avPlayer => {
      if (avPlayer !== null) {
        this.avPlayer = avPlayer;
        this.setAVPlayerCallback();
        this.createSession();
        this.applyPendingLoadRequest();
      }
    }) .catch((error: BusinessError) => {
      Logger.error(TAG, 'this avPlayer: ', `catch error happened,error code is ${error.code}`);
    });
  }

  /** Subscribes AVPlayer events (seek, error, time, state, volume). */
  private setAVPlayerCallback(): void {
    if (!this.avPlayer) {
      return;
    }
    this.avPlayer.on('seekDone', this.seekCall);

    this.avPlayer.on('error', this.errorCall);

    this.avPlayer.on('timeUpdate', this.updateTimeCall);

    this.avPlayer.on('stateChange', this.stateCall);

    this.avPlayer.on('volumeChange', this.volumeChangeCall);
  }

  /** Creates and activates AVSession, sets launch want agent, and registers controller listeners. */
  private async createSession(): Promise<void> {
    if (!this.abilityContext) {
      return;
    }
    try {
      this.session = await avSession.createAVSession(this.abilityContext, 'SESSION_NAME', 'audio');
      Logger.info(TAG, `session create done : sessionId : ${this.session.sessionId}`);
      this.session.activate();
    } catch (error) {
      Logger.error(TAG, `${error.code} + ${error.message}`);
    }
    this.setAVMetadata();
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: this.abilityContext.abilityInfo.bundleName,
          abilityName: this.abilityContext.abilityInfo.name
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITIES,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    };
    wantAgent.getWantAgent(wantAgentInfo).then((agent) => {
      if (this.session) {
        this.session.setLaunchAbility(agent);
      }
    })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `getWantAgent failed, code: ${JSON.stringify(err.code)}, ` +
        `message: ${JSON.stringify(err.message)}`);
      });
    this.registerSessionControlListeners();
  }

  /** Subscribe to AVSession controller commands (play / pause / next / previous). */
  private async registerSessionControlListeners(): Promise<void> {
    if (!this.session) {
      return;
    }
    try {
      this.session.on('play', this.playCall);
      this.session.on('pause', this.pauseCall);
      this.session.on('playNext', this.playNextCall);
      this.session.on('playPrevious', this.playPreviousCall);
    } catch (error) {
      Logger.error(TAG, `${error.code} + ${error.message}`);
    }
  }

  /** Unsubscribe AVSession controller command listeners. */
  private async unregisterSessionControlListeners(): Promise<void> {
    if (!this.session) {
      return;
    }
    try {
      this.session.off('play');
      this.session.off('pause');
      this.session.off('playNext');
      this.session.off('playPrevious');
    } catch (error) {
      Logger.error(TAG, `${error.code} + ${error.message}`);
    }
  }

  /** Updates AVSession metadata (title, artist, duration, optional cover) for the current track. */
  private async setAVMetadata(): Promise<void> {
    const id = this.musicIndex;
    try {
      if (!this.abilityContext) {
        return;
      }
      const ctx = this.abilityContext;
      const metaSong = this.getSongItemAtQueueIndex(this.musicIndex);
      if (!metaSong) {
        return;
      }
      let mediaImage: PixelMap | undefined = undefined;
      try {
        try {
          mediaImage = await MediaTools.getPixelMapFromResource(ctx,
            metaSong.label as resourceManager.Resource);
          Logger.info(TAG, 'getPixelMapFromResource success');
        } catch (error) {
          const be = error as BusinessError;
          if (be && be.code !== undefined && be.message !== undefined) {
            Logger.warn(TAG, `setAVMetadata cover fallback, code=${be.code}, message=${be.message}`);
          } else {
            Logger.warn(TAG, `setAVMetadata cover fallback, ${(error as Error)?.message ?? JSON.stringify(error)}`);
          }
        }
        const song = metaSong;
        const metadata: avSession.AVMetadata = {
          assetId: `${id}`,
          title: StringResourceUtil.resolve(ctx, song.title),
          artist: StringResourceUtil.resolve(ctx, song.singer),
          duration: this.getDuration()
        };
        if (mediaImage !== undefined) {
          metadata.mediaImage = mediaImage;
        }
        if (this.session) {
          try {
            await this.session.setAVMetadata(metadata);
            Logger.info(TAG, 'SetAVMetadata successfully');
          } catch (err) {
            const be = err as BusinessError;
            Logger.error(TAG, `SetAVMetadata failed, code=${be.code}, message=${be.message}`);
          }
        }
      } finally {
        if (mediaImage !== undefined) {
          try {
            mediaImage.release();
          } catch (error) {
            const err = error as BusinessError;
            Logger.warn(TAG, `mediaImage.release failed, code=${err?.code}, message=${err?.message}`);
          }
        }
      }
    } catch (error) {
      const be = error as BusinessError;
      Logger.error(TAG, `SetAVMetadata failed, code=${be?.code}, message=${be?.message}`);
    }
  }

  /**
   * Load media asset for the given queue index (prepare or switch track).
   *
   * @param musicIndex Index in the play queue.
   * @param loadOnly When true, only load without starting playback.
   */
  public async loadAsset(musicIndex: number, loadOnly?: boolean): Promise<void> {
    const len = this.getQueueLength();
    if (len === 0) {
      Logger.error(TAG, 'play queue is empty when loadAsset');
      return;
    }
    if (musicIndex < 0 || musicIndex >= len) {
      Logger.error(TAG, `current musicIndex ${musicIndex}`);
      return;
    }
    const queueSong = this.getSongItemAtQueueIndex(musicIndex);
    if (!queueSong) {
      Logger.error(TAG, `resolve song failed at queue index ${musicIndex}`);
      return;
    }
    this.ensureBackgroundAudioTask();
    this.updateMusicIndex(musicIndex);
    if (!this.avPlayer) {
      // Defer play until initAudioPlayer creates AVPlayer; loadAsset is applied then.
      this.pendingLoadIndex = musicIndex;
      this.pendingLoadOnly = loadOnly === true;
      return;
    }
    if (this.isFirst) {
      this.isFirst = false;
      this.songItem = await this.songItemBuilder.build(queueSong);
      let url = this.songItemBuilder.getRealUrl();
      if (url) {
        if (loadOnly) {
          this.isNeedPlay = false;
        }
        let avFileDescriptor: media.AVFileDescriptor = { fd: url.fd, offset: url.offset, length: url.length };
        this.avPlayer.fdSrc = avFileDescriptor;
        Logger.info(TAG, 'loadAsset avPlayer.url:' + this.avPlayer.fdSrc);
      }
    } else {
      await this.stop();
    }
  }

  /**
   * Whether the player has not yet applied the first fdSrc on this AVPlayer instance.
   *
   * @returns True until first asset load completes.
   */
  public getFirst() {
    return this.isFirst;
  }

  /**
   * Set music play mode (order, shuffle, repeat, etc.).
   *
   * @param playMode Target play mode.
   */
  public setPlayMode(playMode: MusicPlayMode) {
    this.playMode = playMode;
    Logger.info(TAG, 'setPlayMode mode: ' + this.playMode);
  }

  /**
   * Get music play mode.
   *
   * @returns playMode.
   */
  public getPlayMode() {
    return this.playMode;
  }

  /** Updates MusicAppState.isPlay and AVSession playback state snapshot. */
  private updateIsPlay(isPlay: boolean) {
    this.getAppState().isPlay = isPlay;
    this.setPlayState({
      state: isPlay ? avSession.PlaybackState.PLAYBACK_STATE_PLAY : avSession.PlaybackState.PLAYBACK_STATE_PAUSE,
      position: {
        elapsedTime: this.getCurrentTime(),
        updateTime: new Date().getTime()
      }
    });
  }

  /**
   * Seeks the current track to the given position in milliseconds.
   *
   * @param ms Target position in ms, clamped to [0, duration].
   */
  public seek(ms: number) {
    if (this.isPrepared && this.state != AudioPlayerState.ERROR && this.avPlayer) {
      let seekMode = this.getCurrentTime() < ms ? 0 : 1;
      let realTime = (ms <= 0 ? 0 : (ms >= this.getDuration() ? this.getDuration() : ms));
      this.isCurrent = false;
      this.avPlayer.seek(realTime, seekMode);
    }
  }

  /** Current playback position in ms from AVPlayer, or 0 if not prepared. */
  private getCurrentTime() {
    if (this.isPrepared && this.avPlayer) {
      return this.avPlayer.currentTime;
    }
    return 0;
  }

  /** Total duration in ms from AVPlayer, or 0 if not prepared. */
  private getDuration() {
    if (this.isPrepared && this.avPlayer) {
      return this.avPlayer.duration;
    }
    return 0;
  }

  /** Runs prepare(); used when play() is requested before prepared. */
  private start(seekMs?: number) {
    Logger.info(TAG, 'AVPlayer play() isPrepared:' + this.isPrepared + ', state:' + this.state + '，seek:' + seekMs);
    if (this.avPlayer) {
      this.avPlayer.prepare().then(() => {
      }).catch((error: BusinessError) => {
        Logger.error(TAG, `start error ${JSON.stringify(error)}`);
        this.state = AudioPlayerState.ERROR;
        this.updateIsPlay(false);
        this.isPrepared = false;
      });
    }
  }

  /**
   * Starts or resumes playback; triggers prepare if the player is not prepared yet.
   */
  public async play() {
    Logger.info(TAG, 'AVPlayer play() isPrepared:' + this.isPrepared + ', state:' + this.state);
    this.ensureBackgroundAudioTask();
    if (!this.isPrepared) {
      this.start(0);
    } else if (this.avPlayer) {
      try {
        this.avPlayer.play().then(() => {
          Logger.info(TAG, 'progressTime play() current time:' + this.getCurrentTime());
          this.seek(this.getCurrentTime());
          this.updateIsPlay(true);
          this.state = AudioPlayerState.PLAY;
        });
      } catch (error) {
        Logger.error(TAG, `${error.code} + ${error.message}`);
      }
    }
  }

  /**
   * Pauses playback when currently in PLAY state.
   */
  public pause() {
    Logger.info(TAG, 'AVPlayer pause() isPrepared:' + this.isPrepared + ', state:' + this.state);
    if (this.isPrepared && this.state === AudioPlayerState.PLAY && this.avPlayer) {
      this.avPlayer.pause().then(() => {
        this.state = AudioPlayerState.PAUSE;
        this.updateIsPlay(false);
        if (this.abilityContext) {
          BackgroundUtil.stopContinuousTask(this.abilityContext);
        }
      }).catch((err: BusinessError) => {
        Logger.error(TAG, 'Failed to pause,error message is :' + err.message);
      })
    }
  }

  /**
   * Advances playback according to play mode (order, random, single-cycle).
   *
   * @param isFromControl True when invoked from user/system control (vs track completion).
   */
  public playNextAuto(isFromControl: boolean) {
    Logger.info(TAG, 'playNextAuto mode:' + this.playMode);
    switch (this.playMode) {
      case MusicPlayMode.SINGLE_CYCLE:
        if (isFromControl) {
          this.playNext();
        } else if (this.avPlayer) {
          try {
            this.avPlayer.play();
          } catch (error) {
            Logger.error(TAG, `${error.code} + ${error.message}`);
          }
        }
        break;
      case MusicPlayMode.ORDER:
        this.playNext();
        break;
      case MusicPlayMode.RANDOM:
        this.playRandom();
        break;
      default:
        break;
    }
  }

  /** Loads the next queue index in linear order (wraps to 0 at end). */
  private playNext() {
    const len = this.getQueueLength();
    if (len === 0) {
      return;
    }
    Logger.info(TAG, 'playNext Index:' + this.musicIndex + ', length-1:' + (len - 1));
    if (this.musicIndex === len - 1) {
      this.loadAsset(0);
    } else {
      this.loadAsset(this.musicIndex + 1);
    }
  }

  /**
   * Goes to the previous track for order / single-cycle, or random pick in random mode.
   */
  public playPrevious() {
    const len = this.getQueueLength();
    if (len === 0) {
      return;
    }
    switch (this.playMode) {
      case MusicPlayMode.RANDOM:
        this.playRandom();
        break;
      case MusicPlayMode.ORDER:
      case MusicPlayMode.SINGLE_CYCLE:
        if (this.musicIndex === 0) {
          this.updateMusicIndex(len - 1);
        } else {
          this.updateMusicIndex(this.musicIndex - 1);
        }
        Logger.info(TAG, 'setLastIndex:' + this.musicIndex);
        this.loadAsset(this.musicIndex);
        break;
      default:
        break;
    }
  }

  /** Picks a random queue index different from the current one (when length > 1). */
  private playRandom() {
    const len = this.getQueueLength();
    if (len <= 1) {
      if (len === 1) {
        this.loadAsset(0);
      }
      return;
    }
    // Uniform on {0..len-1} \ {musicIndex}; avoids recursion and stack overflow on repeated collisions.
    const k: number = Math.floor(Math.random() * (len - 1));
    const num: number = k < this.musicIndex ? k : k + 1;
    this.updateMusicIndex(num);
    this.loadAsset(num);
    Logger.info(TAG, 'play Random:' + this.musicIndex);
  }

  /**
   * Stops AVPlayer and clears playing state when prepared.
   */
  public async stop() {
    Logger.info(TAG, 'stop()');
    if (this.isPrepared && this.avPlayer) {
      try {
        await this.avPlayer.stop();
        this.updateIsPlay(false);
        this.state = AudioPlayerState.PAUSE;
        if (this.abilityContext) {
          BackgroundUtil.stopContinuousTask(this.abilityContext);
        }
      } catch (error) {
        Logger.error(TAG, `${error.code} + ${error.message}`);
      }
    }
  }

  /** Resets AVPlayer and releases SongItemBuilder resources. */
  private async reset() {
    Logger.info(TAG, 'reset()');
    await this.songItemBuilder.release();
    if (this.avPlayer) {
      try {
        await this.avPlayer.reset();
      } catch (error) {
        Logger.error(TAG, `${error.code} + ${error.message}`);
      }
    }
    this.isPrepared = false;
  }

  /**
   * Releases AVPlayer and AVSession; intended for ability teardown (best-effort sync calls).
   */
  public release() {
    if (this.avPlayer && this.session && this.abilityContext) {
      try {
        this.updateIsPlay(false);
        this.stop();
        this.reset();
        this.avPlayer.release();
        this.state = AudioPlayerState.IDLE;
        BackgroundUtil.stopContinuousTask(this.abilityContext);
        this.unregisterSessionControlListeners();
        this.session.destroy((err: BusinessError) => {
          if (err) {
            Logger.error(TAG, `Failed to destroy session. Code: ${err.code}, message: ${err.message}`);
          } else {
            Logger.info(TAG, `Destroy : SUCCESS `);
          }
        });
      } catch (error) {
        Logger.error(TAG, `${error.code} + ${error.message}`);
      }
    }
  }

  /** Writes selectIndex to MusicAppState and refreshes AVSession metadata when index changes. */
  private updateMusicIndex(musicIndex: number) {
    Logger.info(TAG, 'updateMusicIndex ===> ' + musicIndex);
    this.getAppState().selectIndex = musicIndex;
    if (this.musicIndex !== musicIndex) {
      this.musicIndex = musicIndex;
    }
    Logger.info(TAG, 'this.session !== undefined ===> ' + (this.session != undefined));
    if (this.session !== undefined) {
      this.setAVMetadata();
    }
  }

  /** Pushes playback state (play/pause and position) to AVSession. */
  private async setPlayState(playbackState: avSession.AVPlaybackState) {
    if (this.session) {
      this.session.setAVPlaybackState(playbackState, (err: BusinessError) => {
        if (err) {
          Logger.info(TAG, `SetAVPlaybackState BusinessError: code: ${err.code}, message: ${err.message}`);
        } else {
          Logger.info(TAG, 'SetAVPlaybackState successfully');
        }
      });
    }
  }
}

