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

import { SymbolGlyphModifier, uiObserver } from '@kit.ArkUI';
import { deviceInfo } from '@kit.BasicServicesKit';
import { hdsMaterial, HdsNavDestination, ScrollEffectType } from '@kit.UIDesignKit';
import { SettingItem, getWindowInfoState, WindowInfo } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { MoreWlanSettingsView } from '../view/MoreWlanSettingsView';

@ComponentV2
export struct MoreWlanSettingsPage {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  pathStack: NavPathStack = new NavPathStack();
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local windowInfo: WindowInfo = getWindowInfoState();
  private wlanPlusItem: SettingItem =
    new SettingItem('wlan-plus', $r('app.string.string_wlan_plus'), '', $r('app.string.string_enabled'));
  private wlanDirectItem: SettingItem = new SettingItem('wlan-direct', $r('app.string.string_wlan_direct'), '');
  private savedNetworksItem: SettingItem =
    new SettingItem('saved-networks', $r('app.string.string_saved_networks'), '');
  private installCertificateItem: SettingItem =
    new SettingItem('install-certificate', $r('app.string.string_install_certificate'), '');

  build() {
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      HdsNavDestination() {
        MoreWlanSettingsView({
          blankHeight: this.blankHeight,
          windowInfo: this.windowInfo,
          wlanPlusItem: this.wlanPlusItem,
          wlanDirectItem: this.wlanDirectItem,
          savedNetworksItem: this.savedNetworksItem,
          installCertificateItem: this.installCertificateItem
        })
      }
      .titleBar({
        content: {
          title: {
            mainTitle: $r('app.string.string_more_wlan_settings')
          },
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.dot_grid_2x2')
              }
            }]
          }
        },
        style: {
          scrollEffectOpts: {
            scrollEffectType: ScrollEffectType.GRADIENT_BLUR
          },
          systemMaterialEffect: {
            materialType: hdsMaterial.MaterialType.IMMERSIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          }
        }
      })
      .backgroundColor($r('app.color.color_background_page'))
      .onReady((context: NavDestinationContext) => {
        this.pathStack = context.pathStack;
      })
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    } else {
      NavDestination() {
        MoreWlanSettingsView({
          blankHeight: this.blankHeight,
          windowInfo: this.windowInfo,
          wlanPlusItem: this.wlanPlusItem,
          wlanDirectItem: this.wlanDirectItem,
          savedNetworksItem: this.savedNetworksItem,
          installCertificateItem: this.installCertificateItem
        })
      }
      .title($r('app.string.string_more_wlan_settings'))
      .menus([{ value: 'search', symbolIcon: new SymbolGlyphModifier($r('sys.symbol.dot_grid_2x2')) }])
      .backgroundColor($r('app.color.color_background_page'))
      .onReady((context: NavDestinationContext) => {
        this.pathStack = context.pathStack;
      })
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    }
  }
}

@Builder
export function MoreWlanSettingsPageBuilder() {
  MoreWlanSettingsPage()
}