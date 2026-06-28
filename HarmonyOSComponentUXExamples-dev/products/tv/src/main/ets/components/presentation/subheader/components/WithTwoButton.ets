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
  SubHeaderV2,
  SubHeaderV2OperationItem,
  SubHeaderV2OperationType,
  SubHeaderV2Title,
  SymbolGlyphModifier
} from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';

const TAG = 'WithTwoButton';

@ComponentV2
export struct WithTwoButton {
  // Title Settings
  private title: SubHeaderV2Title = new SubHeaderV2Title({
    // Level one Title Content
    primaryTitle: $r('app.string.sub_header_label')
  });
  private operationItems: SubHeaderV2OperationItem[] = [
    new SubHeaderV2OperationItem({
      // Operation button icon
      content: new SymbolGlyphModifier($r('sys.symbol.plus')),
      // Right-side operation button click time callback
      action: () => {
        Logger.info(TAG, 'WithTwoButton button1 clicked');
      }
    }),
    new SubHeaderV2OperationItem({
      content: new SymbolGlyphModifier($r('sys.symbol.dot_grid_2x2')),

      action: () => {
        Logger.info(TAG, 'WithTwoButton button2 clicked');
      }
    })
  ];

  build() {
    SubHeaderV2({
      // Set title configuration options
      title: this.title,
      // Set the action button as an icon button
      operationType: SubHeaderV2OperationType.ICON_GROUP,
      // Set operating area
      operationItems: this.operationItems
    })
  }
}