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

import { uiObserver } from '@kit.ArkUI';
import { deviceInfo } from '@kit.BasicServicesKit';
import { ListItemView, WindowInfo, getWindowInfoState, WidthBreakpointType } from 'multisettingbase';
import { AccountItemView } from './AccountItemView';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance'
import { SettingsViewModel, SettingsItem } from '../viewmodel/SettingsViewModel';

@ComponentV2
export struct SettingsView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Param breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo = {
    widthBreakpoint: WidthBreakpoint.WIDTH_SM,
    heightBreakpoint: HeightBreakpoint.HEIGHT_SM
  };
  @Param selectedId: string = '';
  @Param pageStack: NavPathStack = new NavPathStack();
  @Param viewModel: SettingsViewModel = new SettingsViewModel();
  @Param scroller: Scroller = new Scroller();
  @Event onSelectedIdChange: (_id: string) => void = (_id: string) => {
  };

  @Builder
  SettingsGroup(items: Array<SettingsItem>) {
    Column() {
      ForEach(items, (item: SettingsItem, index: number) => {
        ListItemView({
          itemId: item.id,
          icon: item.icon,
          title: item.title,
          value: item.value,
          isSelected: this.selectedId === item.id,
          onItemClick: (itemId: string) => {
            this.pageStack.clear();
            if (itemId === 'wlan') {
              this.pageStack.pushPathByName('WlanPage', null);
            } else if (itemId === 'moreConnections') {
              this.pageStack.pushPathByName('MoreConnectionsPage', null);
            } else {
              this.pageStack.pushPathByName('multisettingDetailPage', item.title);
            }
            this.onSelectedIdChange(itemId);
          }
        })

        if (index < items.length - 1) {
          Divider()
            .strokeWidth(0.5)
            .color($r('app.color.comp_divider'))
            .margin({ left: 52, right: 8 })
        }
      }, (item: SettingsItem, index: number) => item.id + index)
    }
    .width('100%')
    .backgroundColor($r('app.color.comp_background_list_card'))
    .borderRadius(16)
    .margin({ bottom: 16 })
    .padding(4)
  }

  @Builder
  AccountGroup() {
    Column() {
      ForEach(this.viewModel.accountGroup, (item: SettingsItem) => {
        AccountItemView({
          icon: item.icon,
          title: item.title,
          subtitle: item.subtitle,
          isSelected: this.selectedId === item.id,
          onItemClick: () => {
            this.pageStack.clear();
            this.pageStack.pushPathByName('multisettingDetailPage', item.title);
            this.onSelectedIdChange(item.id);
          }
        })
      }, (item: SettingsItem, index: number) => item.id + index)
    }
    .width('100%')
    .backgroundColor($r('app.color.comp_background_list_card'))
    .borderRadius(16)
    .margin({ bottom: 16 })
    .padding(4)
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Column() {
          if (deviceInfo.distributionOSApiVersion >= 60100) {
            Blank()
              .width('100%')
              .height(this.blankHeight + this.windowInfo.statusBarTopVp)
          }

          Search({ placeholder: $r('app.string.string_search_settings') })
            .width('100%')
            .visibility(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
              this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? Visibility.None : Visibility.Visible)
            .margin({ bottom: 16, top: 12 })

          this.AccountGroup()

          this.SettingsGroup(this.viewModel.connectionGroup)

          this.SettingsGroup(this.viewModel.personalizationGroup)

          this.SettingsGroup(this.viewModel.systemGroup)
        }
        .width('100%')
        .padding({ bottom: this.windowInfo.navigationBarBottomVp })
      }
      .width('100%')
      .backgroundColor($r('app.color.color_background_page'))
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      .padding({
        left: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint),
        right: new WidthBreakpointType(16, 16, 24, 24).getValue(this.breakpoint.widthBreakpoint)
      })
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)

      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      })
        .width(9)
        .height('100%')
        .margin({
          top: deviceInfo.distributionOSApiVersion >= 60100 ? this.blankHeight + this.windowInfo.statusBarTopVp : 0,
          bottom: 28
        })
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
  }
}