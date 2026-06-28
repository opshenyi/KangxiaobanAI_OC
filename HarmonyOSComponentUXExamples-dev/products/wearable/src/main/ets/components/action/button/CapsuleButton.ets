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
export function CapsuleButtonBuilder() {
  CapsuleButton()
}

@ComponentV2
struct CapsuleButton {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  scroller: Scroller = new Scroller();

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column({ space: SizeToken.SIZE_NUM_4 }) {
          TitleComponent(this.param.name)
          Text($r('app.string.normal_state'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor($r('app.color.gray_color'))
            .width(SizeToken.SIZE_PERCENT_100)
            .margin({ top: SizeToken.SIZE_NUM_40 })
          Button($r('app.string.emphasized_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .backgroundColor($r('app.color.dark_blue_color'))
            .fontColor($r('app.color.light_blue_color'))
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .fontColor($r('app.color.light_blue_color'))
            .backgroundColor($r('app.color.dark_gray_color'))
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .backgroundColor($r('app.color.ink_black'))
            .buttonStyle(ButtonStyleMode.NORMAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .border({
              width: SizeToken.SIZE_NUM_1,
              color: 0x1affffff
            })
          Button($r('app.string.text_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
          Button() {
            Row() {
              SymbolGlyph($r('sys.symbol.heart_fill'))
                .fontColor([$r('app.color.gray_color')])
                .fontSize(SizeToken.SIZE_NUM_20)
              Text($r('app.string.care_him'))
                .fontSize(SizeToken.SIZE_NUM_15)
                .fontColor($r('app.color.green_color'))
                .margin({ left: SizeToken.SIZE_NUM_6 })
                .fontSize($r('sys.float.Body_M'))
            }
            .justifyContent(FlexAlign.Center)
          }
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .type(ButtonType.Capsule)

          Button($r('app.string.general_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.NORMAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
          Button($r('app.string.emphasized_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
          Button($r('app.string.text_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
          Text($r('app.string.disabled_state'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor($r('app.color.gray_color'))
            .width(SizeToken.SIZE_PERCENT_100)
            .margin({ top: SizeToken.SIZE_NUM_40 })
          Button($r('app.string.emphasized_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .enabled(false)
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .backgroundColor($r('app.color.dark_blue_color'))
            .fontColor($r('app.color.light_blue_color'))
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .enabled(false)
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .fontColor($r('app.color.light_blue_color'))
            .backgroundColor($r('app.color.dark_gray_color'))
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .enabled(false)
          Button($r('app.string.normal_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.NORMAL)
            .type(ButtonType.Capsule)
            .backgroundColor($r('app.color.ink_black'))
            .fontSize($r('sys.float.Body_M'))
            .border({
              width: SizeToken.SIZE_NUM_1,
              color: 0x1affffff
            })
            .enabled(false)
          Button($r('app.string.text_button'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .enabled(false)
          Button() {
            Row() {
              SymbolGlyph($r('sys.symbol.heart_fill'))
                .fontColor([$r('app.color.gray_color')])
                .fontSize(SizeToken.SIZE_NUM_20)
              Text($r('app.string.care_him'))
                .fontSize($r('sys.float.Body_M'))
                .fontColor($r('app.color.green_color'))
                .margin({ left: SizeToken.SIZE_NUM_6 })
            }
            .justifyContent(FlexAlign.Center)
          }
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .type(ButtonType.Capsule)
          .enabled(false)

          Button($r('app.string.general_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.NORMAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
            .enabled(false)
          Button($r('app.string.emphasized_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
            .enabled(false)
          Button($r('app.string.text_warning'))
            .height(SizeToken.SIZE_NUM_40)
            .width(SizeToken.SIZE_NUM_116)
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .type(ButtonType.Capsule)
            .fontSize($r('sys.float.Body_M'))
            .role(ButtonRole.ERROR)
            .enabled(false)
        }
        .margin({ bottom: SizeToken.SIZE_NUM_40 })
      }
      .scrollBar(BarState.Off)
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