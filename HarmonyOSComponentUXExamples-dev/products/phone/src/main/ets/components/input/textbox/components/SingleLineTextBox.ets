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

import { Logger } from 'componentuxexamplesbase';
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'SingleLineTextBox';

@Builder
export function SingleLineTextBox() {
  Column() {
    SubTitleView($r('app.string.single_line_text_box_label'))

    Row() {
      TextInput({ placeholder: $r('app.string.textinput_placeholder_label_2') })
        .width(SizeToken.SIZE_PERCENT_100)
        .showUnderline(true)
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        .underlineColor({
          normal: $r('sys.color.comp_divider'),
          typing: $r('app.color.text_box_typing_color'),
          error: $r('sys.color.warning'),
          disable: Color.Gray
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
    .margin({ bottom: PaddingToken.PADDING_12VP })

    Row() {
      TextInput({ placeholder: $r('app.string.textinput_placeholder_label_2') })
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .caretColor(Color.Blue)
        .width(SizeToken.SIZE_PERCENT_100)
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        .inputFilter('[^#]', (e) => {
          Logger.info(TAG, `The filtered content is: ${JSON.stringify(e)}`);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}