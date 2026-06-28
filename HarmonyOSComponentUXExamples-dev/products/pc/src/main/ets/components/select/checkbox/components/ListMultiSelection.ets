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
import { CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct ListMultiSelection {
  // Use array to store indices of selected items
  @Local selectedIndex: number[] = [2, 3];
  @Local listHeight: Length = 0;
  private listData: string[] = [
    'Multi list item 1',
    'Multi list item 2',
    'Multi list item 3',
    'Multi list item 4',
    'Multi list item 5'
  ];

  aboutToAppear(): void {
    // Dynamically calculate list height
    this.listHeight =
      this.getUIContext().vp2px(SizeToken.SIZE_NUM_48 * this.listData.length) + 1 * (this.listData.length - 1) + 'px';
  }

  build() {
    Column() {
      SubTitleView($r('app.string.list_multi_selection_style_label'))

      List() {
        ForEach(this.listData, (item: string, index: number) => {
          ListItem() {
            Row() {
              // Left text
              Text(item)
                .fontSize($r('sys.float.Subtitle_M'))
                .fontColor($r('sys.color.font_primary'))
                .fontWeight(FontWeight.Medium)

              // Right side: checkBox
              Checkbox()
                .shape(CheckBoxShape.ROUNDED_SQUARE)
                .select(this.selectedIndex.includes(index))
                .onChange((value: boolean) => {
                  // Update array state when checkbox itself is clicked
                  this.updateSelection(index, value);
                })
            }
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_NUM_48)
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              left: SpaceToken.SPACE_12,
              right: SpaceToken.SPACE_12
            })
          }
          .onClick(() => {
            const isCurrentlySelected = this.selectedIndex.includes(index);
            // Pass the opposite of current state to achieve toggle effect
            this.updateSelection(index, !isCurrentlySelected);
          })
        }, (item: string, index: number) => `${index}_${item}`)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(this.listHeight)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .clip(true)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .divider({
        strokeWidth: SizeToken.SIZE_NUM_1PX,
        color: $r('sys.color.comp_divider'),
        startMargin: PaddingToken.PADDING_12VP,
        endMargin: PaddingToken.PADDING_12VP
      })
    }
  }

  /**
   *  Encapsulate unified selected state update function
   */
  private updateSelection(index: number, willSelect: boolean) {
    const pos = this.selectedIndex.indexOf(index);
    if (willSelect && pos === -1) {
      // If selected and not in array, add it
      this.selectedIndex.push(index);
    } else if (!willSelect && pos !== -1) {
      // If deselected and in array, remove it
      this.selectedIndex.splice(pos, 1);
    }
  }
}