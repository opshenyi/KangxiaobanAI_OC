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

import { LengthMetrics, SymbolGlyphModifier } from '@kit.ArkUI';
import { CornerRadiusToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct IconStyledMenu {
  @Local startIconModifier: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_circle_fill')).fontSize($r('sys.float.Title_M'));

  @Builder
  iconStyledMenuBuilder() {
    Menu() {
      MenuItem({ symbolStartIcon: this.startIconModifier, content: $r('app.string.menu_item_label') })
      MenuItem({ symbolStartIcon: this.startIconModifier, content: $r('app.string.menu_item_label') })
      MenuItem({ symbolStartIcon: this.startIconModifier, content: $r('app.string.menu_item_label') })
      MenuItem({ symbolStartIcon: this.startIconModifier, content: $r('app.string.menu_item_label') })
    }
    .width($r('app.float.menu_width'))
    .menuItemDivider({
      strokeWidth: LengthMetrics.vp(SizeToken.SIZE_NUM_1),
      color: $r('sys.color.comp_background_tertiary'),
      mode: DividerMode.EMBEDDED_IN_MENU
    })
  }

  build() {
    ListItem() {
      Row() {
        Text($r('app.string.with_icon_styled_menu_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.list_item_text_size'))
          .fontWeight(FontWeight.Medium)

        Blank()

        Row() {
          Text($r('app.string.pull_down_button_label'))
            .fontSize($r('app.float.list_group_title_text_size'))
            .fontColor($r('sys.color.font_secondary'))
            .margin({ right: $r('sys.float.padding_level3') })

          SymbolGlyph($r('sys.symbol.arrowtriangle_down_fill'))
            .fontSize($r('sys.float.Body_L'))
            .fontColor([$r('app.color.pull_down_arrow_color')])
        }
        .hoverEffect(HoverEffect.Highlight)
        .bindMenu(this.iconStyledMenuBuilder())
      }
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .width(SizeToken.SIZE_PERCENT_100)
      .height($r('app.float.item_height_M'))
      .padding({
        left: $r('sys.float.padding_level8'),
        right: $r('sys.float.padding_level8')
      })
      .borderWidth(SizeToken.SIZE_NUM_1)
      .borderColor($r('app.color.item_border_color'))
      .backgroundColor($r('app.color.item_background_color'))
    }
  }
}