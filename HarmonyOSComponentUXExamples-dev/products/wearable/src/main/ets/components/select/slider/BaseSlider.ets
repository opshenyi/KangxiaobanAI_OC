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
import { ComponentContent } from '@kit.ArkUI';
import { SizeToken } from 'componentuxexamplesbase';


@Builder
export function BaseSliderBuilder() {
  BaseSlider()
}

@Builder
export function ImageBuilder(value: Resource) {
  SymbolGlyph(value)
    .fontSize(SizeToken.SIZE_NUM_28)
    .fontColor([Color.White])
    .width(SizeToken.SIZE_NUM_28)
    .height(SizeToken.SIZE_NUM_28)
}

@ComponentV2
export struct BaseSlider {
  @Local inSetValueOne: number = SizeToken.SIZE_NUM_60
  @Local colorGradient: LinearGradient =
    new LinearGradient([{ color: '#1F71FF', offset: 0 }, { color: '#5ED7FF', offset: 1 }])

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Slider({
          value: this.inSetValueOne,
          min: SizeToken.SIZE_NUM_0,
          max: SizeToken.SIZE_NUM_100,
          style: SliderStyle.NONE,
          direction: Axis.Vertical,
          reverse: true
        })
          .focusable(true)
          .defaultFocus(true)
          .focusOnTouch(true)
          .trackColor($r('app.color.dark_gray_color'))
          .trackThickness(SizeToken.SIZE_NUM_52)
          .selectedColor(this.colorGradient)
          .prefix(new ComponentContent(this.getUIContext(), wrapBuilder(ImageBuilder), $r('sys.symbol.speaker_wave_1')))
          .suffix(new ComponentContent(this.getUIContext(), wrapBuilder(ImageBuilder), $r('sys.symbol.speaker_wave_3')))
          .height(SizeToken.SIZE_NUM_201)
          .width(SizeToken.SIZE_NUM_70)
          .margin({ top: SizeToken.SIZE_NUM_16, bottom: SizeToken.SIZE_NUM_16 })
          .onChange((value: number) => {
            this.inSetValueOne = value
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .backgroundColor(Color.Black)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
  }
}