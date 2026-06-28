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
import { ArcList, ArcListItem, ComponentContent } from '@kit.ArkUI';
import { CommonConstants, ComponentItem } from 'componentuxexamplesbase';
import { HeaderComponent } from '../../common/HeaderComponent';

@Builder
export function SearchBoxCollectBuilder() {
  SearchBoxCollect()
}

@ComponentV2
export struct SearchBoxCollect {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  context: UIContext = this.getUIContext();

  @Styles
  itemStyles(){
    .width($r('app.float.item_width'))
    .backgroundColor($r('app.color.dark_gray_color'))
    .borderRadius($r('sys.float.ohos_id_textfield_border_radius'))
  }

  build() {
    NavDestination() {
      ArcList({ header: new ComponentContent(this.context, wrapBuilder(HeaderComponent), this.param.name) }) {
        if (this.param.id === 'search_base') {
          ArcListItem() {
            Search({
              placeholder: $r('app.string.textarea_placeholder_label')
            })
              .placeholderFont({ size: $r('sys.float.Body_L') })
              .placeholderColor($r('app.color.gray_color'))
              .height($r('app.float.item_content_height'))
              .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
              .textFont({ size: $r('sys.float.Body_L') })
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .itemStyles()
              .enableKeyboardOnFocus(false)
              .defaultFocus(false)
          }
        }
      }
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}