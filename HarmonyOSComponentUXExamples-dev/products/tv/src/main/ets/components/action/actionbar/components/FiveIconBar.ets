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

import { ActionBarButton, ActionBarStyle, HdsActionBar } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct FiveIconBar {
  @Local isExpand: boolean = true;
  @Param isHorizontal: boolean = false;

  build() {
    HdsActionBar({
      startButtons: [
        new ActionBarButton({
          baseIcon: $r('sys.symbol.stopwatch_fill')
        }),
        new ActionBarButton({
          baseIcon: $r('sys.symbol.stopwatch_fill')
        })
      ],
      endButtons: [
        new ActionBarButton({
          baseIcon: $r('sys.symbol.mic_fill')
        }),
        new ActionBarButton({
          baseIcon: $r('sys.symbol.mic_fill')
        })
      ],
      primaryButton: new ActionBarButton({
        baseIcon: $r('sys.symbol.plus'),
        altIcon: $r('sys.symbol.play_fill'),
        onClick: () => {
          this.isExpand = !this.isExpand;
        },
      }),
      isExpand: this.isExpand!!,
      actionBarStyle: new ActionBarStyle({
        isHorizontal: this.isHorizontal,
        innerSpace: LengthMetrics.vp(SizeToken.SIZE_NUM_24)
      })
    })
  }
}