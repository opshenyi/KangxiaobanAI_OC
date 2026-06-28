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
import { ComponentItem, PaddingToken } from 'componentuxexamplesbase';
import { ArcList, ArcListItem, ComponentContent, LengthMetrics } from '@kit.ArkUI';
import { HeaderComponent } from '../../common/HeaderComponent';
import { ItemComponent } from '../../common/ItemComponent';

@Builder
export function TextExampleBuilder() {
  TextExample()
}

const items: ComponentItem[] = [
  { id: 'style_base', name: $r('app.string.style_base'), url: 'TextCollect' },
  { id: 'long_unfold_text', name: $r('app.string.long_unfold_text'), url: 'TextCollect' }
]

@ComponentV2
export struct TextExample {
  @Local private param: string = ''
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  context: UIContext = this.getUIContext();

  build() {
    NavDestination() {
      ArcList({ header: new ComponentContent(this.context, wrapBuilder(HeaderComponent), this.param) }) {
        Repeat(items)
          .each((itemWrap) => {
            ArcListItem() {
              ItemComponent(itemWrap.item, this.navPathStack)
            }
          })
      }.space(LengthMetrics.px(PaddingToken.PADDING_3VP))
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}