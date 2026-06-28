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

import { CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { TVConstants } from '../../../../constants/TVConstants';
import { GRID_MENU_DATA_LIST } from '../constant/GridConstant';
import { GridItemData } from '../model/GridData';

@ComponentV2
export struct IconTypeGrid {
  build() {
    Column() {
      Grid() {
        Repeat<GridItemData>(GRID_MENU_DATA_LIST)
          .each((repeatItem: RepeatItem<GridItemData>) => {
            GridItem() {
              Column({ space: PaddingToken.PADDING_6VP }) {
                Stack() {
                  SymbolGlyph(repeatItem.item.imageRes)
                    .fontSize(SizeToken.SIZE_NUM_24)
                    .fontColor([$r('sys.color.font_primary')])
                }
                .height(SizeToken.SIZE_NUM_48)
                .width(SizeToken.SIZE_NUM_48)
                .backgroundColor($r('sys.color.brand'))
                .borderRadius(SizeToken.SIZE_NUM_24)

                Text(repeatItem.item.title)
                  .fontColor($r('sys.color.font_primary'))
                  .lineHeight(SizeToken.SIZE_NUM_19)
                  .fontSize($r('app.float.content_text_size14'))
              }
            }
          })
      }
      // Set the number of columns in the current grid layout
      .columnsTemplate('1fr '.repeat(TVConstants.GRID_MENU_COLUMNS))
      // Set the number of rows in the current grid layout
      .rowsTemplate('1fr 1fr')
      .width(SizeToken.SIZE_PERCENT_100)
      .height($r('app.float.grid_menu_height'))
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .padding(PaddingToken.PADDING_16VP)
  }
}