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

import { AppStorageV2, SymbolGlyphModifier, uiObserver } from '@kit.ArkUI';
import { deviceInfo } from '@kit.BasicServicesKit';
import { hdsMaterial, HdsNavDestination, ScrollEffectType } from '@kit.UIDesignKit';
import { SettingItem, WindowInfo, getWindowInfoState } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { EnableState } from '../viewmodel/SettingsViewModel';
import { MoreConnectionsView } from '../view/MoreConnectionsView';

@ComponentV2
export struct MoreConnectionsPage {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  pathStack: NavPathStack = new NavPathStack();
  @Local isNfcEnabled: EnableState =
    AppStorageV2.connect<EnableState>(EnableState, () => new EnableState(false)) ?? new EnableState(false);
  private nfcItem: SettingItem =
    new SettingItem('nfc', 'NFC', '');
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local windowInfo: WindowInfo = getWindowInfoState();

  @Builder
  MoreConnectionsViewBuilder() {
    MoreConnectionsView({
      blankHeight: this.blankHeight,
      windowInfo: this.windowInfo,
      nfcItem: this.nfcItem,
      isNfcEnabled: this.isNfcEnabled,
      onNfcClick: () => {
        this.pathStack.pushPathByName('NfcPage', null);
      }
    })
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      HdsNavDestination() {
        this.MoreConnectionsViewBuilder()
      }
      .hideBackButton(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM ? false : true)
      .titleBar({
        content: {
          title: {
            mainTitle: $r('app.string.string_more_connections')
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
        this.pathStack = context.pathStack
      })
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    } else {
      NavDestination() {
        this.MoreConnectionsViewBuilder()
      }
      .hideBackButton(!(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM))
      .title($r('app.string.string_more_connections'))
      .menus([{ value: 'search', symbolIcon: new SymbolGlyphModifier($r('sys.symbol.dot_grid_2x2')) }])
      .backgroundColor($r('app.color.color_background_page'))
      .onReady((context: NavDestinationContext) => {
        this.pathStack = context.pathStack
      })
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    }
  }
}

@Builder
export function MoreConnectionsPageBuilder() {
  MoreConnectionsPage()
}