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

import { PaddingToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function SheetContentBuilder() {
  Column() {
    Column()
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
  }
  .backgroundColor($r('app.color.sheet_content_background_color'))
  .margin({
    left: PaddingToken.PADDING_32VP,
    right: PaddingToken.PADDING_32VP,
    bottom: PaddingToken.PADDING_32VP
  })
}