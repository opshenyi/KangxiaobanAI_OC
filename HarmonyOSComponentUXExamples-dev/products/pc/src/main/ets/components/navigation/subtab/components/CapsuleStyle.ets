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
  ChipGroup,
  ChipGroupItemOptions,
  ChipGroupSpaceOptions,
  ChipItemStyle,
  ChipSize,
  IconGroupSuffix,
  SymbolGlyphModifier
} from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { CommonUtils, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'CapsuleStyle';

// Extract static data and configurations (Separation of Data and UI)
const COMMON_CHIP_STYLE: ChipItemStyle = {
  size: ChipSize.NORMAL,
  backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
  fontColor: $r('sys.color.ohos_id_color_text_primary'),
  selectedBackgroundColor: $r('sys.color.ohos_id_color_emphasize'),
  selectedFontColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
};

const COMMON_CHIP_SPACE: ChipGroupSpaceOptions = {
  itemSpace: SpaceToken.SPACE_8,
  startSpace: SpaceToken.SPACE_0
};

// Data source for default single-selection and icon-prefixed single-selection
const MOCK_SINGLE_ITEMS: ChipGroupItemOptions[] = [
  { label: { text: 'Tab Bar' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false }
];

// Data source for multiple-selection
const MOCK_MULTIPLE_ITEMS: ChipGroupItemOptions[] = [
  { label: { text: 'Select One' }, allowClose: false },
  { label: { text: 'Select Two' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false },
  { label: { text: 'Title' }, allowClose: false }
];

@ComponentV2
export struct CapsuleStyle {
  // Keep Symbol resource instantiation within the component to ensure the correct context
  @Local prefixModifierNormal: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
      .fontSize($r('sys.float.Subtitle_M'))
      .fontColor([$r('sys.color.icon_secondary')]);
  @Local prefixModifierActivated: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
      .fontSize($r('sys.float.Subtitle_M'))
      .fontColor([$r('sys.color.icon_on_primary')]);

  @LocalBuilder
  ChipGroupSuffix(): void {
    IconGroupSuffix({
      items: [
        new SymbolGlyphModifier($r('sys.symbol.dot_grid_2x2'))
          .onClick(() => {
            CommonUtils.showToast('The dot button has been clicked currently.');
          })
      ]
    })
  }

  build() {
    Column() {
      // 1. Default Single-Selection Style
      SubTitleView($r('app.string.capsule_style_single_selection_label'))
      Row() {
        ChipGroup({
          items: MOCK_SINGLE_ITEMS,
          itemStyle: COMMON_CHIP_STYLE,
          multiple: false,
          chipGroupSpace: COMMON_CHIP_SPACE,
          chipGroupPadding: { top: PaddingToken.PADDING_10VP, bottom: PaddingToken.PADDING_10VP },
          onChange: (index) => this.handleChipChange('SingleSelection', index),
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({ right: PaddingToken.PADDING_24VP })

      // 2. Single-Selection with Right Suffix Icon
      SubTitleView($r('app.string.capsule_style_single_selection_right_side_icon_label'))
      ChipGroup({
        items: MOCK_SINGLE_ITEMS.slice(0, 6), // Reuse data and slice to the required length
        itemStyle: COMMON_CHIP_STYLE,
        multiple: false,
        chipGroupSpace: {
          itemSpace: SpaceToken.SPACE_8,
          startSpace: SpaceToken.SPACE_0,
          endSpace: SpaceToken.SPACE_0
        },
        chipGroupPadding: { top: PaddingToken.PADDING_10VP, bottom: PaddingToken.PADDING_10VP },
        onChange: (index) => this.handleChipChange('RightSideIcon', index),
        suffix: this.ChipGroupSuffix
      })

      // 3. Multiple-Selection Style
      SubTitleView($r('app.string.capsule_style_multiple_choice_label'))
      Row() {
        ChipGroup({
          items: MOCK_MULTIPLE_ITEMS,
          itemStyle: COMMON_CHIP_STYLE,
          selectedIndexes: [0, 1],
          multiple: true,
          chipGroupSpace: COMMON_CHIP_SPACE,
          chipGroupPadding: { top: SpaceToken.SPACE_10, bottom: SpaceToken.SPACE_10 },
          onChange: (index) => this.handleChipChange('MultipleChoice', index)
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({ right: PaddingToken.PADDING_24VP })

      // 4. Single-Selection with Prefix Icon
      SubTitleView($r('app.string.capsule_style_with_icon_label'))
      Row() {
        ChipGroup({
          items: Array(4).fill(0).map(() => ({
            prefixSymbol: { normal: this.prefixModifierNormal, activated: this.prefixModifierActivated },
            label: { text: 'Title' },
            allowClose: false
          } as ChipGroupItemOptions)),
          itemStyle: COMMON_CHIP_STYLE,
          selectedIndexes: [0],
          multiple: false,
          chipGroupSpace: COMMON_CHIP_SPACE,
          chipGroupPadding: { top: SpaceToken.SPACE_10, bottom: SpaceToken.SPACE_10 },
          onChange: (index) => this.handleChipChange('WithIcon', index)
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({ right: PaddingToken.PADDING_24VP })
    }
    .padding({ left: PaddingToken.PADDING_24VP })
  }

  /**
   * Centralized log handler for easier future maintenance and formatting
   */
  private handleChipChange(scene: string, activatedChipsIndex: number[]): void {
    Logger.info(TAG, `[${scene}] chips on clicked, activated index: ${activatedChipsIndex}`);
  }
}