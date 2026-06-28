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
export struct UnsureProgress {
  private color: LinearGradient = new LinearGradient([
    { color: '#0086CEFF', offset: CommonConstants.INTEGER_0 },
    { color: '#254FF7', offset: CommonConstants.INTEGER_1 }
  ]);
  private colorArray: LinearGradient[] = [this.color];

  build() {
    Stack() {
      DataPanel({
        // The current data value of the DataPanel
        values: [CommonConstants.INTEGER_30],
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
        Text('Harmony OS')
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.unsure_progress_text_size'))
          .fontColor($r('sys.color.font_primary'))
          .lineHeight($r('app.float.text_line_height98'))
        Text('x.x.x')
          .fontWeight(FontWeight.Medium)
          .fontSize(SizeToken.SIZE_NUM_22)
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight($r('app.float.text_line_height29'))
          .margin({ top: PaddingToken.PADDING_12VP })
      }
    }
    .width($r('app.float.data_panel_size'))
    .height($r('app.float.data_panel_size'))
  }
}