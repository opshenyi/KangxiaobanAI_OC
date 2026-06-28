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

import { ActionBarButton, ActionBarStyle, HdsActionBar, HdsNavDestination } from '@kit.UIDesignKit';
import { CommonUtils, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function VerticalActionBarBuilder() {
  VerticalActionBar()
}

@ComponentV2
struct VerticalActionBar {
  @Local isExpand: boolean = true;
  @Local isPrimaryIconChanged: boolean = false;
  @Local startButtonArray: ActionBarButton[] = [];
  @Local endButtonArray: ActionBarButton[] = [];

  aboutToAppear(): void {
    if (this.startButtonArray.length === 0) {
      this.startButtonArray.push(new ActionBarButton({
        baseIcon: $r('sys.symbol.arrow_clockwise'),
        hoverTips: $r('app.string.reset_label'),
        onClick: () => {
          CommonUtils.showToast('The Reset button has been clicked currently.');
        }
      }));
    }
    if (this.endButtonArray.length === 0) {
      this.endButtonArray.push(new ActionBarButton({
        baseIcon: $r('sys.symbol.bell'),
        hoverTips: $r('app.string.timer_sound_label'),
        onClick: () => {
          CommonUtils.showToast('The timer sound button has been clicked currently.');
        }
      }));
    }
  }

  build() {
    HdsNavDestination() {
      Row() {
        HdsActionBar({
          startButtons: this.startButtonArray,
          primaryButton: new ActionBarButton({
            baseIcon: $r('sys.symbol.xmark'),
            altIcon: $r('sys.symbol.plus'),
            hoverTips: $r('app.string.mouse_hover_content_label'),
            onClick: () => {
              this.isExpand = !this.isExpand;
              this.isPrimaryIconChanged = !this.isPrimaryIconChanged;
            }
          }),
          endButtons: this.endButtonArray,
          actionBarStyle: new ActionBarStyle({
            isPrimaryIconChanged: this.isPrimaryIconChanged,
            isHorizontal: false
          }),
          isExpand: this.isExpand!!
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)
      .padding({ right: PaddingToken.PADDING_34VP })
    }
    .backgroundColor($r('sys.color.background_secondary'))
  }
}