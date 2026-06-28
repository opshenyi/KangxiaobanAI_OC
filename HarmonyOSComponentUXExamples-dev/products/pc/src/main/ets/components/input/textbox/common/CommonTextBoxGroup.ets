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

import { CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { FileItemModel } from '../model/FileItemModel';
import { CommonFileRenameItem } from './CommonFileRenameItem';
import { FileItemInputMode, FileItemLayoutMode } from '../model/TextBoxConfig';

@ComponentV2
export struct CommonTextBoxGroup {
  @Param title: ResourceStr = '';
  @Param fileList: FileItemModel[] = [];
  @Param layoutMode: FileItemLayoutMode = FileItemLayoutMode.LIST_ROW;
  @Param inputMode: FileItemInputMode = FileItemInputMode.SINGLE_LINE;
  // Single source of truth for active item ID managed here
  @Local activeFileId: string = '';

  build() {
    Column() {
      SubTitleView(this.title)

      if (this.layoutMode === FileItemLayoutMode.GRID_COLUMN) {
        Row({ space: SpaceToken.SPACE_26 }) {
          this.RenderItems()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .padding({
          left: PaddingToken.PADDING_36VP,
          right: PaddingToken.PADDING_36VP,
          top: PaddingToken.PADDING_16VP,
          bottom: PaddingToken.PADDING_16VP
        })
      } else {
        Column({ space: SpaceToken.SPACE_10 }) {
          this.RenderItems()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .padding({
          left: PaddingToken.PADDING_12VP,
          right: PaddingToken.PADDING_12VP,
          top: PaddingToken.PADDING_16VP,
          bottom: PaddingToken.PADDING_16VP
        })
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  @Builder
  private RenderItems() {
    ForEach(this.fileList, (item: FileItemModel) => {
      CommonFileRenameItem({
        fileItem: item,
        activeFileId: this.activeFileId,
        layoutMode: this.layoutMode,
        inputMode: this.inputMode,
        onActiveIdChange: (id: string) => {
          this.activeFileId = id;
        }
      })
    }, (item: FileItemModel) => item.id)
  }
}