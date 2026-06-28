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
export struct GridSingleSelection {
  // Record currently selected index
  @Local selectedIndex: number = 0;
  // Define data source
  @Local gridData: GridItemData[] = [
    new GridItemData({ id: 'grid_item_0', value: 0 }),
    new GridItemData({ id: 'grid_item_1', value: 1 }),
    new GridItemData({ id: 'grid_item_2', value: 2 })
  ];

  build() {
    Column() {
      SubTitleView($r('app.string.grid_single_selection_style_label'))

      Grid() {
        Repeat<GridItemData>(this.gridData)
          .each((obj: RepeatItem<GridItemData>) => {
            GridItem() {
              Stack({ alignContent: Alignment.Bottom }) {
                // Card body background
                Column() {
                }
                .width(SizeToken.SIZE_PERCENT_100)
                .height(SizeToken.SIZE_PERCENT_100)
                .backgroundColor($r('sys.color.background_secondary'))
                .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

                Checkbox()
                  .shape(CheckBoxShape.ROUNDED_SQUARE)
                  .select(this.selectedIndex === obj.index)
                  // Prevent Checkbox from intercepting clicks,
                  // ensuring clicks anywhere on the card trigger GridItem's onClick
                  .hitTestBehavior(HitTestMode.None)
                  .margin({ bottom: SpaceToken.SPACE_10 })
              }
              .width(SizeToken.SIZE_PERCENT_100)
              .height(SizeToken.SIZE_PERCENT_100)
            }
            // Bind click event uniformly on GridItem to expand hit area
            .onClick(() => {
              this.selectedIndex = obj.index;
            })
          })
          .key((item: GridItemData) => item.id)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_221)
      .scrollBar(BarState.Off)
      .columnsGap(SpaceToken.SPACE_12)
      .columnsTemplate(CommonConstants.COLUMNS_TEMPLATE_3)
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
}