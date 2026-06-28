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
import { ChipGroup, ChipGroupItemOptions, ChipSize, SymbolGlyphModifier } from '@kit.ArkUI';
import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { PaddingToken } from '../../../../designtoken/PaddingToken';

const TAG = 'TabTypeChip';

@ComponentV2
export struct TabTypeChip {
  // Bind index array for multi-select state
  @Local selectedIndex: number[] = [];

  build() {
    Column() {
      SubTitleView($r('app.string.tab_type_chip_label'))

      ChipGroup({
        items: this.getChipItems(),
        // Set Chip's style property
        itemStyle: {
          size: ChipSize.SMALL,
          backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
          fontColor: $r('sys.color.ohos_id_color_text_primary'),
          selectedBackgroundColor: $r('sys.color.ohos_id_color_emphasize'),
          selectedFontColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
        },
        selectedIndexes: this.selectedIndex,
        multiple: true,
        // Set horizontal padding and spacing between Chips
        chipGroupSpace: {
          itemSpace: PaddingToken.PADDING_12VP,
          startSpace: PaddingToken.PADDING_0VP,
          endSpace: PaddingToken.PADDING_12VP
        },
        onChange: (activatedChipsIndex: number[]) => {
          Logger.info(TAG, `Chips clicked, activated indexes: ${activatedChipsIndex}`);
        }
      })
    }
  }

  /**
   * ChipGroup data source (array of Chip configs)
   * @returns ChipGroupItemOptions array
   */
  private getChipItems(): ChipGroupItemOptions[] {
    let items: ChipGroupItemOptions[] = [];
    for (let i = 0; i < 9; i++) {
      items.push({
        prefixSymbol: {
          normal: this.getPrefixSymbol(),
          activated: this.getPrefixSymbol([$r('sys.color.icon_on_secondary')])
        },
        label: { text: `Chips` },
        allowClose: false
      });
    }
    return items;
  }

  /**
   * Extract reusable prefix icon decorator
   * @param color icon's color
   * @returns Prefix icon object (SymbolGlyphModifier type)
   */
  private getPrefixSymbol(color: ResourceColor[] = [$r('sys.color.icon_secondary')]): SymbolGlyphModifier {
    return new SymbolGlyphModifier($r('sys.symbol.star'))
      .fontSize($r('sys.float.Subtitle_M'))
      .fontColor(color);
  }
}