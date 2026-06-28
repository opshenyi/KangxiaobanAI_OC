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

import { uiObserver } from '@kit.ArkUI';
import { deviceInfo } from '@kit.BasicServicesKit';
import {
ToggleItemView,
ListItemView,
SettingItem,
WindowInfo,
getWindowInfoState,
WidthBreakpointType
} from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';

@ComponentV2
export struct MoreWlanSettingsView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Param wlanPlusItem: SettingItem =
    new SettingItem('wlan-plus', $r('app.string.string_wlan_plus'), '', $r('app.string.string_enabled'));
  @Param wlanDirectItem: SettingItem = new SettingItem('wlan-direct', $r('app.string.string_wlan_direct'), '');
  @Param savedNetworksItem: SettingItem = new SettingItem('saved-networks', $r('app.string.string_saved_networks'), '');
  @Param installCertificateItem: SettingItem =
    new SettingItem('install-certificate', $r('app.string.string_install_certificate'), '');
  @Param scroller: Scroller = new Scroller();

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Column() {
          if (deviceInfo.distributionOSApiVersion >= 60100) {
            Blank()
              .height(this.blankHeight + this.windowInfo.statusBarTopVp)
          }

          Column() {
            ListItemView({
              itemId: this.wlanPlusItem.itemId,
              title: this.wlanPlusItem.title,
              value: $r('app.string.string_enabled')
            })
          }
          .width('100%')
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .padding(4)
          .margin({ top: 12 })

          Text($r('app.string.string_wlan_plus_desc'))
            .fontSize(12)
            .fontColor($r('app.color.color_text_tertiary'))
            .margin({ top: 28, left: 12, right: 12 })
            .fontWeight(500)

          Column() {
            ListItemView({
              itemId: this.wlanDirectItem.itemId,
              title: this.wlanDirectItem.title,
              value: this.wlanDirectItem.value
            })
          }
          .width('100%')
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .margin({ top: 8 })
          .padding(4)

          Column() {
            ToggleItemView({
              title: $r('app.string.string_wlan_security')
            })
          }
          .width('100%')
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .margin({ top: 12 })
          .padding(4)

          Text($r('app.string.string_wlan_security_desc'))
            .fontSize(12)
            .fontColor($r('app.color.color_text_tertiary'))
            .margin({ top: 28, left: 12, right: 12 })
            .fontWeight(500)

          Column() {
            ListItemView({
              itemId: this.savedNetworksItem.itemId,
              title: this.savedNetworksItem.title,
              value: this.savedNetworksItem.value
            })

            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.color_divider'))
              .margin({ left: 16, right: 16 })

            ListItemView({
              itemId: this.installCertificateItem.itemId,
              title: this.installCertificateItem.title,
              value: this.installCertificateItem.value
            })
          }
          .width('100%')
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .margin({ top: 8 })
          .padding(4)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .padding({
        left: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint),
        right: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint),
        bottom: 16
      })
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.color_background_page'))
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
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
          top: deviceInfo.distributionOSApiVersion >= 60100 ? this.blankHeight + this.windowInfo.statusBarTopVp : 0,
          bottom: 28
        })
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
  }
}