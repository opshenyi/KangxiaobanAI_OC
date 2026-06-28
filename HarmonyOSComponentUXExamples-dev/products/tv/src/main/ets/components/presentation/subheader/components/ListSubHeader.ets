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

import { CommonConstants, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';
import { SubHeaderV2, SubHeaderV2OperationItem, SubHeaderV2OperationType, SubHeaderV2Title } from '@kit.ArkUI';

const TAG = 'ListSubHeader';

@ComponentV2
export struct ListSubHeader {
  // Title Settings
  private title: SubHeaderV2Title = new SubHeaderV2Title({
    // Secondary title content
    secondaryTitle: 'Subheading'
  });
  private operationItems: SubHeaderV2OperationItem[] = [
    new SubHeaderV2OperationItem({
      // Text content of the right-side action button
      content: 'More',
      // Right-side operation button click time callback
      action: () => {
        Logger.info(TAG, 'PrimaryTitleHeader button clicked');
      }
    })
  ];

  build() {
    Column() {
      SubHeaderV2({
        // Set title configuration options
        title: this.title,
        // Set the action button to a text button (with right arrow)
        operationType: SubHeaderV2OperationType.TEXT_ARROW,
        // Set operating area
        operationItems: this.operationItems
      })

      List({ space: PaddingToken.PADDING_16VP }) {
        ListItem() {
          CommonItem({ val: 'Single lit' })
        }

        ListItem() {
          CommonItem({ val: 'Single lit' })
        }

        ListItem() {
          CommonItem({ val: 'Single lit' })
        }

        ListItem() {
          CommonItem({ val: 'Single lit' })
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      // The height of the List is the height of a ListItem multiplied by the quantity,
      // and plus the total spacing between ListItems.
      .height(SizeToken.SIZE_NUM_64 * CommonConstants.INTEGER_4 + PaddingToken.PADDING_16VP * CommonConstants.INTEGER_3)
      .clip(false)
      .padding({
        left: PaddingToken.PADDING_32VP,
        right: PaddingToken.PADDING_32VP
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP
    })
  }
}