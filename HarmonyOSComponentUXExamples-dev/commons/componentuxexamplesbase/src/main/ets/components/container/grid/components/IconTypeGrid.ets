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
import { SubTitleView } from '../../../../common/SubTitleView';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';
import { GridCardStyleModifier } from '../common/CommonStyles';
import { GridItemData } from '../model/GridData';

@ComponentV2
export struct IconTypeGrid {
  @Local gridData: GridItemData[] = [];

  aboutToAppear(): void {
    if (this.gridData.length === 0) {
      this.gridData = [
        new GridItemData({ imageRes: $r('sys.symbol.star_square_stack_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.heart_square_stack_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.location_north_up_right_circle_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.star_circle_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.ellipsis_message_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.local_circle_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.service_card_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.envelope_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.heart_fill') }),
        new GridItemData({ imageRes: $r('sys.symbol.lightbulb_circle_fill') })
      ];
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.icon_type_grid_label'))

      Column() {
        Grid() {
          Repeat<GridItemData>(this.gridData)
            .each((repeatItem: RepeatItem<GridItemData>) => {
              GridItem() {
                Column({ space: PaddingToken.PADDING_6VP }) {
                  Button({ type: ButtonType.Circle, stateEffect: true }) {
                    SymbolGlyph(repeatItem.item.imageRes)
                      .fontSize($r('sys.float.Title_M'))
                      .fontColor([$r('sys.color.icon_emphasize')])
                  }
                  .height(SizeToken.SIZE_NUM_48)
                  .width(SizeToken.SIZE_NUM_48)
                  .backgroundColor($r('app.color.grid_interactive_select'))

                  Text(repeatItem.item.title)
                    .fontColor($r('sys.color.font_primary'))
                    .lineHeight(SizeToken.SIZE_NUM_19)
                    .fontSize($r('sys.float.Subtitle_S'))
                }
                .width(SizeToken.SIZE_PERCENT_100)
                .alignItems(HorizontalAlign.Center)
              }
            })
            .key((item) => item.id)
        }
        // Use auto-fit to automatically calculate the number of columns, with 64vp as the minimum column width
        // The engine will automatically arrange as many columns as possible with a width >= 64vp
        // based on the container width,
        // and distribute the remaining space evenly among all columns
        .columnsTemplate('repeat(auto-fit, 64)')
        .width(SizeToken.SIZE_PERCENT_100)
        .rowsGap(SpaceToken.SPACE_12)
        .scrollBar(BarState.Off)
      }
      .attributeModifier(new GridCardStyleModifier())
    }
  }
}