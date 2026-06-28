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

export class SettingsViewModel {
  public accountGroup: Array<SettingsItem> = [
    {
      id: 'account',
      title: $r('app.string.string_login_huawei_account'),
      subtitle: $r('app.string.string_huawei_account_desc'),
      icon: $r('app.media.ic_person'),
      value: ''
    }
  ];
  public connectionGroup: Array<SettingsItem> = [
    {
      id: 'wlan',
      title: $r('app.string.string_wlan'),
      subtitle: '',
      icon: $r('app.media.ic_wlan'),
      value: 'HUAWEI-Guest'
    },
    {
      id: 'bluetooth',
      title: $r('app.string.string_bluetooth'),
      subtitle: '',
      icon: $r('app.media.ic_bluetooth'),
      value: $r('app.string.string_enabled')
    },
    {
      id: 'mobileNetwork',
      title: $r('app.string.string_mobile_network'),
      subtitle: '',
      icon: $r('app.media.ic_mobile_network'),
      value: ''
    },
    {
      id: 'superDevice',
      title: $r('app.string.string_super_device'),
      subtitle: '',
      icon: $r('app.media.ic_super_device'),
      value: ''
    },
    {
      id: 'moreConnections',
      title: $r('app.string.string_more_connections'),
      subtitle: '',
      icon: $r('app.media.ic_more_connections'),
      value: ''
    }
  ];
  public personalizationGroup: Array<SettingsItem> = [
    {
      id: 'desktop',
      title: $r('app.string.string_desktop_personalization'),
      subtitle: '',
      icon: $r('app.media.ic_desktop'),
      value: ''
    },
    {
      id: 'display',
      title: $r('app.string.string_display_brightness'),
      subtitle: '',
      icon: $r('app.media.ic_display'),
      value: ''
    },
    {
      id: 'sound',
      title: $r('app.string.string_sound_vibration'),
      subtitle: '',
      icon: $r('app.media.ic_voice'),
      value: ''
    },
    {
      id: 'notification',
      title: $r('app.string.string_notifications_status'),
      subtitle: '',
      icon: $r('app.media.ic_notification'),
      value: ''
    }
  ];
  public systemGroup: Array<SettingsItem> = [
    {
      id: 'system',
      title: $r('app.string.string_system'),
      subtitle: '',
      icon: $r('app.media.ic_system'),
      value: ''
    },
    {
      id: 'apps',
      title: $r('app.string.string_apps_service'),
      subtitle: '',
      icon: $r('app.media.ic_apps'),
      value: ''
    },
    {
      id: 'digitalHealth',
      title: $r('app.string.string_healthy_use'),
      subtitle: '',
      icon: $r('app.media.ic_health'),
      value: ''
    },
    {
      id: 'accessibility',
      title: $r('app.string.string_accessibility'),
      subtitle: '',
      icon: $r('app.media.ic_accessibility'),
      value: ''
    },
    {
      id: 'storage',
      title: $r('app.string.string_storage'),
      subtitle: '',
      icon: $r('app.media.ic_store'),
      value: ''
    },
    {
      id: 'battery',
      title: $r('app.string.string_battery'),
      subtitle: '',
      icon: $r('app.media.ic_battery'),
      value: ''
    },
    {
      id: 'biometric',
      title: $r('app.string.string_biometric_password'),
      subtitle: '',
      icon: $r('app.media.ic_biometric'),
      value: ''
    },
    {
      id: 'privacy',
      title: $r('app.string.string_privacy_security'),
      subtitle: '',
      icon: $r('app.media.ic_privacy'),
      value: ''
    }
  ];
}

export interface SettingsItem {
  id: string;
  title: Resource | string;
  subtitle: Resource | string;
  icon: ResourceStr;
  value: Resource | string;
}

@ObservedV2
export class EnableState {
  @Trace public isEnableState: boolean = false;

  constructor(isEnableState: boolean) {
    this.isEnableState = isEnableState;
  }
}