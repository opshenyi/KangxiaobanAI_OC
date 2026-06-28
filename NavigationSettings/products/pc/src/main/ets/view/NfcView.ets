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

import { ToggleItemView, ListItemView, SettingItem, WindowInfo, getWindowInfoState } from 'multisettingbase';
import { EnableState } from '../viewmodel/SettingsViewModel';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';

@ComponentV2
export struct NfcView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Param paymentItem: SettingItem = new SettingItem('default-payment', $r('app.string.string_default_payment'), '', $r('app.string.string_not_set'));
  @Param isNfcEnabled: EnableState = new EnableState(false);
  @Event onToggle: (_value: boolean) => void = (_value: boolean) => {
  };

  build() {
    Scroll() {
      Column() {
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
            isEnabled: this.isNfcEnabled.isEnableState,
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
      .height('100%')
    }
    .padding({ left: 24, right: 24, bottom: 16 })
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_background_page'))
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .align(Alignment.TopStart)
  }
}