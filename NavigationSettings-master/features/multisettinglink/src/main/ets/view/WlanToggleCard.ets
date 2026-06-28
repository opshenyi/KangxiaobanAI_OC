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

import { ListItemView, SettingItem } from 'multisettingbase';
import { ToggleItemView } from 'multisettingbase';

@ComponentV2
export struct WlanToggleCard {
  @Param isEnabled: boolean = true;
  @Param settingItems: SettingItem[] = [];
  @Event onToggle: (value: boolean) => void = () => {
  };
  @Event onSettingClick: (id: string) => void = () => {
  };

  build() {
    Column() {
      ToggleItemView({
        title: $r('app.string.string_wlan'),
        isEnabled: this.isEnabled,
        onToggle: (value: boolean) => {
          this.onToggle(value);
        }
      })

      if (this.settingItems.length > 0) {
        Divider()
          .strokeWidth(0.5)
          .color($r('app.color.color_divider'))
          .margin({ left: 8, right: 8 })

        ForEach(this.settingItems, (item: SettingItem, index: number) => {
          ListItemView({
            itemId: item.itemId,
            title: item.title,
            value: item.value,
            onItemClick: (_itemId: string) => {
              this.onSettingClick(item.itemId);
            }
          })

          if (index < this.settingItems.length - 1) {
            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.color_divider'))
              .margin({ left: 8, right: 8 })
          }
        }, (item: SettingItem) => item.itemId)
      }
    }
    .width('100%')
    .backgroundColor($r('app.color.color_background_card'))
    .borderRadius(16)
    .padding(4)
  }
}