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

import { CommonConstants, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct SureProgress {
  private currentValue: number = CommonConstants.INTEGER_30;
  private color: LinearGradient = new LinearGradient([
    { color: '#86CEFF', offset: CommonConstants.INTEGER_0 },
    { color: '#254FF7', offset: CommonConstants.INTEGER_1 }
  ]);
  private colorArray: LinearGradient[] = [this.color];

  build() {
    RelativeContainer() {
      DataPanel({
        // The current data value of the DataPanel
        values: [this.currentValue],
        // DataPanel Maximum Value
        max: CommonConstants.INTEGER_100,
        // Types of data panels
        type: DataPanelType.Circle
      })
      // Set the color of each data segment
        .valueColors(this.colorArray)
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)

      Column() {
        Text(this.currentValue.toString())
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.sure_progress_text_size'))
          .fontColor($r('sys.color.font_primary'))
          .lineHeight($r('app.float.text_line_height98'))
        Text('1.0.0')
          .fontWeight(FontWeight.Medium)
          .fontSize(SizeToken.SIZE_NUM_22)
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight($r('app.float.text_line_height29'))
          .margin({ top: PaddingToken.PADDING_8VP })
      }
      .id('SureProgress_valueText')
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center }
      })

      Text('%')
        .fontSize(SizeToken.SIZE_NUM_22)
        .lineHeight($r('app.float.text_line_height29'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_secondary'))
        .alignRules({
          left: { anchor: 'SureProgress_valueText', align: HorizontalAlign.End },
          center: { anchor: 'SureProgress_valueText', align: VerticalAlign.Center }
        })
    }
    .width($r('app.float.data_panel_size'))
    .height($r('app.float.data_panel_size'))
  }
}