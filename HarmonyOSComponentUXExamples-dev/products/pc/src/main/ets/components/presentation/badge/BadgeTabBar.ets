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

import {
  BreakpointModel,
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken
} from 'componentuxexamplesbase';

@Builder
export function BadgeTabBarBuilder() {
  BadgeTabBar()
}

@ComponentV2
struct BadgeTabBar {
  // selectedIndex controls the text color switching inside the custom TabBar
  @Local selectedIndex: number = 0;
  // currentIndex controls which tab page is displayed in the TabContent
  @Local currentIndex: number = 0;
  @Local tabArray: number[] = [0, 1, 2, 3];
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  // Whether to show unread notifications
  @Local hasUnreadMessages: boolean = true;
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private controller: TabsController = new TabsController();

  aboutToAppear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
  }

  aboutToDisappear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  tabTextBuilder(index: number) {
    Text(`Tab${index + 1}`)
      .fontColor(this.selectedIndex === index ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
      .fontSize($r('sys.float.Body_L'))
      .fontWeight(FontWeight.Medium)
      .lineHeight(SizeToken.SIZE_NUM_22)
      .width(SizeToken.SIZE_NUM_46)
  }

  @Builder
  tabBarBuilder(index: number) {
    Column() {
      Row({ space: SpaceToken.SPACE_8 }) {
        SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor(this.selectedIndex === index ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_tertiary')])

        if (index === 1 && this.hasUnreadMessages) {
          Badge({
            value: CommonConstants.EMPTY_STRING,
            position: BadgePosition.Right,
            style: {
              badgeSize: SizeToken.SIZE_NUM_6
            }
          }) {
            this.tabTextBuilder(index)
          }
        } else {
          this.tabTextBuilder(index)
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
      .padding({ left: PaddingToken.PADDING_8VP })
      .backgroundColor(this.selectedIndex === index ? $r('app.color.list_item_selected_color') : Color.Transparent)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_40)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP
    })
    .onClick(() => {
      if (this.hasUnreadMessages && index === 1) {
        this.hasUnreadMessages = false;
      }
      this.controller.changeIndex(index);
    })
  }

  @Builder
  customTitleBar() {
    Row() {
      Button({ stateEffect: true }) {
        Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
          .height(SizeToken.SIZE_NUM_24)
          .width(SizeToken.SIZE_NUM_24)
          .fillColor($r('sys.color.font_primary'))
      }
      .width(SizeToken.SIZE_NUM_40)
      .height(SizeToken.SIZE_NUM_40)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
      .buttonStyle(ButtonStyleMode.TEXTUAL)
      .backgroundColor(Color.Transparent)
      .onClick(this.handleBackNavigation)

      Text($r('app.string.sidebar_badge_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .alignItems(VerticalAlign.Center)
    .padding({ left: PaddingToken.PADDING_16VP })
  }

  @Builder
  tabContentBuilder(index: number) {
    Column() {
      this.customTitleBar()
      Row() {
        this.tabTextBuilder(index)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.background_primary'))
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          Row({ space: SpaceToken.SPACE_8 }) {
            Image($r('app.media.startIcon'))
              .height(SizeToken.SIZE_NUM_24)
              .width(SizeToken.SIZE_NUM_24)

            Text($r('app.string.index_title'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Title_S'))
              .fontWeight(FontWeight.Medium)
          }
          .height(SizeToken.SIZE_NUM_56)
          .width(SizeToken.SIZE_NUM_240)
          .padding({ left: PaddingToken.PADDING_24VP })

          Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
            ForEach(this.tabArray, (item: number) => {
              this.tabBarBuilder(item)
            }, (item: number, index: number) => `${item}_${index}`)
          }
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        }
        .width(SizeToken.SIZE_NUM_240)
        .height(SizeToken.SIZE_PERCENT_100)

        Tabs({ controller: this.controller }) {
          ForEach(this.tabArray, (item: number) => {
            TabContent() {
              this.tabContentBuilder(item)
            }
            .backgroundColor($r('sys.color.background_primary'))
          }, (item: number, index: number) => `${item}_${index}`)
        }
        .barPosition(BarPosition.Start)
        .vertical(true)
        .barMode(BarMode.Scrollable)
        .barWidth(SizeToken.SIZE_NUM_0)
        .animationDuration(CommonConstants.DURATION_0)
        .scrollable(false)
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .onChange((index) => {
          this.selectedIndex = index;
          this.currentIndex = index;
        })
        .onAnimationStart((index: number, targetIndex: number) => {
          if (index === targetIndex) {
            return;
          }
          this.selectedIndex = targetIndex;
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .hideTitleBar(true)
  }

  /**
   * Handles back navigation with full-screen state management.
   *
   * - Exits full-screen mode if currently active
   * - Pops current `NavDestination` from navigation stack
   */
  private handleBackNavigation = (): void => {
    this.navPathStack.pop();
  };
}