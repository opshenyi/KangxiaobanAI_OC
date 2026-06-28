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

import { WlanViewModel, WlanToggleCard, WlanSection, WlanData } from 'multisettinglink';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance'
import { WindowInfo, getWindowInfoState } from 'multisettingbase';

@ComponentV2
export struct WlanView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Require @Param wlanData: WlanData;
  @Param viewModel: WlanViewModel = new WlanViewModel();
  @Event onToggle: (value: boolean) => void = (_value: boolean) => {
  };
  @Event onSettingClick: (id: string) => void = (_id: string) => {
  };
  @Event onInfoClick: (id: string) => void = (_id: string) => {
  };
  @Param scroller: Scroller = new Scroller();

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Column() {
          WlanToggleCard({
            isEnabled: this.wlanData.isWlanEnabled,
            settingItems: this.wlanData.settingItems,
            onToggle: (value: boolean) => {
              this.onToggle(value);
            },
            onSettingClick: (id: string) => {
              this.onSettingClick(id);
            }
          })
            .margin({ top: 12 })

          if (this.wlanData.availableWifi.length > 0) {
            WlanSection({
              title: $r('app.string.string_available_wlan'),
              wifiList: this.wlanData.availableWifi,
              onInfoClick: (id: string) => {
                this.onInfoClick(id);
              }
            })
          }

          if (this.wlanData.otherWifi.length > 0) {
            WlanSection({
              title: $r('app.string.string_other_wlan'),
              wifiList: this.wlanData.otherWifi,
              onInfoClick: (id: string) => {
                this.onInfoClick(id);
              }
            })
          }

          Row() {
            Text($r('app.string.string_add_network'))
              .fontSize(16)
              .fontColor($r('app.color.color_text_link'))
          }
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .width('100%')
          .height(56)
          .margin({ top: 12 })
          .padding({ left: 12 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.color_background_page'))
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      .padding({
        left: 24,
        right: 24,
        bottom: 16
      })
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)

      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      })
        .width(9)
        .height('100%')
        .margin({
          bottom: 28
        })
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
  }
}