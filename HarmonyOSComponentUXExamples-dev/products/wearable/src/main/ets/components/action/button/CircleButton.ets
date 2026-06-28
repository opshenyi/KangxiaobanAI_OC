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
import { LengthMetrics } from '@kit.ArkUI';

@Builder
export function CircleButtonBuilder() {
  CircleButton()
}

@ComponentV2
struct CircleButton {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };

  build() {
    NavDestination() {
      Flex({
        wrap: FlexWrap.Wrap,
        space: { main: LengthMetrics.px(SizeToken.SIZE_NUM_10), cross: LengthMetrics.px(SizeToken.SIZE_NUM_12) }
      }) {
        Button() {
          SymbolGlyph($r('sys.symbol.plus'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .type(ButtonType.Circle)

        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .backgroundColor($r('app.color.dark_blue_color'))
        .type(ButtonType.Circle)

        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .backgroundColor($r('app.color.dark_gray_color'))
        .type(ButtonType.Circle)

        Button() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .backgroundColor($r('app.color.dark_blue_color'))
        .type(ButtonType.Circle)

        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .type(ButtonType.Circle)

        Button() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.Red])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Circle)
        .backgroundColor($r('app.color.dark_gray_color'))
      }
      .margin({ top: SizeToken.SIZE_NUM_40 })
      .height('228px')
      .width('350px')
    }
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .title({ builder: TitleComponent(this.param.name), height: SizeToken.SIZE_NUM_45 })
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}