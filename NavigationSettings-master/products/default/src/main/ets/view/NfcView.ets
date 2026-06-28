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
import { EnableState } from '../viewmodel/SettingsViewModel';

@ComponentV2
export struct NfcView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Param paymentItem: SettingItem =
    new SettingItem('default-payment', $r('app.string.string_default_payment'), '', $r('app.string.string_not_set'));
  @Param isNfcEnabled: EnableState = new EnableState(false);
  @Event onToggle: (_value: boolean) => void = (_value: boolean) => {
  };
  @Param scroller: Scroller = new Scroller();

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Column() {
          if (deviceInfo.distributionOSApiVersion >= 60100) {
            Blank()
              .height(this.blankHeight + this.windowInfo.statusBarTopVp)
              .width('100%')
          }

          Row() {
            Image($r('app.media.ic_nfc'))
              .height('100%')
              .objectFit(ImageFit.Auto)
          }
          .margin({ top: 32 })
          .height('40%')

          Row() {
            Text($r('app.string.string_nfc_hint'))
              .fontWeight(500)
              .fontSize(12)
              .fontColor($r('app.color.color_text_secondary'))
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .margin({ top: 24 })
          .padding({ left: 28, right: 28 })
          .justifyContent(FlexAlign.Center)

          Row() {
            ToggleItemView({
              title: $r('app.string.string_nfc'),
              isEnabled: this.isNfcEnabled.isEnable,
              onToggle: (value: boolean) => {
                this.onToggle(value);
              }
            })
          }
          .borderRadius(16)
          .backgroundColor($r('app.color.color_background_card'))
          .width('100%')
          .padding(4)
          .margin({ top: 24 })

          Row() {
            ListItemView({
              itemId: this.paymentItem.itemId,
              title: this.paymentItem.title,
              value: this.paymentItem.value
            })
          }
          .backgroundColor($r('app.color.color_background_card'))
          .borderRadius(16)
          .width('100%')
          .margin({ top: 12 })
          .padding(4)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({
        left: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint),
        right: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint),
        bottom: 16
      })
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