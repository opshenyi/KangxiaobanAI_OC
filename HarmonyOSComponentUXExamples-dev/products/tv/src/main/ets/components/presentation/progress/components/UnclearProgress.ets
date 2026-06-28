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

import { CornerRadiusToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function UnclearProgress() {
  Row({ space: $r('app.float.progress_list_space') }) {
    LoadingProgress()
      .height($r('app.float.progress_size1'))
      .width($r('app.float.progress_size1'))
      .color($r('sys.color.icon_secondary'))

    LoadingProgress()
      .height($r('app.float.progress_size2'))
      .width($r('app.float.progress_size2'))
      .color($r('sys.color.icon_secondary'))

    LoadingProgress()
      .height($r('app.float.progress_size3'))
      .width($r('app.float.progress_size3'))
      .color($r('sys.color.icon_secondary'))

    LoadingProgress()
      .height($r('app.float.progress_size4'))
      .width($r('app.float.progress_size4'))
      .color($r('sys.color.icon_secondary'))
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .justifyContent(FlexAlign.Center)
  .alignItems(VerticalAlign.Center)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('app.color.item_background_color'))
  .borderWidth(SizeToken.SIZE_NUM_1)
  .borderColor($r('app.color.item_border_color'))
}