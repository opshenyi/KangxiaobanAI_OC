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

import { hdsMaterial, HdsNavigation, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { uiObserver } from '@kit.ArkUI';
import {
  BuildDirtyDataUtil,
  CommonConstants,
  HdsNavigationModifier,
  TabBarListModel,
  TabBarModel,
  WidthBreakpointType
} from 'commonmultidevicecommunication';
import { MessagesPage } from './MessagesPage';
import { ContactsPage } from './ContactsPage';
import { SocialPage } from './SocialPage';
import { MinePage } from './MinePage';

@Entry
@ComponentV2
struct Index {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Provider() pathStack: NavPathStack = new NavPathStack(); // pathStack api 22
  @Local tabs: TabBarModel[] = [];
  @Local currentIndex: number = 0;
  @Local navigationMode: NavigationMode = NavigationMode.Auto;
  private controller: HdsTabsController = new HdsTabsController();

  aboutToAppear(): void {
    this.tabs = new TabBarListModel().loadTabs();
    BuildDirtyDataUtil.buildDirtyData();
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      HdsNavigation(this.pathStack) {
        HdsTabs({ controller: this.controller }) {
          ForEach(this.tabs, (item: TabBarModel) => {
            this.ChatTabContent(item, true)
          }, (item: TabBarModel) => `${item.index}`)
        }
        .scrollable(false)
        .animationDuration(0)
        .barOverlap(true)
        .barPosition(BarPosition.End)
        .vertical(false)
        .barFloatingStyle({
          systemMaterialEffect: {
            materialType: hdsMaterial.MaterialType.IMMERSIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          },
          barBottomMargin: this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
            this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? 16 : 0
        })
        .onChange((index: number) => {
          this.currentIndex = index;
          this.changeNavigationMode(index);
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .attributeModifier(new HdsNavigationModifier(this.breakpoint.widthBreakpoint, this.navigationMode))
    } else {
      Navigation(this.pathStack) {
        Tabs({
          barPosition: this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? BarPosition.Start :
            BarPosition.End,
          index: this.currentIndex
        }) {
          ForEach(this.tabs, (item: TabBarModel) => {
            this.ChatTabContent(item, false)
          }, (item: TabBarModel) => `${item.index}`)
        }
        .scrollable(false)
        .vertical(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? true : false)
        .barMode(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? BarMode.Scrollable : BarMode.Fixed)
        .animationDuration(0)
        .barBackgroundColor($r('app.color.background_secondary'))
        .onChange((index: number) => {
          this.currentIndex = index;
          this.changeNavigationMode(index);
        })
        .barWidth(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? 96 : '100%')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .navBarWidth(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? '45%' : '50%')
      .mode(this.navigationMode)
      .hideToolBar(true)
    }
  }

  @Builder
  ChatTabContent(item: TabBarModel, isHighApiLevel: boolean) {
    TabContent() {
      if (item.index === CommonConstants.TAB_MESSAGE_INDEX) {
        MessagesPage({ activeIndex: this.currentIndex })
      } else if (item.index === CommonConstants.TAB_CONTACT_INDEX) {
        ContactsPage({ activeIndex: this.currentIndex })
      } else if (item.index === CommonConstants.TAB_SOCIAL_INDEX) {
        SocialPage({ activeIndex: this.currentIndex })
      } else {
        MinePage({ activeIndex: this.currentIndex })
      }
    }
    .tabBar(isHighApiLevel ? this.ChatTabBar23(item) : this.ChatTabBar(item))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  ChatTabBar23(item: TabBarModel) {
    Column() {
      this.TabBarColumn(item);
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ChatTabBar(item: TabBarModel) {
    Column() {
      this.TabBarColumn(item);
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .margin({ top: this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ? 64 : 0 })
  }

  @Builder
  TabBarColumn(item: TabBarModel) {
    Column() {
      SymbolGlyph(item.img)
        .fontSize(24)
        .fontColor([this.currentIndex === item.index ? $r('app.color.font_emphasize') :
          $r('app.color.font_tertiary')])
      Text(item.title)
        .fontColor(this.currentIndex === item.index ? $r('app.color.font_emphasize') :
          $r('app.color.font_tertiary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .fontSize(10)
        .lineHeight(14)
        .margin({ top: 4 })
    }
  }

  changeNavigationMode(index: number) {
    if (index === CommonConstants.TAB_SOCIAL_INDEX || index === CommonConstants.TAB_MINE_INDEX) {
      this.navigationMode = NavigationMode.Stack;
    } else {
      this.navigationMode = NavigationMode.Auto;
    }
  }
}