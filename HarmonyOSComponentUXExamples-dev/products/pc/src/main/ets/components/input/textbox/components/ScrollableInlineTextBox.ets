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

import { CommonUtils } from 'componentuxexamplesbase';
import { CommonTextBoxGroup } from '../common/CommonTextBoxGroup';
import { FileItemModel } from '../model/FileItemModel';
import { FileItemInputMode, FileItemLayoutMode } from '../model/TextBoxConfig';

@ComponentV2
export struct ScrollableInlineTextBox {
  @Local fileList: FileItemModel[] = [];

  aboutToAppear(): void {
    const ctx = this.getUIContext()?.getHostContext();
    if (this.fileList.length === 0) {
      for (let i = 0; i < 4; i++) {
        this.fileList.push(new FileItemModel({
          fileName: CommonUtils.getStrFromResource(ctx, $r('app.string.file4_name_label')).repeat(3),
          icon: $r('sys.media.ohos_ic_normal_white_grid_folder')
        }));
      }
    }
  }

  build() {
    CommonTextBoxGroup({
      title: $r('app.string.inline_input_with_scrollbar_style_label'),
      fileList: this.fileList,
      layoutMode: FileItemLayoutMode.LIST_ROW,
      inputMode: FileItemInputMode.SCROLLABLE_INLINE
    })
  }
}