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

import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { GRID_CONTENT_DATA_LIST } from '../constant/GridConstant';
import { GridItemData } from '../model/GridData';

@ComponentV2
export struct ContentTypeGrid {
  build() {
    Column() {
      Grid() {
        Repeat<GridItemData>(GRID_CONTENT_DATA_LIST)
          .each((repeatItem: RepeatItem<GridItemData>) => {
            GridItem() {
              Column() {
                Image(repeatItem.item.imageRes)
                  .width(SizeToken.SIZE_PERCENT_100)
                  .aspectRatio(CommonConstants.INTEGER_1)
                  .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
                Text(repeatItem.item.title)
                  .fontColor($r('sys.color.font_primary'))
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('app.float.content_text_size16'))
                  .margin({
                    top: PaddingToken.PADDING_6VP,
                    bottom: PaddingToken.PADDING_2VP
                  })
                Text(repeatItem.item.subtitle)
                  .fontColor($r('sys.color.font_tertiary'))
                  .fontSize($r('app.float.content_text_size14'))
              }
              .alignItems(HorizontalAlign.Start)
            }
          })
      }
      // Set the number of columns in the current grid layout
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(PaddingToken.PADDING_8VP)
      .width(SizeToken.SIZE_PERCENT_100)
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .padding(PaddingToken.PADDING_16VP)
  }
}