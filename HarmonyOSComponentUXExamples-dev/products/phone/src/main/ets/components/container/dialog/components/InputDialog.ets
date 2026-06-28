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

import { CustomContentDialog } from '@kit.ArkUI';
import { CommonConstants, CommonListRow, SizeToken, SpaceToken } from 'componentuxexamplesbase';

@Extend(TextInput)
function customTextInputStyle() {
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_NUM_48)
  .fontSize($r('sys.float.Body_L'))
  .fontColor($r('sys.color.font_primary'))
  .placeholderColor($r('sys.color.font_secondary'))
  .showUnderline(true)
  .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
  .underlineColor({
    normal: $r('sys.color.comp_divider'),
    typing: $r('app.color.text_box_typing_color')
  })
}

@ComponentV2
export struct InputDialog {
  @Local textValue1: string = '';
  @Local textValue2: string = '';
  private dialogController: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.input_dialog_label'),
        contentBuilder: () => {
          this.buildContent();
        },
      }),
    });
  }

  @Builder
  buildContent(): void {
    Column({ space: SpaceToken.SPACE_8 }) {
      TextInput({ placeholder: 'Title', text: this.textValue1!! })
        .customTextInputStyle()

      TextInput({ placeholder: 'Hint', text: this.textValue2!! })
        .customTextInputStyle()

      Row() {
        Button($r('app.string.cancel_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.dialogController) {
              this.dialogController.close();
            }
          })

        Divider()
          .vertical(true)
          .width(SizeToken.SIZE_NUM_16)
          .height(SizeToken.SIZE_NUM_24)
          .color($r('sys.color.comp_divider'))

        Button($r('app.string.confirm_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .enabled(this.textValue2.trim() !== '' && this.textValue1.trim() !== '')
          .onClick(() => {
            if (this.dialogController) {
              this.dialogController.close();
            }
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_40)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    CommonListRow({
      title: $r('app.string.input_dialog_label'),
      onClickAction: () => {
        this.dialogController?.open();
      }
    })
  }
}