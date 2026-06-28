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
import { ComponentItem, SizeToken } from 'componentuxexamplesbase'
import {
  ArcSlider,
  ArcSliderPosition,
  ArcSliderOptions,
  ArcSliderValueOptions,
  ArcSliderLayoutOptions,
  ArcSliderStyleOptions,
  ArcSliderValueOptionsConstructorOptions,
  ArcSliderLayoutOptionsConstructorOptions,
  ArcSliderStyleOptionsConstructorOptions,
  ArcSliderOptionsConstructorOptions
} from '@kit.ArkUI';
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function CustomArcSliderBuilder() {
  CustomArcSlider()
}

@ComponentV2
export struct CustomArcSlider {
  @Local private param: ComponentItem = { id: '', name: '', url: '' }
  valueOptionsConstructorOptions: ArcSliderValueOptionsConstructorOptions = {
    progress: SizeToken.SIZE_NUM_60,
    min: SizeToken.SIZE_NUM_0,
    max: SizeToken.SIZE_NUM_100
  };
  layoutOptionsConstructorOptions: ArcSliderLayoutOptionsConstructorOptions = {
    reverse: true,
    position: ArcSliderPosition.RIGHT
  };
  styleOptionsConstructorOptions: ArcSliderStyleOptionsConstructorOptions = {
    trackThickness: SizeToken.SIZE_NUM_5,
    activeTrackThickness: SizeToken.SIZE_NUM_24,
    trackColor: '#26FFFFFF',
    selectedColor: '#5EA1FF',
    trackBlur: SizeToken.SIZE_NUM_20
  };
  valueOptions: ArcSliderValueOptions = new ArcSliderValueOptions(this.valueOptionsConstructorOptions);
  layoutOptions: ArcSliderLayoutOptions = new ArcSliderLayoutOptions(this.layoutOptionsConstructorOptions);
  styleOptions: ArcSliderStyleOptions = new ArcSliderStyleOptions(this.styleOptionsConstructorOptions);
  arcSliderOptionsConstructorOptions: ArcSliderOptionsConstructorOptions = {
    valueOptions: this.valueOptions,
    layoutOptions: this.layoutOptions,
    styleOptions: this.styleOptions,
    digitalCrownSensitivity: CrownSensitivity.LOW
  };
  arcSliderOptions: ArcSliderOptions = new ArcSliderOptions(this.arcSliderOptionsConstructorOptions);

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Top }) {
        TitleComponent(this.param.name)
        ArcSlider({ options: this.arcSliderOptions })
          .focusable(true)
          .defaultFocus(true)
          .focusOnTouch(true)
      }
      .focusable(true)
      .defaultFocus(true)
      .focusOnTouch(true)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })

  }
}