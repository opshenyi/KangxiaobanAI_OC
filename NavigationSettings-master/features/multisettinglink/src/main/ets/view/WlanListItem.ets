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

import { WifiInfo } from '../model/WlanModel';

@ComponentV2
export struct WlanListItem {
  @Param wifi: WifiInfo = {
    id: '',
    name: '',
    isConnected: false
  };
  @Event onInfoClick: () => void = () => {
  };

  build() {
    Row() {
      Column() {
        Text(this.wifi.name)
          .fontSize(16)
          .fontWeight(500)
          .fontColor(this.wifi.isConnected ? $r('app.color.color_text_link') : $r('app.color.color_text_primary'))
          .lineHeight(21)

        Text(this.wifi.status)
          .fontSize(14)
          .fontColor($r('app.color.color_text_secondary'))
          .margin({ top: 2 })
          .lineHeight(19)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()

      SymbolGlyph($r('sys.symbol.wifi_6_badge_lock'))
        .fontSize(24)
        .fontColor([$r('app.color.color_text_primary')])
    }
    .width('100%')
    .height(48)
    .padding({ left: 8, right: 8 })
    .margin({
      top: 4,
      bottom: 4
    })
  }
}