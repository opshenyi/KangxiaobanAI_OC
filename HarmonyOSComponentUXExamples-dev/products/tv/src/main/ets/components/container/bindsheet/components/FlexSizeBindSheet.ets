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

import { SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';
import { ListGroupTitle } from '../../../common/ListGroupTitle';
import { SheetContentBuilder } from './SheetContentBuilder';

@ComponentV2
export struct FlexSizeBindSheet {
  @Local isShowDefaultSheet: boolean = false;
  @Local isShowLargeWidthSheet: boolean = false;
  @Local isShowXLargeWidthSheet: boolean = false;
  @Local isShowMinHeightSheet: boolean = false;
  @Local isShowMaxHeightSheet: boolean = false;

  build() {
    Column() {
      ListGroupTitle($r('app.string.window_width_label'))
      Column({ space: SpaceToken.SPACE_16 }) {
        CommonItem({ val: $r('app.string.default_label'), hint: $r('app.string.default_sheet_hint') })
          .onClick(() => {
            this.isShowDefaultSheet = !this.isShowDefaultSheet;
          })
          .bindSheet(this.isShowDefaultSheet!!, SheetContentBuilder(), {
            showClose: true,
            height:$r('app.float.window_width_sheet_height'),
            width: $r('app.float.default_sheet_width'),
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
        CommonItem({ val: $r('app.string.large_label') , hint: $r('app.string.large_sheet_hint')})
          .onClick(() => {
            this.isShowLargeWidthSheet = !this.isShowLargeWidthSheet;
          })
          .bindSheet(this.isShowLargeWidthSheet!!, SheetContentBuilder(), {
            showClose: true,
            height:$r('app.float.window_width_sheet_height'),
            width: $r('app.float.large_sheet_width'),
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
        CommonItem({ val: $r('app.string.x_large_label'), hint: $r('app.string.x_large_sheet_hint') })
          .onClick(() => {
            this.isShowXLargeWidthSheet = !this.isShowXLargeWidthSheet;
          })
          .bindSheet(this.isShowXLargeWidthSheet!!, SheetContentBuilder(), {
            showClose: true,
            height:$r('app.float.window_width_sheet_height'),
            width: $r('app.float.x_large_sheet_width'),
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
      }

      ListGroupTitle($r('app.string.window_height_label'))
      Column({ space: SpaceToken.SPACE_16 }) {
        CommonItem({ val: $r('app.string.min_label') })
          .onClick(() => {
            this.isShowMinHeightSheet = !this.isShowMinHeightSheet;
          })
          .bindSheet(this.isShowMinHeightSheet!!, SheetContentBuilder(), {
            showClose: true,
            height:$r('app.float.window_width_sheet_height'),
            width: $r('app.float.default_sheet_width'),
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
        CommonItem({ val: $r('app.string.max_label') })
          .onClick(() => {
            this.isShowMaxHeightSheet = !this.isShowMaxHeightSheet;
          })
          .bindSheet(this.isShowMaxHeightSheet!!, SheetContentBuilder(), {
            showClose: true,
            height: SizeToken.SIZE_PERCENT_100,
            width: $r('app.float.default_sheet_width'),
            backgroundColor: $r('app.color.sheet_background_color'),
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}