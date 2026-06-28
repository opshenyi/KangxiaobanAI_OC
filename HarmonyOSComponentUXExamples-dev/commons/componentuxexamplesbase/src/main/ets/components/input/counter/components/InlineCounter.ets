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
import { CounterComponent, CounterType } from '@kit.ArkUI';
import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { CommonConstants } from '../../../../constants/CommonConstants';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';

const TAG = 'InlineCounter';

@Builder
export function InlineCounter() {
  Column() {
    SubTitleView($r('app.string.inline_counter_label'))

    Row({ space: SpaceToken.SPACE_12 }) {
      Text('Quantity')
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)

      CounterComponent({
        options: {
          type: CounterType.INLINE,
          inlineOptions: {
            value: CommonConstants.COUNTER_INITIAL_VALUE,
            min: CommonConstants.COUNTER_MIN_VALUE,
            step: CommonConstants.COUNTER_STEP_VALUE_2,
            max: CommonConstants.COUNTER_MAX_VALUE,
            textWidth: SizeToken.SIZE_NUM_60,
            onChange: (value: number) => {
              Logger.info(TAG, 'onCounterChange Counter: ' + value.toString());
            }
          }
        }
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