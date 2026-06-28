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

import { AppStorageV2 } from '@kit.ArkUI';
import { SettingItem, getWindowInfoState, WindowInfo } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { NfcView } from '../view/NfcView';
import { EnableState } from '../viewmodel/SettingsViewModel';

@ComponentV2
export struct NfcPage {
  pathStack: NavPathStack = new NavPathStack();
  @Local isNfcEnabled: EnableState =
    AppStorageV2.connect<EnableState>(EnableState, () => new EnableState(false)) ?? new EnableState(false);
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local windowInfo: WindowInfo = getWindowInfoState();
  private paymentItem: SettingItem =
    new SettingItem('default-payment', $r('app.string.string_default_payment'), '', $r('app.string.string_not_set'));

  build() {
    NavDestination() {
      NfcView({
        blankHeight: this.blankHeight,
        windowInfo: this.windowInfo,
        paymentItem: this.paymentItem,
        isNfcEnabled: this.isNfcEnabled,
        onToggle: (value: boolean) => {
          this.isNfcEnabled.isEnableState = value;
        }
      })
    }
    .title('NFC')
    .backgroundColor($r('app.color.color_background_page'))
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
  }
}

@Builder
export function NfcPageBuilder() {
  NfcPage()
}