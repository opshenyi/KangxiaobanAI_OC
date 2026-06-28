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
import { WlanViewModel, WlanData } from 'multisettinglink';
import { getWindowInfoState, WindowInfo, Logger } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { WlanView } from '../view/WlanView';

const TAG = 'WlanPage';

@ComponentV2
export struct WlanPage {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  private viewModel: WlanViewModel = new WlanViewModel();
  @Local wlanData: WlanData = this.viewModel.getWlanData();
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local windowInfo: WindowInfo = getWindowInfoState();
  pathStack: NavPathStack = new NavPathStack();

  @Builder
  WlanViewBuilder() {
    WlanView({
      blankHeight: this.blankHeight,
      windowInfo: this.windowInfo,
      wlanData: this.wlanData,
      viewModel: this.viewModel,
      onToggle: (value: boolean) => {
        this.wlanData.isWlanEnabled = value;
      },
      onSettingClick: (id: string) => {
        if (id === 'more-wlan-settings') {
          this.pathStack.pushPathByName('MoreWlanSettingsPage', null);
        } else {
          Logger.info(TAG, 'Setting clicked:', id);
        }
      },
      onInfoClick: (id: string) => {
        Logger.info(TAG, 'Info clicked for:', id);
      }
    })
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      HdsNavDestination() {
        this.WlanViewBuilder()
      }
      .hideBackButton(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM ? false : true)
      .titleBar({
        content: {
          title: {
            mainTitle: 'WLAN'
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
        this.WlanViewBuilder()
      }
      .hideBackButton(!(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM))
      .title('WLAN')
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
export function WlanPageBuilder() {
  WlanPage()
}