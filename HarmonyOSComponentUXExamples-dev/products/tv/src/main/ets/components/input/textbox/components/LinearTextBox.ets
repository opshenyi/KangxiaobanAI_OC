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

import { CommonConstants, CornerRadiusToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@Builder
export function LinearTextBox() {
  Column() {
    ListGroupTitle($r('app.string.linear_text_box_label'))
    Column() {
      TextInput({ placeholder: $r('app.string.placeholder_hint_label') })
        .width(SizeToken.SIZE_PERCENT_100)
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('app.float.list_item_text_size'))
        .backgroundColor(Color.Transparent)
        .height($r('app.float.linear_input_height'))
        .showUnderline(true)
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .padding($r('sys.float.padding_level8'))
  }
  .width(SizeToken.SIZE_PERCENT_100)
}