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

import { CommonConstants, CornerRadiusToken, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';

const TAG = 'BaseSlider';

@Builder
export function BaseSlider() {
  Column() {
    Slider({
      value: CommonConstants.INTEGER_36,
      min: CommonConstants.INTEGER_0,
      max: CommonConstants.INTEGER_100,
      style: SliderStyle.OutSet
    })
      .onChange((value: number) => {
        Logger.info(TAG, `OutSet Style, Current slider progress value: ${value}`);
      })

    Slider({
      value: CommonConstants.INTEGER_36,
      min: CommonConstants.INTEGER_0,
      max: CommonConstants.INTEGER_100,
      style: SliderStyle.InSet
    })
      .onChange((value: number) => {
        Logger.info(TAG, `InSet Style, Current slider progress value: ${value}`);
      })
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .justifyContent(FlexAlign.Center)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('app.color.item_background_color'))
  .borderWidth(SizeToken.SIZE_NUM_1)
  .borderColor($r('app.color.item_border_color'))
  .padding(PaddingToken.PADDING_16VP)
}