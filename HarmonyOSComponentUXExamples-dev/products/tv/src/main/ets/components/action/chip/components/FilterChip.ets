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

import { ChipGroup, ChipGroupItemOptions, SymbolGlyphModifier } from '@kit.ArkUI';
import { CommonConstants, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { util } from '@kit.ArkTS';

const TAG = 'FilterChip';

// Define data structure for API response
interface FilterDataType {
  id?: string;
  label: string;
  allowClose: boolean;
}

@ObservedV2
class FilterData {
  public id: string;
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
export struct FilterChip {
  // Manage the original data source for the filter chips
  @Local filterList: FilterData[] = [
    new FilterData({ label: 'Jade', allowClose: true }),
    new FilterData({ label: 'Jack', allowClose: false }),
    new FilterData({ label: 'lucy', allowClose: false })
  ];
  @Local selectedIndex: number = 0;

  build() {
    Column() {
      Row() {
        // Left side: Fixed prefix text
        Text('To: ')
          .fontSize(SizeToken.SIZE_NUM_22)
          .fontColor($r('sys.color.font_secondary'))
          .margin({ right: PaddingToken.PADDING_4VP })

        // Middle: ChipGroup component occupying the remaining horizontal space
        // using layoutWeight to allow horizontal scrolling if items exceed the screen width
        ChipGroup({
          items: this.getChipGroupItems(),
          // Set the style property of the Chip
          itemStyle: {
            backgroundColor: $r('sys.color.comp_background_tertiary'),
            selectedBackgroundColor: $r('app.color.chip_pressed_color'),
          },
          selectedIndexes: [this.selectedIndex],
          onChange: (activatedChipsIndex: number[]) => {
            if (activatedChipsIndex.length > 0) {
              this.selectedIndex = activatedChipsIndex[0];
              this.refreshItems(this.selectedIndex);
            }
          },
        })
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        // Right side: Global clear icon to remove all items at once
        SymbolGlyph($r('sys.symbol.xmark'))
          .fontSize($r('app.float.symbol_size_large'))
          .fontColor([$r('sys.color.icon_primary')])
          .onClick(() => {
            this.clearAll();
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .alignItems(VerticalAlign.Center)

      // Bottom underline divider
      Divider()
        .color($r('sys.color.comp_divider'))
        .strokeWidth(1)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  /**
   * Core mapping logic: Converts business data into the configuration items required by ChipGroup.
   * Directly binds the close action callback for each item during the conversion process.
   * @returns Array of ChipGroupItemOptions
   */
  private getChipGroupItems(): ChipGroupItemOptions[] {
    let items: ChipGroupItemOptions[] = [];
    for (let item of this.filterList) {
      const curChipGroupItemOption: ChipGroupItemOptions = {
        label: { text: item.label },
        suffixSymbol: {
          normal: item.allowClose ? this.getSuffixSymbol() : undefined,
          activated: item.allowClose ? this.getSuffixSymbol([$r('sys.color.icon_on_secondary')]) : undefined
        },
        // Bind the close event only if the item is allowed to be closed
        suffixSymbolOptions: item.allowClose ? {
          action: () => {
            this.removeItem(item.id);
          }
        } : undefined
      }
      items.push(curChipGroupItemOption);
    }
    return items;
  }

  /**
   * Extract reusable suffix icon decorator
   * @param color icon's color array
   * @returns suffix icon object (SymbolGlyphModifier type)
   */
  private getSuffixSymbol(color: ResourceColor[] = [$r('sys.color.icon_secondary')]): SymbolGlyphModifier {
    return new SymbolGlyphModifier($r('sys.symbol.xmark'))
      .fontSize(SizeToken.SIZE_NUM_16)
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
      Logger.info(TAG, `Item [${id}] removed.`);
    }
  }

  /**
   * Refresh the UI when the selected Chip changes
   * @param index Index value of the selected chip
   */
  private refreshItems(index: number) {
    for (let i = 0; i < this.filterList.length; i++) {
      if (index === i) {
        this.filterList[i].allowClose = true;
      } else {
        this.filterList[i].allowClose = false;
      }
    }
  }

  /**
   * Clear all items in the filter list
   */
  private clearAll() {
    this.filterList = [];
    Logger.info(TAG, 'All items cleared.');
  }
}