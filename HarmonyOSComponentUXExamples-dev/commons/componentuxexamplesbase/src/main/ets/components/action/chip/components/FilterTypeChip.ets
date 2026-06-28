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
import { util } from '@kit.ArkTS';
import { SubTitleView } from '../../../../common/SubTitleView';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { CommonConstants } from '../../../../constants/CommonConstants';

const TAG = 'FilterTypeChip';

// Define data structure for API response
interface FilterDataType {
  id?: string;
  label: string;
  allowClose: boolean;
}

@ObservedV2
class FilterData {
  public readonly id: string;
  @Trace public label: string;
  @Trace public allowClose: boolean;

  constructor(param: FilterDataType) {
    // Generate a unique ID if not provided by the backend
    this.id = param.id ?? util.generateRandomUUID(true);
    this.label = param.label;
    this.allowClose = param.allowClose;
  }
}

@ComponentV2
export struct FilterTypeChip {
  // Manage the original data source for the filter chips
  @Local filterList: FilterData[] = [
    new FilterData({ label: 'Jade', allowClose: false }),
    new FilterData({ label: 'Jack', allowClose: false }),
    new FilterData({ label: 'lucy', allowClose: true })
  ];
  // Track the currently selected indexes to dynamically update suffix icons
  @Local selectedIndexes: number[] = [2];

  /**
   * Core mapping logic: Converts business data into the configuration items required by ChipGroup.
   * Directly binds the close action callback for each item during the conversion process.
   * @returns Array of ChipGroupItemOptions
   */
  @Computed
  private get chipGroupItems(): ChipGroupItemOptions[] {
    let items: ChipGroupItemOptions[] = [];
    for (let i = 0; i < this.filterList.length; i++) {
      let item = this.filterList[i];
      // Check if the current chip is activated
      let isActivated = this.selectedIndexes.includes(i);

      const curChipGroupItemOption: ChipGroupItemOptions = {
        label: { text: item.label },
        suffixSymbol: {
          // Show the suffix close icon only when the chip is activated
          normal: isActivated ? this.getSuffixSymbol() : undefined,
          activated: isActivated ? this.getSuffixSymbol([$r('sys.color.icon_on_secondary')]) : undefined
        },
        // Bind the close event only if the item is activated
        suffixSymbolOptions: isActivated ? {
          action: () => {
            this.removeItem(item.id);
          }
        } : undefined
      };
      items.push(curChipGroupItemOption);
    }
    return items;
  }

  build() {
    Column() {
      // Display the component title
      SubTitleView($r('app.string.filter_type_chip_label'))

      Column() {
        Row() {
          // Left side: Fixed prefix text
          Text('To: ')
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_secondary'))
            .margin({ right: PaddingToken.PADDING_4VP })

          // Middle: ChipGroup component occupying the remaining horizontal space
          // using layoutWeight to allow horizontal scrolling if items exceed the screen width
          ChipGroup({
            items: this.chipGroupItems,
            itemStyle: {
              size: ChipSize.SMALL,
              backgroundColor: $r('sys.color.comp_background_tertiary'),
              fontColor: $r('sys.color.font_primary'),
            },
            chipGroupSpace: {
              itemSpace: PaddingToken.PADDING_8VP,
              startSpace: PaddingToken.PADDING_4VP,
              endSpace: PaddingToken.PADDING_4VP
            },
            // Bind the selectedIndexes to track selection changes
            selectedIndexes: this.selectedIndexes,
            multiple: false,
            onChange: (activatedChipsIndex: number[]) => {
              // Update local state to trigger UI refresh for suffix icons
              this.selectedIndexes = activatedChipsIndex;
              Logger.info(TAG, `chips on clicked, activated index: ${activatedChipsIndex}`);
            }
          })
            .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

          // Right side: Global clear icon to remove all items at once
          if (this.filterList.length > 0) {
            SymbolGlyph($r('sys.symbol.xmark'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_primary')])
              .onClick(() => {
                this.clearAll();
              })
          }
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_56)
        .alignItems(VerticalAlign.Center)

        // Bottom underline divider
        Divider()
          .color($r('sys.color.comp_divider'))
      }
      .width(SizeToken.SIZE_PERCENT_100)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  /**
   * Extract reusable suffix icon decorator
   * @param color icon's color array
   * @returns suffix icon object (SymbolGlyphModifier type)
   */
  private getSuffixSymbol(color: ResourceColor[] = [$r('sys.color.icon_secondary')]): SymbolGlyphModifier {
    return new SymbolGlyphModifier($r('sys.symbol.xmark'))
      .fontSize($r('sys.float.Subtitle_M'))
      .fontColor(color);
  }

  /**
   * Remove a specific item by its ID
   * @param id The unique identifier of the item to remove
   */
  private removeItem(id: string) {
    const index = this.filterList.findIndex(d => d.id === id);
    if (index !== -1) {
      this.filterList.splice(index, 1);
      // Clear selected state after removing the currently activated item
      this.selectedIndexes = [];
      Logger.info(TAG, `Item [${id}] removed.`);
    }
  }

  /**
   * Clear all items in the filter list
   */
  private clearAll() {
    this.filterList = [];
    // Also clear the selected indexes state
    this.selectedIndexes = [];
    Logger.info(TAG, 'All items cleared.');
  }
}