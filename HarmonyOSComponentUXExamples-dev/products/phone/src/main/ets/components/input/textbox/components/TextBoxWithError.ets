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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct TextBoxWithError {
  @Local errMsg: ResourceStr | undefined;
  @Local text: string = 'Input_123*';
  private reg: RegExp | undefined;

  aboutToAppear(): void {
    this.reg = new RegExp(/[^\u4e00-\u9fa5a-zA-Z0-9]/);
  }

  build() {
    Column() {
      SubTitleView($r('app.string.input_box_with_error_message_label'))

      Row() {
        TextInput({ text: this.text!!, placeholder: $r('app.string.textinput_placeholder_label_2') })
          .width(SizeToken.SIZE_PERCENT_100)
          .maxLines(CommonConstants.TEXT_MAX_LINES_1)
          .showUnderline(true)
          .underlineColor({
            normal: $r('sys.color.comp_divider'),
            typing: $r('app.color.text_box_typing_color'),
            error: $r('sys.color.warning'),
            disable: Color.Gray
          })
          .showError(this.errMsg)
          .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
          .onChange(() => {
            this.checkInput();
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding(PaddingToken.PADDING_12VP)
      .margin({ bottom: PaddingToken.PADDING_12VP })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  private checkInput() {
    if (this.reg?.test(this.text)) {
      this.errMsg = $r('app.string.input_box_detail_error_msg_label')
    } else {
      this.errMsg = undefined;
    }
  }
}