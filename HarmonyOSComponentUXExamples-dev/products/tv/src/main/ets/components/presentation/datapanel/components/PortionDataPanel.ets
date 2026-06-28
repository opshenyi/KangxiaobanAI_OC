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

import { CommonConstants, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct PortionDataPanel {
  build() {
    Stack() {
      DataPanel({
        // The current data value of the DataPanel
        values: [50, 12, 8, 5],
        // DataPanel Maximum Value
        max: CommonConstants.INTEGER_100,
        // Types of data panels
        type: DataPanelType.Circle
      })
      // Set the color of each data segment
      //   .valueColors(this.colorArray)
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)

      RelativeContainer() {
        Text('75')
          .fontWeight(FontWeight.Medium)
          .fontSize(SizeToken.SIZE_NUM_80)
          .fontColor($r('sys.color.font_primary'))
          .lineHeight(SizeToken.SIZE_NUM_106)
          .id('PortionDataPanel_valueText')
          .margin({ top: SizeToken.SIZE_NUM_115 })
          .alignRules({
            middle: { anchor: '__container__', align: HorizontalAlign.Center },
          })

        Text($r('app.string.storage_use_label'))
          .fontSize($r('app.float.storage_use_text_size'))
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight($r('app.float.text_line_height27'))
          .alignRules({
            top: { anchor: 'PortionDataPanel_valueText', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })

        Text('%')
          .fontSize(SizeToken.SIZE_NUM_22)
          .lineHeight($r('app.float.text_line_height29'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_secondary'))
          .margin({ bottom: SizeToken.SIZE_NUM_60 })
          .alignRules({
            left: { anchor: 'PortionDataPanel_valueText', align: HorizontalAlign.End },
            center: { anchor: 'PortionDataPanel_valueText', align: VerticalAlign.Bottom }
          })
      }
    }
    .width($r('app.float.data_panel_size'))
    .height($r('app.float.data_panel_size'))
    .alignContent(Alignment.Center)
  }
}