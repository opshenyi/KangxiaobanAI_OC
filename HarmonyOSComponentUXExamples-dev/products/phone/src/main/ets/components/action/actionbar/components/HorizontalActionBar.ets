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
import { ActionBarButton, HdsActionBar } from '@kit.UIDesignKit';
import { CommonUtils, SizeToken } from 'componentuxexamplesbase';

@Builder
export function HorizontalActionBar() {
  Row() {
    HdsActionBar({
      startButtons: [new ActionBarButton({
        baseIcon: $r('sys.symbol.share'),
        onClick: () => {
          CommonUtils.showToast('The share button has been clicked currently.');
        }
      }), new ActionBarButton({
        baseIcon: $r('sys.symbol.star'),
        onClick: () => {
          CommonUtils.showToast('The star button has been clicked currently.');
        }
      })],
      endButtons: [new ActionBarButton({
        baseIcon: $r('sys.symbol.trash'),
        onClick: () => {
          CommonUtils.showToast('The trash button has been clicked currently.');
        }
      }), new ActionBarButton({
        baseIcon: $r('sys.symbol.dot_grid_2x2'),
        onClick: () => {
          CommonUtils.showToast('The dot button has been clicked currently.');
        }
      })]
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_NUM_108)
  .justifyContent(FlexAlign.Center)
  .alignItems(VerticalAlign.Center)
}