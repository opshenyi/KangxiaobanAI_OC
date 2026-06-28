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
import { HdsNavigation } from '@kit.UIDesignKit';
import {
  AppStorageKeys,
  getWindowInfoState,
  MusicAppState,
  MusicDbApi,
  PlaybackIntentState,
  PlaybackShellConstants,
  StyleConstants,
  WindowInfo
} from 'musicbasic';
import { dispatchShellPlaybackIntent, PlaybackPagePanelCoverContent } from 'player';
import { HomeCapsuleHeader, PanelMusicHomePage } from 'recommendation';

/** TV root page: HDS navigation, recommendation home, and full-screen playback cover. */
@Entry
@ComponentV2
struct Index {
  /** Navigation stack keyed for TV page index / deep links. */
  @Provider('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  /** Shared music queue and playback UI flags. */
  @Local appState: MusicAppState =
    AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
  /** Shell playback intents (e.g. open player) observed via @Monitor. */
  @Local intentState: PlaybackIntentState =
    AppStorageV2.connect(PlaybackIntentState, AppStorageKeys.PLAYBACK_INTENT_STATE, () => new PlaybackIntentState())!;
  /** Window metrics for layout (safe areas, etc.). */
  @Local windowInfo: WindowInfo = getWindowInfoState();

  /** Seeds play queue IDs from the local music database. */
  aboutToAppear() {
    this.appState.playQueueIds = MusicDbApi.getInstance().getSongList().map((dto) => dto.id);
  }

  /** Reacts to playback intent version bumps and animates the player cover open. */
  @Monitor('intentState.requestVersion')
  onPlaybackIntentChanged() {
    dispatchShellPlaybackIntent(this.appState, this.intentState, () => {
      this.getUIContext().animateTo({
        duration: PlaybackShellConstants.OPEN_PLAYER_UI_ANIMATION_MS,
        curve: Curve.EaseInOut
      }, () => {
        this.appState.isShowPlay = true;
      });
    });
  }

  /** Builds HdsNavigation with home content and bound playback cover. */
  build() {
    HdsNavigation(this.pageIndexInfos) {
      Column() {
        HomeCapsuleHeader()
        PanelMusicHomePage()
          .layoutWeight(1)
      }
      .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
    }
    .bindContentCover(this.appState.isShowPlay, PlaybackPagePanelCoverContent(), ModalTransition.NONE)
    .mode(NavigationMode.Stack)
    .height(StyleConstants.FULL_HEIGHT)
    .width(StyleConstants.FULL_WIDTH)
    .hideTitleBar(true)
    .hideToolBar(true)
    .backgroundColor('#18181A')
  }
}
