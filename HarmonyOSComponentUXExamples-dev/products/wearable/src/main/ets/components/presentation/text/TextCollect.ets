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
import { ComponentItem, SizeToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function TextCollectBuilder() {
  TextCollect()
}

@ComponentV2
struct TextCollect {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  context: UIContext = this.getUIContext();
  scroller: Scroller = new Scroller();
  value: Resource = $r('app.string.long_text_content')

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column() {
          TitleComponent(this.param.name)
          if (this.param.id === 'style_base') {
            Text(this.value)
              .margin({ top: SizeToken.SIZE_NUM_22 })
              .fontSize($r('sys.float.Title_M'))
              .fontColor(Color.White)
              .width(SizeToken.SIZE_PERCENT_80)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(5)
              .focusable(true)
          }
          if (this.param.id === 'long_unfold_text') {

            Column() {
              Text($r('app.string.index_list_sub_header_label'))
                .fontSize($r('sys.float.Title_L'))
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .margin({ top: SizeToken.SIZE_NUM_16 })
              Text(this.value)
                .margin({ top: SizeToken.SIZE_NUM_22 })
                .fontSize($r('sys.float.Title_M'))
                .fontColor(Color.White)
                .width(SizeToken.SIZE_PERCENT_80)
                .textAlign(TextAlign.Center)
                .margin({ top: SizeToken.SIZE_NUM_10, bottom: SizeToken.SIZE_NUM_40 })
                .focusable(true)
            }.justifyContent(FlexAlign.Center)
            .width(SizeToken.SIZE_PERCENT_100)
          }
        }
        .width(SizeToken.SIZE_PERCENT_100)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}