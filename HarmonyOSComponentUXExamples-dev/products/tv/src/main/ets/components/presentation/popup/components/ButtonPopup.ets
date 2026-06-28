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

import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';

@ComponentV2
export struct ButtonPopup {
  @Local handlePopup: boolean = false;

  // Popup constructor defines popup content
  @Builder
  popupBuilder() {
    Row({ space: PaddingToken.PADDING_16VP }) {
      Image($r('app.media.startIcon'))
        .height(SizeToken.SIZE_NUM_32)
        .width(SizeToken.SIZE_NUM_32)
      Column() {
        Row() {
          Text($r('app.string.title_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Subtitle_M'))
          Blank()
          Button() {
            SymbolGlyph($r('sys.symbol.xmark'))
              .fontColor([$r('sys.color.font_secondary')])
              .fontSize(SizeToken.SIZE_NUM_32)
          }
          .type(ButtonType.Circle)
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .width(SizeToken.SIZE_NUM_40)
          .height(SizeToken.SIZE_NUM_40)
          .onClick(() => {
            this.handlePopup = !this.handlePopup;
          })
        }
        .width(SizeToken.SIZE_PERCENT_100)

        Text($r('app.string.dialog_content_label'))
          .fontColor($r('sys.color.font_secondary'))
          .fontSize($r('sys.float.Body_M'))
          .margin({
            top: PaddingToken.PADDING_6VP,
            bottom: PaddingToken.PADDING_16VP
          })

        Row({ space: PaddingToken.PADDING_16VP }) {
          Button($r('app.string.text_button_label'))
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_emphasize'))
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.ROUNDED_RECTANGLE)
            .controlSize(ControlSize.SMALL)
            .onClick(() => {
              this.handlePopup = !this.handlePopup;
            })
          Button($r('app.string.text_button_label'))
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_emphasize'))
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.ROUNDED_RECTANGLE)
            .controlSize(ControlSize.SMALL)
            .onClick(() => {
              this.handlePopup = !this.handlePopup;
            })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .padding(PaddingToken.PADDING_16VP)
    .constraintSize({
      maxWidth: SizeToken.SIZE_PERCENT_40
    })
  }

  build() {
    CommonItem({ val: $r('app.string.pointer_style_popup_label') })
      .onClick(() => {
        this.handlePopup = !this.handlePopup;
      })
      .bindPopup(this.handlePopup, {
        builder: this.popupBuilder,
        // Bubble arrow display position relative to parent component
        arrowPointPosition: ArrowPointPosition.START,
        onStateChange: (e) => {
          if (!e.isVisible) {
            this.handlePopup = false;
          }
        }
      })
  }
}