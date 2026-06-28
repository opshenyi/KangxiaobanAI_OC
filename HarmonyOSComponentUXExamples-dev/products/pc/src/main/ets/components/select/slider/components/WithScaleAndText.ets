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
import {
  CommonConstants,
  CornerRadiusToken,
  Logger,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';

const TAG = 'WithScaleAndText';

@ComponentV2
export struct WithScaleAndText {
  @Local scaleValues: number[] = [0, 20, 40, 60, 80, 100];
  @Local currentValue: number = 30;

  /**
   * Extract common card properties
   */
  @Styles
  baseCardStyle() {
    .width(SizeToken.SIZE_PERCENT_100)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }

  build() {
    Column() {
      SubTitleView($r('app.string.slider_with_scale_label'))

      Column() {
        Slider({
          value: CommonConstants.INTEGER_30,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          style: SliderStyle.InSet
        })
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange((value: number) => {
            Logger.info(TAG, `Current slider progress value: ${value}`);
          })

        Row() {
          ForEach(this.scaleValues, (item: number) => {
            Text(item.toString())
              .fontSize($r('sys.float.Caption_M'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Regular)
          }, (item: number, index: number) => `${index}_${item}`)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: PaddingToken.PADDING_6VP,
          right: PaddingToken.PADDING_6VP
        })
      }
      .baseCardStyle()
      .padding({
        left: PaddingToken.PADDING_6VP,
        right: PaddingToken.PADDING_6VP,
        top: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })

      SubTitleView($r('app.string.slider_with_text_label'))

      Column() {
        Row() {
          Text($r('app.string.title_en_label'))
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Regular)

          Text(`${Math.round(this.currentValue)}%`)
            .fontSize($r('sys.float.Body_M'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Medium)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP
        })

        Slider({
          value: this.currentValue!!,
          min: CommonConstants.INTEGER_0,
          max: CommonConstants.INTEGER_100,
          style: SliderStyle.InSet
        })
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .padding({
            left: PaddingToken.PADDING_18VP,
            right: PaddingToken.PADDING_18VP
          })
      }
      .baseCardStyle()
      .padding({
        left: PaddingToken.PADDING_76VP,
        right: PaddingToken.PADDING_76VP,
        top: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}