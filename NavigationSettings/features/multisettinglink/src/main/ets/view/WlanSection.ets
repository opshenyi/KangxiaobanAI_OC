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
import { WlanListItem } from './WlanListItem';

@ComponentV2
export struct WlanSection {
  @Param title: Resource | string = '';
  @Param wifiList: WifiInfo[] = [];
  @Event onInfoClick: (id: string) => void = () => {
  };

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.color_text_secondary'))
        .margin({ left: 12, bottom: 8, top: 28 })
        .alignSelf(ItemAlign.Start)
        .fontWeight(500)

      Column() {
        ForEach(this.wifiList, (wifi: WifiInfo, index: number) => {
          WlanListItem({
            wifi: wifi,
            onInfoClick: () => {
              this.onInfoClick(wifi.id);
            }
          })

          if (index < this.wifiList.length - 1) {
            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.color_divider'))
              .margin({
                left: 8,
                right: 8
              })
          }
        }, (wifi: WifiInfo, index: number) => wifi.id + index)
      }
      .width('100%')
      .backgroundColor($r('app.color.color_background_card'))
      .borderRadius(16)
      .padding(4)
    }
    .width('100%')
  }
}