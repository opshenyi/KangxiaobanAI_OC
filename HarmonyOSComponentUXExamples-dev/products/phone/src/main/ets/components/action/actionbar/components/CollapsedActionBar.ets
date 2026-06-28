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
import { CommonUtils, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct CollapsedActionBar {
  @Local isExpand: boolean = true;
  @Local isPrimaryIconChanged: boolean = false;
  @Local primaryHoverTips: ResourceStr = 'Start';

  build() {
    Row() {
      HdsActionBar({
        startButtons: [new ActionBarButton({
          baseIcon: $r('sys.symbol.stopwatch_fill'),
          onClick: () => {
            CommonUtils.showToast('The stopwatch button has been clicked currently.');
          }
        })],
        endButtons: [new ActionBarButton({
          baseIcon: $r('sys.symbol.mic_fill'),
          onClick: () => {
            CommonUtils.showToast('The microphone button has been clicked currently.');
          }
        })],
        primaryButton: new ActionBarButton({
          baseIcon: $r('sys.symbol.plus'),
          altIcon: $r('sys.symbol.play_fill'),
          onClick: () => {
            this.isExpand = !this.isExpand;
            this.isPrimaryIconChanged = !this.isPrimaryIconChanged;
            if (this.isPrimaryIconChanged) {
              this.primaryHoverTips = 'Pause';
            } else {
              this.primaryHoverTips = 'Start';
            }
          },
          hoverTips: this.primaryHoverTips
        }),
        actionBarStyle: new ActionBarStyle({
          isPrimaryIconChanged: this.isPrimaryIconChanged
        }),
        isExpand: this.isExpand!!
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_108)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}