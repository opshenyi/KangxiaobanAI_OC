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

import { SizeToken } from 'componentuxexamplesbase';

@Builder
export function ListGroupTitle(val: ResourceStr, leftPadding: Length | undefined = 0) {
  Row() {
    Text(val)
      .fontSize($r('app.float.list_group_title_text_size'))
      .fontColor($r('sys.color.font_secondary'))
      .lineHeight($r('app.float.list_title_line_height'))
      .fontWeight(FontWeight.Medium)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .padding({
    top: $r('app.float.list_title_padding_top'),
    bottom: $r('app.float.list_title_padding_bottom'),
    left: leftPadding
  })
}