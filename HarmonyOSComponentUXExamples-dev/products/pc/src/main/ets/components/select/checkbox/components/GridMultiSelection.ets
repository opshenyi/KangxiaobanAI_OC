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
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';
import { GridItemData } from '../common/GridItemData';

@ComponentV2
export struct GridMultiSelection {
  // Use an array to manage the state of multiple selected indices
  // Initialized to match the selected items(indices 1, 4, 6, 11)
  @Local selectedIndices: number[] = [1, 4, 6, 11];
  // Define data source for a 4x3 grid (12 items total based on the reference image)
  @Local gridData: GridItemData[] = [];

  aboutToAppear(): void {
    if (this.gridData.length === 0) {
      for (let i = 0; i < 12; i++) {
        this.gridData.push(new GridItemData({ value: i }));
      }
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.grid_multi_selection_style_label'))

      Grid() {
        // Use Repeat instead of ForEach for high-performance list rendering
        Repeat<GridItemData>(this.gridData)
          .each((obj: RepeatItem<GridItemData>) => {
            GridItem() {
              // Centered alignment based on the reference image layout
              Stack({ alignContent: Alignment.BottomEnd }) {
                // Card body background
                Column() {
                }
                .width(SizeToken.SIZE_PERCENT_100)
                .height(SizeToken.SIZE_PERCENT_100)
                .backgroundColor($r('sys.color.background_secondary'))
                .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

                Checkbox()
                  .shape(CheckBoxShape.ROUNDED_SQUARE)
                  .select(this.selectedIndices.includes(obj.index))
                  // Prevent the Checkbox from intercepting click events.
                  // This ensures clicking anywhere on the parent card works.
                  .hitTestBehavior(HitTestMode.None)
                  .margin({
                    right: PaddingToken.PADDING_4VP,
                    bottom: PaddingToken.PADDING_4VP
                  })
              }
              .width(SizeToken.SIZE_PERCENT_100)
              // Setting aspect ratio to 1 ensures the grid items remain perfectly square
              .aspectRatio(1)
            }
            // Bind the click event to the GridItem to maximize the interactive hit area
            .onClick(() => {
              const isCurrentlySelected = this.selectedIndices.includes(obj.index);
              this.updateSelection(obj.index, !isCurrentlySelected);
            })
          })
          .key((item: GridItemData) => item.id)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .scrollBar(BarState.Off)
      // Reference image shows a 4-column layout
      .columnsTemplate(CommonConstants.COLUMNS_TEMPLATE_4)
      // Minimal gap configuration to match the tight grid shown in the image
      .columnsGap(SpaceToken.SPACE_4)
      .rowsGap(SpaceToken.SPACE_4)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .padding({
        left: PaddingToken.PADDING_12VP,
        top: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_16VP
      })
    }
  }

  /**
   * Encapsulates the logic for toggling selection state.
   */
  private updateSelection(index: number, willSelect: boolean) {
    const pos = this.selectedIndices.indexOf(index);
    if (willSelect && pos === -1) {
      // If intended to select and not currently in the array, add it
      this.selectedIndices.push(index);
    } else if (!willSelect && pos !== -1) {
      // If intended to deselect and currently in the array, remove it
      this.selectedIndices.splice(pos, 1);
    }
  }
}