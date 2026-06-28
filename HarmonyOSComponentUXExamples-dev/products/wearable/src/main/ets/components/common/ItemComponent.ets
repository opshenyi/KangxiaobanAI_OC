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
import { ComponentItem, SpaceToken } from 'componentuxexamplesbase';

@Builder
export function ItemComponent(item: ComponentItem, navPathStack: NavPathStack) {
  Row() {
    Text(item.name)
      .fontColor(Color.White)
      .fontSize($r('sys.float.Title_L'))
      .width($r('app.float.item_text_width'))
      .margin({ left: SpaceToken.SPACE_44 })
    SymbolGlyph($r('sys.symbol.chevron_right'))
      .width($r('app.float.item_arrow_size'))
      .height($r('app.float.item_arrow_size'))
      .fontSize($r('sys.float.Display_S'))
      .fontColor([Color.White])
  }
  .align(Alignment.Center)
  .width($r('app.float.item_width'))
  .height($r('app.float.item_height'))
  .borderRadius($r('app.float.item_border_radius'))
  .backgroundColor($r('app.color.dark_gray_color'))
  .onClick(() => {
    navPathStack.pushPath({ name: item.url.toString(), param: item });
  })
}