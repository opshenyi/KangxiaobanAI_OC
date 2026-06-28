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
import { LengthMetrics } from '@kit.ArkUI';
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@Builder
function longPressFloatingMenuBuilder() {
  Menu() {
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
  }
  .menuItemDivider({
    strokeWidth: LengthMetrics.vp(SizeToken.SIZE_NUM_1),
    color: $r('sys.color.comp_background_tertiary'),
    mode: DividerMode.EMBEDDED_IN_MENU
  })
}

@Builder
export function LongPressFloatingMenu() {
  ListItem() {
    Row() {
      Text($r('app.string.long_press_the_floating_menu_label'))
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .bindContextMenu(longPressFloatingMenuBuilder(), ResponseType.LongPress, {
      preview: MenuPreviewMode.IMAGE,
      previewAnimationOptions: { scale: [CommonConstants.FLOAT_0_POINT_8, CommonConstants.FLOAT_1] }
    })
  }
}