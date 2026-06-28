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

import { WindowInfo, getWindowInfoState } from 'multisettingbase';
import { SettingsViewModel } from '../viewmodel/SettingsViewModel';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance'
import { SettingsView } from '../view/SettingsView'

@ComponentV2
export struct SettingsPage {
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local selectedId: string = '';
  @Local windowInfo: WindowInfo = getWindowInfoState();
  private viewModel: SettingsViewModel = new SettingsViewModel();
  scroller: Scroller = new Scroller();
  pageStack: NavPathStack = new NavPathStack();

  aboutToAppear() {
    this.pageStack.pushPathByName('WlanPage', null);
    this.selectedId = 'wlan';
    this.pageStack.disableAnimation(true);
  }

  build() {
    Navigation(this.pageStack) {
      SettingsView({
        blankHeight: this.blankHeight,
        windowInfo: this.windowInfo,
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
    .hideTitleBar(true)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
    .backgroundColor($r('app.color.color_background_page'))
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    .navBarWidth('33%')
  }
}