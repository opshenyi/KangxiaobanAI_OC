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
import { Logger } from 'componentuxexamplesbase';
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'CombinationTypeSlider';

@ComponentV2
export struct CombinationTypeSlider {
  @Local tipsValue: number = 40;

  /**
   * Extract file-level global common card styles
   */
  @Styles
  cardStyle() {
    .width(SizeToken.SIZE_PERCENT_100)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    // When the style of the slider is set to SliderStyle.InSet, the left and right spacing are 6vp respectively.
    .padding({
      left: PaddingToken.PADDING_6VP,
      right: PaddingToken.PADDING_6VP,
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_12VP
    })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.blue_hand_following_slider_label'))

      Row() {
        Slider({
          value: CommonConstants.INTEGER_50,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          style: SliderStyle.InSet
        })
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })
      }
      .cardStyle()

      SubTitleView($r('app.string.slider_with_bubble_label'))

      Row() {
        Slider({
          value: this.tipsValue,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          style: SliderStyle.InSet
        })
          .showTips(true)
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange(value => {
            this.tipsValue = value;
          })
      }
      .cardStyle()

      SubTitleView($r('app.string.intermittent_sliding_label'))

      Row() {
        Slider({
          value: CommonConstants.INTEGER_50,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          step: CommonConstants.INTEGER_10,
          style: SliderStyle.InSet
        })
          .showSteps(true)
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })
      }
      .cardStyle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}