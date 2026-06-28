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
import { CommonConstants, ComponentItem, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { HeaderComponent } from '../../common/HeaderComponent';
import { ArcList, ArcListItem, ComponentContent } from '@kit.ArkUI';

@Builder
export function TextInputCollectBuilder() {
  TextInputCollect()
}

@ComponentV2
export struct TextInputCollect {
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
        if (this.param.id === 'textinput_base') {
          ArcListItem() {
            TextInput({
              placeholder: $r('app.string.textarea_placeholder_label')
            })
              .placeholderFont({ size: $r('sys.float.Body_L') })
              .placeholderColor($r('app.color.gray_color'))
              .height($r('app.float.item_content_height'))
              .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
              .fontSize($r('sys.float.Body_L'))
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .itemStyles()
          }
        } else if (this.param.id === 'textinput_left_icon') {
          ArcListItem() {
            Row() {
              SymbolGlyph($r('sys.symbol.square_and_pencil_fill'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize($r('sys.float.ohos_id_textfield_icon_size'))
                .margin({
                  left: SpaceToken.SPACE_8,
                  right: SpaceToken.SPACE_2,
                  top: SpaceToken.SPACE_7,
                  bottom: SpaceToken.SPACE_9
                })

              TextArea({
                placeholder: $r('app.string.textarea_placeholder_label')
              })
                .width('312px')
                .maxLines(SizeToken.SIZE_NUM_2)
                .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
                .placeholderFont({ size: $r('sys.float.Body_L') })
                .placeholderColor($r('app.color.gray_color'))
                .backgroundColor(Color.Transparent)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }.itemStyles()

          }
        } else if (this.param.id === 'textinput_right_icon') {
          ArcListItem() {
            TextInput({
              placeholder: $r('app.string.textarea_placeholder_label')
            })
              .type(InputType.Password)
              .placeholderFont({ size: $r('sys.float.Body_L') })
              .placeholderColor($r('app.color.gray_color'))
              .height($r('app.float.item_content_height'))
              .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
              .fontSize($r('sys.float.Body_L'))
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .itemStyles()
          }
        }
      }
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}