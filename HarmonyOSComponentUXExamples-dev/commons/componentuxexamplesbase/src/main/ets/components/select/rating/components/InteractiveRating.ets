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

import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { CommonConstants } from '../../../../constants/CommonConstants';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';

const TAG = 'InteractiveRating';

@Builder
export function InteractiveRating() {
  Column() {
    SubTitleView($r('app.string.interactive_rating_bar_label'))

    Row() {
      Rating({ rating: CommonConstants.INTEGER_1, indicator: false })
        .stars(CommonConstants.INTEGER_5)
        .stepSize(CommonConstants.FLOAT_0_POINT_5)
        .onChange((value: number) => {
          Logger.info(TAG, `The present score stands at ${value}.`);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}