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
import { CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct ProgressStyleDataPanel {
  @Local colorArray: (LinearGradient | ResourceColor)[] = [];
  @Local dataPanelVals: number[] = [];
  private versionCode: string = '1.0.0';
  private unit: string = '%';
  private maxVal: number = 100;

  @Computed
  private get totalVal(): number {
    return this.dataPanelVals.reduce((acc: number, cur: number) => acc + cur, 0);
  }

  aboutToAppear(): void {
    if (this.dataPanelVals.length === 0) {
      this.dataPanelVals.push(30);
    }
    if (this.colorArray.length === 0) {
      const linearGradientColor: LinearGradient =
        new LinearGradient([{ color: '#86C1FF', offset: 0 }, { color: '#254FF7', offset: 1 }]);
      this.colorArray.push(linearGradientColor);
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.progress_style_label'))

      Row() {
        Stack() {
          // Single-segment ring data panel
          DataPanel({ values: this.dataPanelVals, max: this.maxVal, type: DataPanelType.Circle })
            .width(SizeToken.SIZE_NUM_288)
            .height(SizeToken.SIZE_NUM_288)
            .valueColors(this.colorArray)

          Column() {
            Text(`${this.totalVal}`)
              .fontSize($r('sys.float.Display_L'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)

            Text(this.versionCode)
              .fontSize($r('sys.float.Body_L'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Medium)
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