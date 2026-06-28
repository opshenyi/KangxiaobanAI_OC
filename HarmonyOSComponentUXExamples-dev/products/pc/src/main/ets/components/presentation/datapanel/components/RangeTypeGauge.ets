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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

class LinearGaugeModifier implements ContentModifier<GaugeConfiguration> {
  applyContent(): WrappedBuilder<[GaugeConfiguration]> {
    return wrapBuilder(buildLinearGauge)
  }
}

@ComponentV2
export struct RangeTypeGauge {
  // Data for ring Gauge
  @Local curVal: number = 22;
  @Local color: LinearGradient = new LinearGradient([
    { color: '#E83B3D', offset: 0 },
    { color: '#FFD755', offset: 0.6 },
    { color: '#3BD148', offset: 1 }
  ]);
  // Data for linear Gauge
  @Local curVal2: number = 26;
  private tag: string = 'AQI';

  @Styles
  cardStyle() {
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.background_primary'))
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .margin({ bottom: PaddingToken.PADDING_12VP })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.range_class_label'))

      // Card 1: Ring Gauge
      Row() {
        Gauge({ value: this.curVal!! }) {
          Column({ space: SpaceToken.SPACE_16 }) {
            Column() {
              Text(`${this.curVal}`)
                .fontSize($r('sys.float.Display_L'))
                .fontColor($r('sys.color.font_primary'))
                .fontWeight(FontWeight.Medium)

              Text($r('app.string.out_of_range_tip_label'))
                .fontSize($r('sys.float.Subtitle_M'))
                .fontColor($r('sys.color.font_secondary'))
                .fontWeight(FontWeight.Regular)
            }
            .width(SizeToken.SIZE_NUM_150)
            .height(SizeToken.SIZE_NUM_129)
            .justifyContent(FlexAlign.Center)
            .margin({ top: PaddingToken.PADDING_50VP })

            Text(this.tag)
              .fontSize($r('sys.float.Title_L'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)
          }
          .alignItems(HorizontalAlign.Center)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
        }
        .startAngle(CommonConstants.INTEGER_225)
        .endAngle(CommonConstants.INTEGER_135)
        .colors(this.color)
        .width(SizeToken.SIZE_NUM_288)
        .height(SizeToken.SIZE_NUM_288)
        .strokeWidth(SizeToken.SIZE_NUM_18)
        .trackShadow({
          radius: CommonConstants.INTEGER_7,
          offsetX: CommonConstants.INTEGER_7,
          offsetY: CommonConstants.INTEGER_7
        })
        .padding(PaddingToken.PADDING_18VP)
      }
      .justifyContent(FlexAlign.Center)
      .cardStyle()

      // Card 2: Linear Gauge
      Row() {
        Gauge({ value: this.curVal2!!, min: CommonConstants.INTEGER_0, max: CommonConstants.INTEGER_30 })
          .contentModifier(new LinearGaugeModifier()) // Inject custom renderer
          .width(SizeToken.SIZE_PERCENT_100)
      }
      .justifyContent(FlexAlign.Center)
      .cardStyle()
    }
  }
}

/**
 * Custom ContentModifier: converts Gauge to linear gradient indicator
 */
@Builder
function buildLinearGauge(config: GaugeConfiguration) {
  LinearGaugeComp({ config: config })
}

@ComponentV2
struct LinearGaugeComp {
  @Require @Param config: GaugeConfiguration;
  @Local ratio: number = 0;

  aboutToAppear(): void {
    // Calculate current value percentage within total range
    const range = this.config.max - this.config.min;
    const curRatio = range > 0 ? (this.config.value - this.config.min) / range : 0;
    // Clamp ratio between 0 and 1 to prevent cursor overflow
    this.ratio = Math.max(0, Math.min(1, curRatio));
  }

  build() {
    Row({ space: SpaceToken.SPACE_12 }) {
      // Left-side minimum value label
      Text(`${this.config.min}`)
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)

      Stack({ alignContent: Alignment.Center }) {
        // 1. Track layer (gradient background)
        Row()
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_12)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [
              ['#E83B3D', 0.0],
              ['#F39D2D', 0.6],
              ['#3BD148', 1.0]
            ]
          })
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_6)

        // 2. Cursor value label (floating independently above the track)
        Text(`${this.config.value}`)
          .fontSize($r('sys.float.Subtitle_S'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
          .position({ x: `${this.ratio * 100}%`, y: '15%' }) // Align flush to the top
          .markAnchor({ x: '50%', y: 0 }) // Center-align on X-axis to current progress

        // Cursor indicator
        Image($r('app.media.indicator'))
          .width(SizeToken.SIZE_NUM_16)
          .height(SizeToken.SIZE_NUM_16)
          .position({ x: `${this.ratio * 100}%`, y: '50%' })
          .markAnchor({ x: '50%', y: 0 })
          .offset({ x: 0, y: SizeToken.SIZE_NUM_6 }) // Nest inside the groove
      }
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
      .height(SizeToken.SIZE_NUM_64) // Reserve ample vertical space for the label above and triangle below

      // Right-side maximum value label
      Text(`${this.config.max}`)
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_60)
    .padding({ left: PaddingToken.PADDING_16VP, right: PaddingToken.PADDING_16VP })
  }
}