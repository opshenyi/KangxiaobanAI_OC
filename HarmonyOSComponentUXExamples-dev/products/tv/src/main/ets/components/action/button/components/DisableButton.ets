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

import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@Builder
export function DisableButton() {
  Column() {
    ListGroupTitle($r('app.string.disabled_status_or_disable_label'))
    Row({ space: SpaceToken.SPACE_32 }) {
      Button($r('app.string.disabled_label'))
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .height($r('app.float.button_height'))
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .stateEffect(false)
        .hoverEffect(HoverEffect.None)
        .enabled(false)
      Button($r('app.string.disabled_label'))
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .height($r('app.float.button_height'))
        .buttonStyle(ButtonStyleMode.NORMAL)
        .stateEffect(false)
        .hoverEffect(HoverEffect.None)
        .enabled(false)
      Button($r('app.string.disabled_label'))
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .height($r('app.float.button_height'))
        .buttonStyle(ButtonStyleMode.NORMAL)
        .role(ButtonRole.ERROR)
        .stateEffect(false)
        .hoverEffect(HoverEffect.None)
        .enabled(false)
      Button($r('app.string.disabled_label'))
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .height($r('app.float.button_height'))
        .buttonStyle(ButtonStyleMode.TEXTUAL)
        .stateEffect(false)
        .hoverEffect(HoverEffect.None)
        .enabled(false)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .padding(PaddingToken.PADDING_16VP)
  }
}