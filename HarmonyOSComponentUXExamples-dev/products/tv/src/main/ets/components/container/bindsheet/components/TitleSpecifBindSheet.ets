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

import { CommonConstants, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';
import { ListGroupTitle } from '../../../common/ListGroupTitle';
import { SheetContentBuilder } from './SheetContentBuilder';

@ComponentV2
export struct TitleSpecifBindSheet {
  @Local isShowSingleLineSheet: boolean = false;
  @Local isShowDoubleLineSheet: boolean = false;
  @Local isShowSecondPageSheet: boolean = false;

  @Builder
  CustomSheetBuilder() {
    Column({ space: SpaceToken.SPACE_16 }) {
      Row() {
        Button({ type: ButtonType.Circle }) {
          SymbolGlyph($r('sys.symbol.chevron_backward'))
            .fontColor([$r('sys.color.font_primary')])
            .fontSize($r('app.float.symbol_size_large'))
        }
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .height($r('app.float.backward_icon_size'))
        .width($r('app.float.backward_icon_size'))
        .margin({ right: SpaceToken.SPACE_16 })
        .borderWidth(SizeToken.SIZE_NUM_1)
        .borderColor($r('app.color.item_border_color'))

        Text($r('app.string.title_label'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.sub_nav_title_text_size'))
      }
      .height($r('app.float.nav_title_height'))
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .width(SizeToken.SIZE_PERCENT_100)

      Column()
        .width(SizeToken.SIZE_PERCENT_100)
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .backgroundColor($r('app.color.sheet_content_background_color'))
    }
    .margin({
      left: PaddingToken.PADDING_32VP,
      right: PaddingToken.PADDING_32VP,
      bottom: PaddingToken.PADDING_32VP,
      top: PaddingToken.PADDING_16VP
    })
  }

  build() {
    Column() {
      ListGroupTitle($r('app.string.title_specif_label'))
      Column({ space: SpaceToken.SPACE_16 }) {
        CommonItem({ val: $r('app.string.single_line_title_label') })
          .onClick(() => {
            this.isShowSingleLineSheet = !this.isShowSingleLineSheet;
          })
          .bindSheet(this.isShowSingleLineSheet!!, SheetContentBuilder(), {
            height:$r('app.float.window_width_sheet_height'),

            showClose: true,
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
        CommonItem({ val: $r('app.string.double_line_title_label') })
          .onClick(() => {
            this.isShowDoubleLineSheet = !this.isShowDoubleLineSheet;
          })
          .bindSheet(this.isShowDoubleLineSheet!!, SheetContentBuilder(), {
            height:$r('app.float.window_width_sheet_height'),
            showClose: true,
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label'), subtitle: $r('app.string.sub_title_label') },
            enableOutsideInteractive: false
          })

        CommonItem({ val: $r('app.string.sub_page_title_label') })
          .onClick(() => {
            this.isShowSecondPageSheet = !this.isShowSecondPageSheet;
          })
          .bindSheet(this.isShowSecondPageSheet!!, this.CustomSheetBuilder(), {
            height:$r('app.float.window_width_sheet_height'),
            showClose: true,
            backgroundColor: $r('app.color.sheet_background_color'),
            enableOutsideInteractive: false
          })
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}