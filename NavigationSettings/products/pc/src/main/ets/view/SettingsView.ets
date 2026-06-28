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

import { ListItemView, WindowInfo, getWindowInfoState } from 'multisettingbase';
import { SettingsViewModel, SettingsItem } from '../viewmodel/SettingsViewModel';
import { AccountItemView } from './AccountItemView';
import { TITLE_BAR_HEIGHT_MINI } from '../common/CommonConstance';

@ComponentV2
export struct SettingsView {
  @Param blankHeight: number = TITLE_BAR_HEIGHT_MINI;
  @Param windowInfo: WindowInfo = getWindowInfoState();
  @Param selectedId: string = '';
  @Param pageStack: NavPathStack = new NavPathStack();
  @Param viewModel: SettingsViewModel = new SettingsViewModel();
  @Param scroller: Scroller = new Scroller();
  @Event onSelectedIdChange: (_id: string) => void = (_id: string) => {
  };

  @Builder
  SettingsGroup(items: Array<SettingsItem>) {
    Column() {
      ForEach(items, (item: SettingsItem) => {
        ListItemView({
          itemId: item.id,
          icon: item.icon,
          title: item.title,
          value: item.value,
          isSelected: this.selectedId === item.id,
          hasChevron: false,
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
      }, (item: SettingsItem, index: number) => item.id + index)
    }
    .width('100%')
    .borderRadius(16)
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
    .borderRadius(16)
  }

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .aspectRatio(1)
          Text($r('app.string.PcAbility_label'))
            .fontSize(20)
            .margin({ left: 16 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .height(64)

        Search({ placeholder: $r('app.string.string_search_settings') })
          .width('100%')
      }
      .padding({
        left: 24, right: 24
      })

      Divider()
        .strokeWidth(0.5)
        .color($r('app.color.comp_divider'))
        .width('100%')
        .margin({
          bottom: 8,
          top: 8,
        })

      Stack({ alignContent: Alignment.End }) {
        Scroll(this.scroller) {
          Column() {
            this.AccountGroup()

            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.comp_divider'))
              .margin({
                bottom: 8,
                top: 8,
              })

            this.SettingsGroup(this.viewModel.connectionGroup)

            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.comp_divider'))
              .margin({
                bottom: 8,
                top: 8,
              })

            this.SettingsGroup(this.viewModel.personalizationGroup)

            Divider()
              .strokeWidth(0.5)
              .color($r('app.color.comp_divider'))
              .margin({
                bottom: 8,
                top: 8,
              })

            this.SettingsGroup(this.viewModel.systemGroup)
          }
        }
        .backgroundColor($r('app.color.color_background_page'))
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .padding({
          left: 24, right: 24, bottom: 24
        })
        .layoutWeight(1)
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
            bottom: 28
          })
          .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .layoutWeight(1)
    }
  }
}