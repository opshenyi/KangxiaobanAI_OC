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
import { CommonConstants } from '../../../../constants/CommonConstants';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';
import { GridCardStyleModifier } from '../common/CommonStyles';
import { GridItemData } from '../model/GridData';

@ComponentV2
export struct ContentTypeGrid {
  @Local gridData: GridItemData[] = [];

  aboutToAppear(): void {
    if (this.gridData.length === 0) {
      this.gridData = [
        new GridItemData({ imageRes: $r('app.media.img_5') }),
        new GridItemData({ imageRes: $r('app.media.img_4') }),
        new GridItemData({ imageRes: $r('app.media.img_3') }),
        new GridItemData({ imageRes: $r('app.media.img_2') })
      ];
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.content_type_grid_label'))

      Column() {
        Grid() {
          Repeat<GridItemData>(this.gridData)
            .each((itemWrap: RepeatItem<GridItemData>) => {
              GridItem() {
                Column() {
                  Image(itemWrap.item.imageRes)
                    .width(SizeToken.SIZE_PERCENT_100)
                    .aspectRatio(CommonConstants.INTEGER_1)
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

                  Text(itemWrap.item.title)
                    .fontColor($r('sys.color.font_primary'))
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_M'))
                    .margin({
                      top: PaddingToken.PADDING_6VP,
                      bottom: PaddingToken.PADDING_2VP
                    })

                  Text(itemWrap.item.subtitle)
                    .fontColor($r('sys.color.font_secondary'))
                    .fontSize($r('sys.float.Caption_L'))
                    .fontWeight(FontWeight.Regular)
                }
                .alignItems(HorizontalAlign.Start)
              }
            })
            .key((item) => item.id)
        }
        .columnsTemplate(CommonConstants.COLUMNS_TEMPLATE_4)
        .width(SizeToken.SIZE_PERCENT_100)
        .rowsGap(SpaceToken.SPACE_12)
        .columnsGap(SpaceToken.SPACE_8)
        .scrollBar(BarState.Off)
      }
      .attributeModifier(new GridCardStyleModifier())
    }
  }
}