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


import { AppStorageV2 } from '@kit.ArkUI';
import { AppStorageKeys } from 'musicbasic';
import { MusicAppState, PlaybackIntentState } from '../model/PlaylistModels';
import { PlaylistSongUiDataSource } from '../model/PlaylistSongUiDataSource';
import { PlaylistSongUi } from '../model/PlaylistUiModels';
import { PlaylistDataUtil } from '../util/PlaylistDataUtil';

/**
 * Observable view model: playlist rows, lazy list data source, and play requests via global intent.
 */
@ObservedV2
export class MusicListPlaybackViewModel {
  /** Connected global music app state (current song, play flag, etc.). */
  public appState: MusicAppState =
    AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
  /** Connected global playback intent used to request the player and next track. */
  private playbackIntent: PlaybackIntentState =
    AppStorageV2.connect(PlaybackIntentState, AppStorageKeys.PLAYBACK_INTENT_STATE, () => new PlaybackIntentState())!;

  /** LazyForEach data source mirroring {@link playlistSongUis}. */
  @Trace public songListDataSource: PlaylistSongUiDataSource = new PlaylistSongUiDataSource([]);
  /** Materialized playlist song rows after sync from API/DB. */
  @Trace public playlistSongUis: PlaylistSongUi[] = [];

  /**
   * Reloads playlist songs and rebuilds the list data source.
   * @param playlistId Playlist id to load; defaults to {@link PlaylistDataUtil.defaultPlaylistId}.
   */
  public syncPlaylistFromApi(playlistId: number = PlaylistDataUtil.defaultPlaylistId): void {
    this.playlistSongUis = PlaylistDataUtil.loadPlaylistSongUis(playlistId);
    this.songListDataSource = new PlaylistSongUiDataSource(this.playlistSongUis);
  }

  /**
   * Requests playback for the row at the given index, or opens the player if it is already the current song.
   * @param index Zero-based playlist index.
   */
  public requestPlayByListIndex(index: number): void {
    if (index < 0 || index >= this.playlistSongUis.length) {
      return;
    }
    const item = this.playlistSongUis[index];
    if (this.isCurrentSong(item)) {
      this.playbackIntent.pendingPlaySongId = -1;
      this.playbackIntent.openPlayerUi = true;
      this.playbackIntent.requestVersion++;
      return;
    }
    PlaylistDataUtil.applyPlaybackIntentForPlaylistIndex(index, this.playlistSongUis, this.playbackIntent);
  }

  /**
   * Applies a standard play intent for the given list index without the same-song shortcut.
   * @param index Zero-based playlist index.
   */
  public requestPlayFromPlaylistIndex(index: number): void {
    PlaylistDataUtil.applyPlaybackIntentForPlaylistIndex(index, this.playlistSongUis, this.playbackIntent);
  }

  /**
   * Whether the given UI row matches the globally current song.
   * @param item Row model to compare with the active track.
   * @returns True when ids match and a current song exists.
   */
  public isCurrentSong(item: PlaylistSongUi): boolean {
    const cur = this.appState.getCurrentSongItem();
    return cur !== undefined && cur.id === item.id;
  }
}
