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

import { ChipGroup, SymbolGlyphModifier } from '@kit.ArkUI';
import { Logger, SizeToken } from 'componentuxexamplesbase';

const TAG = 'TabChip';

@Builder
export function TabChip() {
  Column() {
    ChipGroup({
      // Each object within items sets the specific properties of each Chip
      items: [
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
        {
          prefixSymbol: {
            normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')]),
            activated: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
              .fontSize(SizeToken.SIZE_NUM_22)
              .fontColor([$r('sys.color.icon_primary')])
          },
          label: { text: 'Chips' },
        },
      ],

      // Set the style property of the Chip
      itemStyle: {
        backgroundColor: $r('sys.color.comp_background_tertiary'),
        selectedBackgroundColor: $r('app.color.chip_pressed_color'),
      },
      multiple: false,
      onChange: (activatedChipsIndex: number[]) => {
        Logger.info(TAG, `chips on clicked, activated index ${activatedChipsIndex}`);
      },
    })
  }
}