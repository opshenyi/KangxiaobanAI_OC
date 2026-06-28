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

import { SizeToken } from 'componentuxexamplesbase';

@Builder
export function SubNavTitleWithBack(onClickCallback:()=>void) {
  Column() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.chevron_backward'))
          .fontColor([$r('sys.color.font_primary')])
          .fontSize($r('app.float.symbol_size_large'))
      }
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .height($r('app.float.backward_icon_size'))
      .width($r('app.float.backward_icon_size'))
      .margin({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding')
      })
      .borderWidth(SizeToken.SIZE_NUM_1)
      .borderColor($r('app.color.item_border_color'))
      .onClick(()=>{
        onClickCallback();
      })
    }
    .height($r('app.float.nav_title_height'))
    .width(SizeToken.SIZE_PERCENT_100)
    .margin({ top: $r('app.float.nav_title_margin_top') })
    .alignItems(VerticalAlign.Center)
  }
  .alignItems(HorizontalAlign.Start)
  .width(SizeToken.SIZE_PERCENT_100)
}