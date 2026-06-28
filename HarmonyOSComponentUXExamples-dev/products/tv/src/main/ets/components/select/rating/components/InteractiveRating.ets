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

import { CommonConstants, CornerRadiusToken, Logger, SizeToken } from 'componentuxexamplesbase';

const TAG = 'InteractiveRating';

@Builder
export function InteractiveRating() {
  Column() {
    Rating({ rating: CommonConstants.INTEGER_1, indicator: false })
      .stars(CommonConstants.INTEGER_5)
      .stepSize(CommonConstants.FLOAT_0_POINT_5)
      .width(SizeToken.SIZE_NUM_86 * CommonConstants.INTEGER_5)
      .height(SizeToken.SIZE_NUM_86)
      .onChange((value: number) => {
        Logger.info(TAG, `The present score stands at ${value}.`);
      })
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .justifyContent(FlexAlign.Center)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('app.color.item_background_color'))
  .borderWidth(SizeToken.SIZE_NUM_1)
  .borderColor($r('app.color.item_border_color'))
  .height($r('app.float.item_height_L'))
}