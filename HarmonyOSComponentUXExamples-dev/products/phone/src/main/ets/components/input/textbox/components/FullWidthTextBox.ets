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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { TextBoxStorage } from '../model/TextBoxStorage';

const TAG = 'FullWidthTextBox';

@ComponentV2
export struct FullWidthTextBox {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private storage: TextBoxStorage = TextBoxStorage.getInstance();
  private controller: TextAreaController = new TextAreaController();

  aboutToAppear(): void {
    this.storage.text = 'A'.repeat(50);
  }

  build() {
    Column() {
      SubTitleView($r('app.string.full_width_text_box_label'))

      Row() {
        Column({ space: SpaceToken.SPACE_16 }) {
          TextArea({
            text: this.storage.text!!,
            placeholder: $r('app.string.textarea_placeholder_label_1'),
            controller: this.controller
          })
            .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
            .width(SizeToken.SIZE_PERCENT_100)
            .constraintSize({ maxHeight: SizeToken.SIZE_NUM_72 })
            .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              Logger.info(TAG, `The content of the input field is: ${value}`);
            })

          Text($r('app.string.view_example_label'))
            .fontColor($r('sys.color.icon_emphasize'))
            .fontSize($r('sys.float.Caption_M'))
            .fontWeight(FontWeight.Medium)
            .margin({ right: PaddingToken.PADDING_16VP })
            .onClick(() => {
              this.navPathStack.pushPath({
                name: CommonConstants.FULL_WIDTH_DETAIL_TEXT_BOX_NAME,
                param: this.storage
              });
            })
        }
        .alignItems(HorizontalAlign.End)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding({
        top: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })
      .margin({ bottom: PaddingToken.PADDING_12VP })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}