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

import { CommonConstants, CornerRadiusToken, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { SubHeaderV2, SubHeaderV2OperationItem, SubHeaderV2OperationType, SubHeaderV2Title } from '@kit.ArkUI';

const TAG = 'ContentSubHeader';

@ComponentV2
export struct ContentSubHeader {
  // Title Settings
  private title: SubHeaderV2Title = new SubHeaderV2Title({
    // Level one Title Content
    primaryTitle: $r('app.string.sub_header_label')
  });
  private operationItems: SubHeaderV2OperationItem[] = [
    new SubHeaderV2OperationItem({
      // Text content of the right-side action button
      content: $r('app.string.more_label'),
      // Right-side operation button click time callback
      action: () => {
        Logger.info(TAG, 'ListSubHeader button clicked');
      }
    })
  ];
  @Local dataArr: number[] = [];

  aboutToAppear(): void {
    for (let i = CommonConstants.INTEGER_1; i <= CommonConstants.INTEGER_8; i++) {
      this.dataArr.push(i);
    }
  }

  build() {
    Column() {
      SubHeaderV2({
        // Set title configuration options
        title: this.title,
        // Set the operation button type to a text button (with a right arrow)
        operationType: SubHeaderV2OperationType.TEXT_ARROW,
        // Set operating area
        operationItems: this.operationItems
      })

      List({ space: PaddingToken.PADDING_16VP }) {
        Repeat<number>(this.dataArr)
          .each((item: RepeatItem<number>) => {
            ListItem() {
              Stack()
                .width(SizeToken.SIZE_NUM_108)
                .height(SizeToken.SIZE_NUM_108)
                .backgroundColor($r('app.color.item_background_color'))
                .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                .margin({ left: item.index === 0 ? PaddingToken.PADDING_16VP : 0 })
            }
          })
      }
      .scrollBar(BarState.Off)
      .width(SizeToken.SIZE_PERCENT_100)
      .listDirection(Axis.Horizontal)
      .height(SizeToken.SIZE_NUM_108)
      .clip(false)

      SubHeaderV2({
        // Set title configuration options
        title: this.title,
        // Set the operation button type to a text button (with a right arrow)
        operationType: SubHeaderV2OperationType.TEXT_ARROW,
        // Set operating area
        operationItems: this.operationItems
      })

      List({ space: PaddingToken.PADDING_16VP }) {
        Repeat<number>(this.dataArr)
          .each(() => {
            ListItem() {
              Stack()
                .width(SizeToken.SIZE_PERCENT_100)
                .height(SizeToken.SIZE_NUM_254)
                .backgroundColor($r('app.color.item_background_color'))
                .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
            }
          })
      }
      .scrollBar(BarState.Off)
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .edgeEffect(EdgeEffect.None)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .padding({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_16VP
      })
      .clip(false)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('app.color.title_background_color'))
    .padding({
      left: PaddingToken.PADDING_40VP,
      right: PaddingToken.PADDING_40VP
    })
  }
}