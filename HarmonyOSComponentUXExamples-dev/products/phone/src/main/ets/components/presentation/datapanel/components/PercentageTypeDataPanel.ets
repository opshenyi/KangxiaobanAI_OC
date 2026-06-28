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
/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

@Builder
export function PercentageTypeDataPanel() {
  Column() {
    RingProgress()
    LinearProgress()
  }
  .width(SizeToken.SIZE_PERCENT_100)
}

/**
 * Custom ContentModifier: for pure blue single-segment linear progress bar
 * @param config DataPanelConfiguration used by dataPanel content modifier
 */
@Builder
function buildSolidDataPanel(config: DataPanelConfiguration) {
  Stack({ alignContent: Alignment.Start }) {
    // Background track
    Row() {
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .backgroundColor('#4D46B1E3')
    .borderRadius(SizeToken.SIZE_NUM_10)

    // Actual progress area (ensures independent rounded ends)
    Row() {
    }
    .width(`${(config.values[0] / config.maxValue) * 100}%`)
    .height(SizeToken.SIZE_PERCENT_100)
    .backgroundColor('#46B1E3')
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_6)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_PERCENT_100)
  .clip(true)
}

class SolidDataPanelModifier implements ContentModifier<DataPanelConfiguration> {
  applyContent(): WrappedBuilder<[DataPanelConfiguration]> {
    return wrapBuilder(buildSolidDataPanel)
  }
}


/**
 * Custom ContentModifier: for gradient linear progress bar with offset
 * @param config DataPanelConfiguration used by dataPanel content modifier
 */
@Builder
function buildGradientDataPanel(config: DataPanelConfiguration) {
  Stack({ alignContent: Alignment.Start }) {
    // Background track
    Row() {
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.interactive_click'))
    .borderRadius(SizeToken.SIZE_NUM_10)

    // Progress and offset area
    Row() {
      if (config.values.length > 1) {
        // Segment 1: placeholder offset area (transparent)
        Row()
          .width(`${(config.values[0] / config.maxValue) * 100}%`)
          .height(SizeToken.SIZE_PERCENT_100)

        // Segment 2: gradient progress area (ensures independent rounded ends)
        Row()
          .width(`${(config.values[1] / config.maxValue) * 100}%`)
          .height(SizeToken.SIZE_PERCENT_100)
          .linearGradient({ direction: GradientDirection.Right, colors: [['#B6E467', 0], ['#F7BB1C', 1]] })
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_6)
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_PERCENT_100)
  .clip(true)
}

class GradientDataPanelModifier implements ContentModifier<DataPanelConfiguration> {
  applyContent(): WrappedBuilder<[DataPanelConfiguration]> {
    return wrapBuilder(buildGradientDataPanel)
  }
}

/**
 * Percentage type - ring chart
 */
@ComponentV2
struct RingProgress {
  @Local dataPanelVals: number[] = [50, 12, 8, 5];
  @Local totalMemory: number = 128;
  @Local maxVal: number = 100;
  private unit: string = '%';

  @Computed
  private get totalVal(): number {
    return this.dataPanelVals.reduce((acc: number, cur: number) => acc + cur, 0);
  }

  @Computed
  private get curUsedMemory(): number {
    return Math.ceil(this.totalVal / this.maxVal * this.totalMemory);
  }

  build() {
    Column() {
      SubTitleView($r('app.string.percentage_type_ring_chart_label'))

      Row() {
        Stack() {
          DataPanel({ values: this.dataPanelVals, max: this.maxVal, type: DataPanelType.Circle })
            .width(SizeToken.SIZE_NUM_288)
            .height(SizeToken.SIZE_NUM_288)
            .trackShadow(null)
            .closeEffect(true)

          Column() {
            Text(`${this.totalVal}`)
              .fontSize($r('sys.float.Display_L'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)

            Text($r('app.string.memory_usage_info_label', this.curUsedMemory, this.totalMemory))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Regular)
          }

          Text(this.unit)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Medium)
            .offset({ x: PaddingToken.PADDING_40VP })
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .backgroundColor($r('sys.color.background_primary'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .justifyContent(FlexAlign.Center)
    }
  }
}

/**
 * Percentage type - linear
 */
@ComponentV2
struct LinearProgress {
  @Local dataPanelVals: number[] = [24.94, 8.80, 4.40, 3.67, 2.94, 2.20, 1.47];
  // Data source for DataPanelBuilder
  @Local dataPanelVals2: number[] = [18]; // Single-segment solid data
  @Local dataPanelVals3: number[] = [6, 18]; // [offset, actual length]
  @Local maxVal: number = 100;
  @Local totalMemory: number = 500;
  @Local colorArray: (LinearGradient | ResourceColor)[] = [
    new LinearGradient([{ color: '#F5744E', offset: 0 }, { color: '#E84026', offset: 1 }]),
    new LinearGradient([{ color: '#F9A01E', offset: 0 }, { color: '#FCD9A5', offset: 1 }]),
    new LinearGradient([{ color: '#F7CE00', offset: 0 }, { color: '#FBEB99', offset: 1 }]),
    new LinearGradient([{ color: '#A5D61D', offset: 0 }, { color: '#C7E76E', offset: 1 }]),
    new LinearGradient([{ color: '#C1E3BD', offset: 0 }, { color: '#64BB5C', offset: 1 }]),
    new LinearGradient([{ color: '#61CFBE', offset: 0 }, { color: '#BFEBE5', offset: 1 }]),
    new LinearGradient([{ color: '#46B1E3', offset: 0 }, { color: '#B5DFF3', offset: 1 }])
  ];
  @Local curLength: number = 18;
  @Local maxLength: number = 30;
  private phoneTag: string = 'Phone222';

  @Computed
  private get totalVal(): number {
    return this.dataPanelVals.reduce((acc: number, cur: number) => acc + cur, 0);
  }

  @Computed
  private get curUsedMemory(): number {
    return Math.ceil(this.totalVal / this.maxVal * this.totalMemory);
  }

  @Styles
  cardStyle() {
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_60)
    .backgroundColor($r('sys.color.background_primary'))
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .padding({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP,
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_12VP
    })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.percentage_type_linear_label'))

      // Multi-segment gradient example
      Row() {
        Column({ space: SpaceToken.SPACE_8 }) {
          Row() {
            Text(this.phoneTag)
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)

            Text(`${this.curUsedMemory}GB/${this.totalMemory}GB`)
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Medium)
          }.width(SizeToken.SIZE_PERCENT_100).justifyContent(FlexAlign.SpaceBetween)

          DataPanel({ values: this.dataPanelVals, max: this.maxVal, type: DataPanelType.Line })
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_NUM_10)
            .valueColors(this.colorArray)
        }
      }
      .margin({ bottom: PaddingToken.PADDING_12VP })
      .cardStyle()

      // A single-color DataPanel
      Row({ space: SpaceToken.SPACE_8 }) {
        Text(`${this.curLength}`)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)

        DataPanel({ values: this.dataPanelVals2, max: this.maxLength, type: DataPanelType.Line })
          .height(SizeToken.SIZE_NUM_10)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .contentModifier(new SolidDataPanelModifier()) // Inject custom rendering logic

        Text(`${this.maxLength}`)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
      }
      .margin({ bottom: PaddingToken.PADDING_12VP })
      .cardStyle()

      // Gradient DataPanel with offset
      Row({ space: SpaceToken.SPACE_8 }) {
        Text(`${this.curLength}`)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)

        DataPanel({ values: this.dataPanelVals3, max: this.maxLength, type: DataPanelType.Line })
          .height(SizeToken.SIZE_NUM_10)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .contentModifier(new GradientDataPanelModifier()) // Inject custom rendering logic

        Text(`${this.maxLength}`)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
      }
      .cardStyle()
    }
  }
}