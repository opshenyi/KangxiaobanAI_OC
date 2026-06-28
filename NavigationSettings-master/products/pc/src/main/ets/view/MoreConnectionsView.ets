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

import { ListItemView, SettingItem, WindowInfo, getWindowInfoState } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance'
import { EnableState } from '../viewmodel/SettingsViewModel';

@ComponentV2
export struct MoreConnectionsView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Param nfcItem: SettingItem = new SettingItem('nfc', $r('app.string.string_nfc'), '');
  @Param isNfcEnabled: EnableState = new EnableState(false);
  @Event onNfcClick: () => void = () => {
  };

  build() {
    Scroll() {
      Column() {
        Column() {
          ListItemView({
            itemId: this.nfcItem.itemId,
            title: this.nfcItem.title,
            value: this.isNfcEnabled.isEnableState ? $r('app.string.string_enabled') : $r('app.string.string_disabled'),
            onItemClick: () => {
              this.onNfcClick();
            }
          })
        }
        .width('100%')
        .backgroundColor($r('app.color.color_background_card'))
        .borderRadius(16)
        .margin({ top: 12 })
        .padding(4)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
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