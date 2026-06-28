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
import { hdsMaterial, HdsNavigation, HdsNavigationTitleMode, ScrollEffectType } from '@kit.UIDesignKit';
import { WidthBreakpointType, WindowInfo, getWindowInfoState } from 'multisettingbase';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { SettingsViewModel } from '../viewmodel/SettingsViewModel';
import { SettingsView } from '../view/SettingsView';

@ComponentV2
export struct SettingsPage {
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Local selectedId: string = '';
  @Local windowInfo: WindowInfo = getWindowInfoState();
  private viewModel: SettingsViewModel = new SettingsViewModel();
  scroller: Scroller = new Scroller();
  pageStack: NavPathStack = new NavPathStack();

  aboutToAppear() {
    if (this.breakpoint.widthBreakpoint !== WidthBreakpoint.WIDTH_SM) {
      this.pageStack.pushPathByName('WlanPage', null);
      this.selectedId = 'wlan';
    }
    this.pageStack.disableAnimation(true);
  }

  @Monitor('windowInfo.widthBp')
  updatePageStack() {
    if (this.breakpoint.widthBreakpoint !== WidthBreakpoint.WIDTH_SM && this.pageStack.size() === 0) {
      this.pageStack.pushPathByName('WlanPage', null);
      this.selectedId = 'wlan';
    }
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      HdsNavigation(this.pageStack) {
        SettingsView({
          blankHeight: this.blankHeight,
          windowInfo: this.windowInfo,
          breakpoint: this.breakpoint,
          selectedId: this.selectedId,
          pageStack: this.pageStack,
          viewModel: this.viewModel,
          scroller: this.scroller,
          onSelectedIdChange: (id: string) => {
            this.selectedId = id;
          }
        })
      }
      .titleBar({
        content: {
          title: {
            mainTitle: $r('app.string.string_settings')
          },
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.magnifyingglass')
              }
            }],
            maxCount: this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
              this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? 1 : 0
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
      .titleMode(HdsNavigationTitleMode.MINI)
      .hideBackButton(true)
      .backgroundColor($r('app.color.color_background_page'))
      .bindToScrollable([this.scroller])
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
      .navBarWidth(new WidthBreakpointType('100%', '50%', '36%', '36%').getValue(this.breakpoint.widthBreakpoint))
      .onNavBarStateChange((isVisible: boolean) => {
        if (isVisible && this.pageStack.size() === 0) {
          this.selectedId = '';
        }
      })
    } else {
      Navigation(this.pageStack) {
        SettingsView({
          blankHeight: this.blankHeight,
          windowInfo: this.windowInfo,
          breakpoint: this.breakpoint,
          selectedId: this.selectedId,
          pageStack: this.pageStack,
          viewModel: this.viewModel,
          scroller: this.scroller,
          onSelectedIdChange: (id: string) => {
            this.selectedId = id;
          }
        })
      }
      .title($r('app.string.string_settings'))
      .menus(
        this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
          this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ?
          [{ value: 'search', symbolIcon: new SymbolGlyphModifier($r('sys.symbol.magnifyingglass')) }] : []
      )
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .backgroundColor($r('app.color.color_background_page'))
      .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
      .navBarWidth(new WidthBreakpointType('100%', '50%', '36%', '36%').getValue(this.breakpoint.widthBreakpoint))
      .onNavBarStateChange((isVisible: boolean) => {
        if (isVisible && this.pageStack.size() === 0) {
          this.selectedId = '';
        }
      })
    }
  }
}