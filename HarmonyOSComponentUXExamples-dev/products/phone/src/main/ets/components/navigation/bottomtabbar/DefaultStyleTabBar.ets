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
import { DividerMode, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { BreakpointModel, CommonConstants, PaddingToken, SizeToken, WindowUtil } from 'componentuxexamplesbase';

@Builder
export function DefaultStyleTabBarBuilder() {
  DefaultStyleTabBar();
}

@ComponentV2
struct DefaultStyleTabBar {
  // selectedIndex controls the text color switching inside the custom TabBar
  @Local selectedIndex: number = 1;
  // currentIndex controls which tab page is displayed in the TabContent
  @Local currentIndex: number = 1;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private controller: HdsTabsController = new HdsTabsController();
  private winUtil: WindowUtil = WindowUtil.getInstance();
  private isLayoutFullScreen: boolean = false;

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case WidthBreakpoint.WIDTH_XS:
      case WidthBreakpoint.WIDTH_SM:
      case WidthBreakpoint.WIDTH_MD:
        if (this.isLayoutFullScreen) {
          this.isLayoutFullScreen = false;
          this.winUtil.setFullScreen(false);
        }
        break;
      case WidthBreakpoint.WIDTH_LG:
      case WidthBreakpoint.WIDTH_XL:
        if (!this.isLayoutFullScreen) {
          this.isLayoutFullScreen = true;
          this.winUtil.setFullScreen(true);
        }
        break;
      default:
        this.isLayoutFullScreen = false;
        this.winUtil.setFullScreen(false);
        break;
    }
  }

  aboutToAppear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    if (this.breakpointModel.isLargeOrExtraLargeScreen() && !this.isLayoutFullScreen) {
      this.isLayoutFullScreen = true;
      this.winUtil.setFullScreen(true);
    }
  }

  aboutToDisappear(): void {
    this.isLayoutFullScreen = false;
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  tabBuilder(index: number) {
    Column() {
      SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor(this.selectedIndex === index ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_tertiary')])

      Text(`Tab${index + 1}`)
        .fontColor(this.selectedIndex === index ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Caption_M'))
        .fontWeight(FontWeight.Medium)
        .lineHeight(SizeToken.SIZE_NUM_14)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  @Builder
  tabContentBuilder(index: number) {
    Column() {
      this.customTitleBar();
      Row() {
        Text(`Tab${index + 1}`)
          .fontColor($r('sys.color.font_emphasize'))
          .fontSize($r('sys.float.Title_M'))
          .fontWeight(FontWeight.Regular)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.background_primary'))
  }

  @Builder
  customTitleBar() {
    if (this.breakpointModel.isLargeOrExtraLargeScreen()) {
      Row() {
        this.customNavDestinationTitleV2();
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
      .alignItems(VerticalAlign.Top)
    }
  }

  @Builder
  customNavDestinationTitleV2() {
    Row() {
      Stack() {
        Circle({ width: SizeToken.SIZE_NUM_40, height: SizeToken.SIZE_NUM_40 })
          .fill($r('app.color.back_button_color'))

        Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
          .height(SizeToken.SIZE_NUM_24)
          .width(SizeToken.SIZE_NUM_24)
          .fillColor($r('sys.color.font_primary'))
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .onClick(this.handleBackNavigation)

      this.customNavDestinationTitle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .margin({ top: SizeToken.SIZE_NUM_36 })
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text($r('app.string.bottom_tab_bar_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.default_tab_style_label'))
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: PaddingToken.PADDING_8VP })
  }

  build() {
    NavDestination() {
      HdsTabs({ controller: this.controller, index: this.currentIndex }) {
        TabContent() {
          this.tabContentBuilder(0);
        }
        .tabBar(this.tabBuilder(0))

        TabContent() {
          this.tabContentBuilder(1);
        }
        .tabBar(this.tabBuilder(1))

        TabContent() {
          this.tabContentBuilder(2);
        }
        .tabBar(this.tabBuilder(2))

        TabContent() {
          this.tabContentBuilder(3);
        }
        .tabBar(this.tabBuilder(3))
      }
      .barPosition(!this.breakpointModel.isLargeOrExtraLargeScreen() ? BarPosition.End : BarPosition.Start)
      .vertical(!this.breakpointModel.isLargeOrExtraLargeScreen() ? false : true)
      .barMode(BarMode.Fixed)
      .scrollable(!this.breakpointModel.isLargeOrExtraLargeScreen() ? true : false)
      .animationDuration(!this.breakpointModel.isLargeOrExtraLargeScreen() ? CommonConstants.DURATION_300 :
        CommonConstants.DURATION_0)
      .divider({ mode: DividerMode.NONE })
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
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
    .hideTitleBar(!this.breakpointModel.isLargeOrExtraLargeScreen() ? false : true)
    .title(this.customNavDestinationTitle(), {
      backgroundColor: $r('sys.color.background_primary'),
      paddingStart: this.breakpointModel.getValue({
        sm: LengthMetrics.vp(PaddingToken.PADDING_16VP),
        md: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        lg: LengthMetrics.vp(PaddingToken.PADDING_32VP)
      }),
      paddingEnd: this.breakpointModel.getValue({
        sm: LengthMetrics.vp(PaddingToken.PADDING_16VP),
        md: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        lg: LengthMetrics.vp(PaddingToken.PADDING_32VP)
      })
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .onBackPressed(() => {
      this.handleBackNavigation();
      return true;
    })
  }

  /**
   * Handles back navigation with full-screen state management.
   *
   * - Exits full-screen mode if currently active
   * - Pops current `NavDestination` from navigation stack
   */
  private handleBackNavigation = (): void => {
    if (this.isLayoutFullScreen) {
      this.isLayoutFullScreen = false;
      this.winUtil.setFullScreen(false);
    }
    this.navPathStack.pop();
  };
}