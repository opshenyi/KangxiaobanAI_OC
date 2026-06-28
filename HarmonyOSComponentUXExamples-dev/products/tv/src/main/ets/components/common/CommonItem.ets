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

@ComponentV2
export struct CommonItem {
  @Param val: ResourceStr = '';
  @Param hint: ResourceStr = '';
  @Local isHovered: boolean = false;

  build() {
    Row() {
      Text(this.val)
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('app.float.list_item_text_size'))
        .fontWeight(FontWeight.Medium)

      Blank()

      if (this.hint !== '') {
        Text(this.hint)
          .fontSize($r('app.float.list_group_title_text_size'))
          .fontColor($r('sys.color.font_secondary'))
          .margin({ right: $r('sys.float.padding_level8') })
      }

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize(SizeToken.SIZE_NUM_32)
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .width(SizeToken.SIZE_PERCENT_100)
    .height($r('app.float.item_height_M'))
    .padding({
      left: $r('sys.float.padding_level8'),
      right: $r('sys.float.padding_level8')
    })
    .hoverEffect(HoverEffect.Scale)
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .animation({ duration: CommonConstants.DURATION_200, curve: Curve.EaseOut })
    .backgroundColor(this.isHovered
      ? $r('app.color.item_background_hover_color')
      : $r('app.color.item_background_color'))
    .onHover((isHover: boolean) => {
      this.isHovered = isHover;
    })
    .stateStyles({
      pressed: {
        .backgroundColor($r('app.color.item_background_highlight_color'))
      }
    })
  }
}