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
import { SubHeaderV2, SubHeaderV2OperationItem, SubHeaderV2OperationType, SubHeaderV2Title } from '@kit.ArkUI';

const TAG = 'WithOneButton';

@ComponentV2
export struct WithOneButton {
  // Title Settings
  private title: SubHeaderV2Title = new SubHeaderV2Title({
    // Level one Title Content
    primaryTitle: $r('app.string.sub_header_label')
  });
  private operationItems: SubHeaderV2OperationItem[] = [
    new SubHeaderV2OperationItem({
      // Text content of the right-side action button
      content: 'Action',
      // Right-side operation button click time callback
      action: () => {
        Logger.info(TAG, 'WithOneButton button clicked');
      }
    })
  ];

  build() {
    SubHeaderV2({
      // Set title configuration options
      title: this.title,
      // Set the operation button type to a text button (without a right arrow)
      operationType: SubHeaderV2OperationType.BUTTON,
      // Set operating area
      operationItems: this.operationItems
    })
  }
}