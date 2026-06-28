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

import { LengthMetrics } from '@kit.ArkUI';
import { DividerMode, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { BreakpointModel, CommonConstants, PaddingToken, SizeToken, WindowUtil } from 'componentuxexamplesbase';
import { BottomTabModel } from './model/BottomTabModel';

@Builder
export function RudderStyleTabBarBuilder() {
  RudderStyleTabBar();
}

@ComponentV2
struct RudderStyleTabBar {
  @Local tabArray: BottomTabModel[] = [];
  @Local currentIndex: number = 0;
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
    this.tabArray = [
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab1'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab2'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), '', true),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab3'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab4')
    ];
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
  tabContentBuilder(name: ResourceStr) {
    Column() {
      this.customTitleBar();
      Row() {
        Text(name)
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
  tabBarBuilder(imgSrc: Resource, title: ResourceStr, middleMode: boolean, index: number) {
    Column() {
      if (index === CommonConstants.TAB_INDEX_TWO) {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          SymbolGlyph($r('sys.symbol.plus'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.background_primary')])
        }
        .width(SizeToken.SIZE_NUM_40)
        .height(SizeToken.SIZE_NUM_40)
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
      } else {
        SymbolGlyph(imgSrc)
          .fontSize($r('sys.float.Title_M'))
          .fontColor(this.currentIndex === index ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_tertiary')])
      }

      if (!middleMode) {
        Text(title)
          .fontSize($r('sys.float.Caption_M'))
          .margin({ top: PaddingToken.PADDING_6VP })
          .fontColor(this.currentIndex === index ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
      }
    }
    .width(!this.breakpointModel.isLargeOrExtraLargeScreen() ? SizeToken.SIZE_PERCENT_100 :
      SizeToken.SIZE_NUM_96)
    .height(!this.breakpointModel.isLargeOrExtraLargeScreen() ? SizeToken.SIZE_NUM_76 :
      SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('app.color.gray_08'))
    .justifyContent(!this.breakpointModel.isLargeOrExtraLargeScreen() ? FlexAlign.Start : FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(!this.breakpointModel.isLargeOrExtraLargeScreen() ? { top: PaddingToken.PADDING_4VP } : undefined)
    .onClick(() => {
      if (index !== CommonConstants.TAB_INDEX_TWO) {
        this.currentIndex = index;
        this.controller?.changeIndex(index);
      }
    })
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

      Text($r('app.string.custom_tab_style_label'))
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
      Column() {
        Stack({
          alignContent: !this.breakpointModel.isLargeOrExtraLargeScreen() ? Alignment.BottomStart :
            Alignment.Start
        }) {
          HdsTabs({ controller: this.controller }) {
            ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
              if (index === CommonConstants.TAB_INDEX_TWO) {
                TabContent()
                  .backgroundColor($r('sys.color.background_primary'))
              } else {
                TabContent() {
                  this.tabContentBuilder(item.title)
                }
                .backgroundColor($r('sys.color.background_primary'))
              }
            }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
          }
          .barPosition(!this.breakpointModel.isLargeOrExtraLargeScreen() ? BarPosition.End : BarPosition.Start)
          .vertical(!this.breakpointModel.isLargeOrExtraLargeScreen() ? false : true)
          .scrollable(false)
          .animationDuration(!this.breakpointModel.isLargeOrExtraLargeScreen() ? CommonConstants.DURATION_300 :
            CommonConstants.DURATION_0)
          .divider({ mode: DividerMode.NONE })

          Flex({
            direction: !this.breakpointModel.isLargeOrExtraLargeScreen() ? FlexDirection.Row :
              FlexDirection.Column
          }) {
            ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
              this.tabBarBuilder(item.imgSrc, item.title, item.middleMode, index)
            }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
          }
          .offset(!this.breakpointModel.isLargeOrExtraLargeScreen() ? { y: SizeToken.SIZE_NUM_28 } : undefined)
        }
      }
      .height(SizeToken.SIZE_PERCENT_100)
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