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
export function SubNavigationTitle(val: ResourceStr) {
  Column() {
    Text(val)
      .fontColor($r('sys.color.font_primary'))
      .fontSize($r('app.float.sub_nav_title_text_size'))
      .height($r('app.float.nav_title_height'))
      .textAlign(TextAlign.Start)
      .fontWeight(FontWeight.Bold)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding')
      })
      .margin({ top: $r('app.float.nav_title_margin_top') })
  }
  .alignItems(HorizontalAlign.Start)
  .width(SizeToken.SIZE_PERCENT_100)
}