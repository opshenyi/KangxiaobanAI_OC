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

import { Logger } from 'componentuxexamplesbase';
import {
  SubHeaderV2,
  SubHeaderV2OperationItem,
  SubHeaderV2OperationType,
  SubHeaderV2Select
} from '@kit.ArkUI';

const TAG = 'WithSelectButton';

@ComponentV2
export struct WithSelectButton {
  @Local selectedValue: string = 'Select Menu';
  @Local selectedIndex: number = 0;
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
  private select: SubHeaderV2Select = new SubHeaderV2Select({
    options: [
      { value: 'SelectOption1' },
      { value: 'SelectOption2' },
      { value: 'SelectOption3' }
    ],
    // Set the content value of the dropdown menu item
    selectedContent: this.selectedValue,
    // Set the index value of the dropdown menu item
    selectedIndex: this.selectedIndex,
    onSelect: (index: number, value?: string) => {
      Logger.info(TAG, `WithSelectButton selected index: ${index}, value: ${value}`);
    }
  })

  build() {
    SubHeaderV2({
      // Set dropdown options
      select: this.select,
      // Set the action button as an icon button
      operationType: SubHeaderV2OperationType.ICON_GROUP,
      // Set operating area
      operationItems: this.operationItems
    })
  }
}