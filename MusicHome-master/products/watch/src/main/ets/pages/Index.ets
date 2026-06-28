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

import {
  AppStorageV2, ArcSwiper, ArcDotIndicator, ArcDirection, ArcSwiperController
} from '@kit.ArkUI';
import { AppStorageKeys, MusicDbApi, MusicAppState, StyleConstants } from 'musicbasic';
import { MediaService } from 'player';
import { PlaylistHub, getWatchNavContext } from 'playlist';
import { WearableHome } from 'recommendation';

/** Watch entry: product shell wires recommendation / playlist / player features like other products. */
@Entry
@ComponentV2
struct Index {
  @Provider() pageStack: NavPathStack = new NavPathStack();
  @Local innerSelectedIndex: number = 0;
  private wearableSwiperController: ArcSwiperController = new ArcSwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  aboutToAppear(): void {
    getWatchNavContext();
    const state = AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
    state.playQueueIds = MusicDbApi.getInstance().getSongList().map((dto) => dto.id);
    MediaService.getInstance();
  }

  build() {
    Navigation(this.pageStack) {
      Column() {
        Row() {
          ArcSwiper(this.wearableSwiperController) {
            WearableHome()
            PlaylistHub()
          }
          .duration(400)
          .indicator(this.arcDotIndicator
            .arcDirection(ArcDirection.SIX_CLOCK_DIRECTION)
            .selectedItemColor('#FE1B48')
          )
          .onAnimationStart((index: number, targetIndex: number) => {
            this.innerSelectedIndex = targetIndex;
          })
          .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer,
            others: Array<GestureRecognizer>): GestureJudgeResult => {
            if (current) {
              let target = current.getEventTargetInfo();
              if (target && current.isBuiltIn() && current.getType() == GestureControl.GestureType.PAN_GESTURE) {
                let swiperTarget = target as ScrollableTargetInfo;
                if (swiperTarget instanceof ScrollableTargetInfo &&
                  (swiperTarget.isBegin() || this.innerSelectedIndex === 0)) {
                  let panEvent = event as PanGestureEvent;
                  if (panEvent && panEvent.offsetX > 0 && (swiperTarget.isBegin() || this.innerSelectedIndex === 0)) {
                    return GestureJudgeResult.REJECT;
                  }
                }
              }
            }
            return GestureJudgeResult.CONTINUE;
          })
        }
        .height(StyleConstants.FULL_HEIGHT)
      }
      .width(StyleConstants.FULL_WIDTH)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }
}
