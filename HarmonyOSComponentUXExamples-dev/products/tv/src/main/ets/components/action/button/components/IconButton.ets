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

import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken
} from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@ComponentV2
export struct IconButton {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      ListGroupTitle($r('app.string.icon_button_label'))
      Column() {
        Text($r('app.string.button_type_or_normal_label'))
          .fontSize($r('app.float.list_group_title_text_size'))
          .fontColor($r('sys.color.font_primary'))
          .lineHeight($r('app.float.list_title_line_height'))
          .fontWeight(FontWeight.Medium)
          .height(SizeToken.SIZE_NUM_86)
          .width(SizeToken.SIZE_PERCENT_100)
          .padding({ bottom: PaddingToken.PADDING_16VP })
          .align(Alignment.BottomStart)

        Row() {
          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_on_primary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)

            Text($r('app.string.emphasize_the_background_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }
          .onClick(() => {
            CommonUtils.showToast($r('app.string.emphasize_the_background_label'));
          })

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.font_primary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.NORMAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)

            Text($r('app.string.plain_background_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }
          .onClick(() => {
            CommonUtils.showToast($r('app.string.plain_background_label'));
          })

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.font_primary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)

            Text($r('app.string.icon_only_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }
          .onClick(() => {
            CommonUtils.showToast($r('app.string.icon_only_label'));
          })

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              Column({ space: SpaceToken.SPACE_2 }) {
                SymbolGlyph($r('sys.symbol.bell'))
                  .fontColor([$r('sys.color.font_primary')])
                  .fontSize(SizeToken.SIZE_NUM_32)
                Text('Text')
                  .fontColor($r('sys.color.font_primary'))
                  .fontSize($r('app.float.button_name_text_size'))
                  .lineHeight(SizeToken.SIZE_NUM_24)
              }
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)

            Text($r('app.string.with_text_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }
          .onClick(() => {
            CommonUtils.showToast($r('app.string.with_text_label'));
          })
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({
          top: PaddingToken.PADDING_12VP,
          bottom: PaddingToken.PADDING_32VP
        })

        Text($r('app.string.disabled_status_label'))
          .fontSize($r('app.float.list_group_title_text_size'))
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight($r('app.float.list_title_line_height'))
          .fontWeight(FontWeight.Medium)
          .height(SizeToken.SIZE_NUM_86)
          .width(SizeToken.SIZE_PERCENT_100)
          .padding({ bottom: PaddingToken.PADDING_16VP })
          .align(Alignment.BottomStart)

        Row() {
          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_on_primary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.emphasize_the_background_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.NORMAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.plain_background_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize(SizeToken.SIZE_NUM_32)
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.icon_only_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }

          Column({ space: SpaceToken.SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              Column({ space: SpaceToken.SPACE_2 }) {
                SymbolGlyph($r('sys.symbol.bell'))
                  .fontColor([$r('sys.color.icon_secondary')])
                  .fontSize(SizeToken.SIZE_NUM_32)
                Text('Text')
                  .fontColor($r('sys.color.font_secondary'))
                  .fontSize($r('app.float.button_name_text_size'))
                  .lineHeight(SizeToken.SIZE_NUM_24)
              }
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SizeToken.SIZE_NUM_64)
            .height(SizeToken.SIZE_NUM_64)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.with_text_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('app.float.button_name_text_size'))
              .lineHeight(SizeToken.SIZE_NUM_24)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(SizeToken.SIZE_PERCENT_100)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('app.color.item_background_color'))
      .borderWidth(SizeToken.SIZE_NUM_1)
      .borderColor($r('app.color.item_border_color'))
      .padding({
        left: PaddingToken.PADDING_56VP,
        right: PaddingToken.PADDING_56VP,
        bottom: PaddingToken.PADDING_48VP
      })
    }
  }
}