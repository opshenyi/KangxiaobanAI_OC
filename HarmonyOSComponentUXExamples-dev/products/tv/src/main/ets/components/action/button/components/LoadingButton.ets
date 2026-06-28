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

import { CommonUtils, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@Builder
export function LoadingButton() {
  Column() {
    ListGroupTitle($r('app.string.loading_status_label'))
    Row({ space: SpaceToken.SPACE_32 }) {
      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Row({ space: SpaceToken.SPACE_10 }) {
          LoadingProgress()
            .width(SizeToken.SIZE_NUM_32)
            .height(SizeToken.SIZE_NUM_32)
            .color($r('sys.color.font_on_primary'))
          Text('Loading')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
        }
      }
      .height($r('app.float.button_height'))
      .width(SizeToken.SIZE_NUM_188)
      .buttonStyle(ButtonStyleMode.EMPHASIZED)
      .onClick(() => {
        CommonUtils.showToast($r('app.string.loading_type_emphasized_button_toast_label'));
      })

      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Row({ space: SpaceToken.SPACE_10 }) {
          LoadingProgress()
            .width(SizeToken.SIZE_NUM_32)
            .height(SizeToken.SIZE_NUM_32)
            .color($r('sys.color.icon_tertiary'))
          Text('Loading')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_tertiary'))
        }
      }
      .height($r('app.float.button_height'))
      .width(SizeToken.SIZE_NUM_188)
      .buttonStyle(ButtonStyleMode.NORMAL)
      .backgroundColor($r('sys.color.comp_background_tertiary'))
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Start)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .padding(PaddingToken.PADDING_16VP)

  }
}