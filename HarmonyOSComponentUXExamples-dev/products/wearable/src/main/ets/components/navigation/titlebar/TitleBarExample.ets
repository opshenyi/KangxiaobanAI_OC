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
import { ArcList, ArcListItem, ComponentContent, LengthMetrics } from '@kit.ArkUI';
import { ComponentItem, PaddingToken } from 'componentuxexamplesbase';
import { HeaderComponent } from '../../common/HeaderComponent';
import { ItemComponent } from '../../common/ItemComponent';

@Builder
export function TitleBarExampleBuilder() {
  TitleBarExample()
}

const items: ComponentItem[] = [
  { id: 'title_bar_base', name: $r('app.string.style_base'), url: 'BaseTitleBar' },
  { id: 'title_bar_icon', name: $r('app.string.title_bar_icon'), url: 'IconTitleBar' },
  { id: 'title_bar_subtext', name: $r('app.string.title_bar_subtext'), url: 'SubTextTitleBar' },
  { id: 'title_bar_icon_text', name: $r('app.string.title_bar_icon_text'), url: 'IconSubTextTitleBar' },
  { id: 'title_bar_mix', name: $r('app.string.title_bar_mix'), url: 'MixTitleBar' }
]

@ComponentV2
export struct TitleBarExample {
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