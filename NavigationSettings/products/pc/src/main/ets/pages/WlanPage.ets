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

import { Logger } from 'multisettingbase';
import { WlanViewModel, WlanData } from 'multisettinglink';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';
import { getWindowInfoState, WindowInfo } from 'multisettingbase';
import { WlanView } from '../view/WlanView';

const TAG = 'WlanPage';

@ComponentV2
export struct WlanPage {
  private viewModel: WlanViewModel = new WlanViewModel();
  @Local wlanData: WlanData = this.viewModel.getWlanData();
  @Local blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Local windowInfo: WindowInfo = getWindowInfoState();
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
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
    .hideBackButton(true)
    .title('WLAN')
    .backgroundColor($r('app.color.color_background_page'))
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
  }
}

@Builder
export function WlanPageBuilder() {
  WlanPage()
}