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

import { WifiInfo, WlanData } from '../model/WlanModel';
import { SettingItem } from 'multisettingbase';

export class WlanViewModel {
  getWlanData(): WlanData {
    return {
      isWlanEnabled: true,
      availableWifi: this.getAvailableWifi(),
      otherWifi: this.getOtherWifi(),
      settingItems: this.getSettingItems()
    };
  }

  private getAvailableWifi(): WifiInfo[] {
    return [
      {
        id: 'huawei-guest',
        name: 'Huawei-Guest',
        isConnected: true,
        status: $r('app.string.string_connected'),
      }
    ];
  }

  private getOtherWifi(): WifiInfo[] {
    return [
      {
        id: 'Huawei-Guest1',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest2',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest3',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest4',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest5',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest6',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest7',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest8',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest9',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      },
      {
        id: 'Huawei-Guest10',
        name: 'Huawei-Guest',
        isConnected: false,
        status: $r('app.string.string_saved_internet')
      }
    ];
  }

  private getSettingItems(): SettingItem[] {
    return [
      new SettingItem('network-accelerate', $r('app.string.string_network_accelerate'), '',
        $r('app.string.string_disabled')),
      new SettingItem('more-wlan-settings', $r('app.string.string_more_wlan_settings'), '')
    ];
  }
}