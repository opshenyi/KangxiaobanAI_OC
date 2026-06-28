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

import { getWindowInfoState, ImmersiveType, StyleConstants, WindowInfo } from 'musicbasic';
import { MiniBarPlayer } from './MiniBarPlayer';

/**
 * Bottom sheet-style container for {@link MiniBarPlayer} with immersive-aware background and radius.
 */
@ComponentV2
export struct PlaylistFloatingMiniBar {
  /** Window decoration state controlling bar colors and border treatment. */
  @Local windowInfo: WindowInfo = getWindowInfoState();

  /**
   * Builds the full-width mini player: non-immersive uses sheet background;
   * immersive uses `floating_mini_bar_immersive_background`.
   */
  build() {
    Column() {
      MiniBarPlayer({ showPreviousTrack: true, followAppMiniBarExpanded: false })
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(
      this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ?
        $r('app.color.floating_mini_bar_immersive_background') :
        $r('app.color.floating_mini_bar_sheet_background'))
    .borderRadius(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 0 : 28)
    .borderWidth(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 0 : 1)
    .borderColor($r('app.color.comp_divider'))
  }
}
