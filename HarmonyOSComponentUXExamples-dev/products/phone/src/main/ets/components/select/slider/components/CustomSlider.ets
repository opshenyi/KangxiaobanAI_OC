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

const TAG = 'CustomSlider';

@ComponentV2
export struct CustomSlider {
  @Local colorGradient: LinearGradient = new LinearGradient([
    { color: '#FFB76CFF', offset: 0 },
    { color: '#FF1E53FF', offset: 1 }
  ]);

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
      SubTitleView($r('app.string.linear_gradient_en_label'))

      Row() {
        Slider({
          value: CommonConstants.INTEGER_50,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          style: SliderStyle.InSet
        })
          .selectedColor(Color.Transparent)
          .trackColor(this.colorGradient!!)
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })
      }
      .cardStyle()

      SubTitleView($r('app.string.shape_en_label'))

      Row() {
        Slider({
          value: CommonConstants.INTEGER_50,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          step: CommonConstants.INTEGER_10,
          style: SliderStyle.InSet
        })
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .trackColor($r('sys.color.comp_background_tertiary'))
          .trackBorderRadius(CornerRadiusToken.CORNER_RADIUS_4)
          .blockSize({
            width: PaddingToken.PADDING_12VP,
            height: PaddingToken.PADDING_12VP
          })
          .blockColor(Color.White)
          .showSteps(true)
          .blockStyle({
            type: SliderBlockType.SHAPE,
            shape: new Rect({
              width: SizeToken.SIZE_NUM_12,
              height: SizeToken.SIZE_NUM_12
            }).radius(CornerRadiusToken.CORNER_RADIUS_2)
          })
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })
      }
      .cardStyle()

      SubTitleView($r('app.string.image_en_label'))

      Row() {
        Slider({
          value: CommonConstants.INTEGER_50,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          step: CommonConstants.INTEGER_10,
          style: SliderStyle.InSet
        })
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .trackColor($r('sys.color.comp_background_tertiary'))
          .blockSize({ width: SizeToken.SIZE_NUM_14, height: SizeToken.SIZE_NUM_14 })
          .blockColor(Color.White)
          .showSteps(true)
          .blockStyle({
            type: SliderBlockType.IMAGE,
            image: $r('app.media.heart_fill')
          })
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })
      }
      .cardStyle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}