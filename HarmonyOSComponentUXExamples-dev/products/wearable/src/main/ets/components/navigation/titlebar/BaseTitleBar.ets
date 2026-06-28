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
import { SizeToken } from 'componentuxexamplesbase'

@Builder
export function BaseTitleBarBuilder() {
  NavDestination() {
  }
  .title({ builder: Title($r('app.string.title_text_long')), height: SizeToken.SIZE_NUM_67 })
  .hideBackButton(true)
  .backgroundColor(Color.Black)
}

@Builder
function Title(title: ResourceStr | string) {
  Flex({ justifyContent: FlexAlign.Center }) {
    Text(title)
      .fontSize($r('sys.float.Title_L'))
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .height($r('app.float.title_text_height'))
      .width(SizeToken.SIZE_NUM_130)
      .maxLines(SizeToken.SIZE_NUM_1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }.margin({ top: SizeToken.SIZE_NUM_20 })
  .width(SizeToken.SIZE_PERCENT_100)
}