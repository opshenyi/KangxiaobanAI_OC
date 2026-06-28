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
export struct MultiInlineTextBox {
  @Local fileList: FileItemModel[] = [];

  aboutToAppear() {
    const ctx = this.getUIContext()?.getHostContext();
    if (this.fileList.length === 0) {
      this.fileList = [
        new FileItemModel({
          fileName: CommonUtils.getStrFromResource(ctx, $r('app.string.file1_name_label')),
          icon: $r('sys.media.ohos_ic_normal_white_grid_folder')
        }),
        new FileItemModel({
          fileName: CommonUtils.getStrFromResource(ctx, $r('app.string.file2_name_label')),
          icon: $r('sys.media.ohos_ic_normal_white_grid_doc')
        }),
        new FileItemModel({
          fileName: CommonUtils.getStrFromResource(ctx, $r('app.string.file3_name_label')),
          icon: $r('sys.media.ohos_ic_normal_white_grid_pdf')
        })
      ];
    }
  }

  build() {
    CommonTextBoxGroup({
      title: $r('app.string.multi_line_inline_input_style_label'),
      fileList: this.fileList,
      layoutMode: FileItemLayoutMode.GRID_COLUMN,
      inputMode: FileItemInputMode.MULTI_LINE_AREA
    })
  }
}