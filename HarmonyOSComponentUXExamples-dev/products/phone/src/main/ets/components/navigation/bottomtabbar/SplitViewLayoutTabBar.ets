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
import { SegmentButtonV2Items, SymbolGlyphModifier, TabSegmentButtonV2 } from '@kit.ArkUI';
import { DividerMode, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import {
  BreakpointModel,
  CommonConstants,
  CommonUtils,
  PaddingToken,
  SizeToken,
  SpaceToken,
  WindowUtil
} from 'componentuxexamplesbase';

/**
 * Represents a single entry in the call history or recent calls list.
 */
interface CallRecords {
  /**
   * The primary identifier for the call log, such as a masked phone number or a contact name.
   */
  title: ResourceStr;

  /**
   * Secondary information providing more context about the caller.
   */
  subTitle: ResourceStr;

  /**
   * The timestamp or relative time indicating when the call took place.
   */
  callTime: ResourceStr;
}

/**
 * Mock data source containing a list of recent call records.
 * Typically used for populating and testing the call history UI.
 */
const CALL_RECORDS_DATA: CallRecords[] = [
  {
    title: '159****2838',
    subTitle: $r('app.string.wuhan_label'),
    callTime: $r('app.string.a_moment_ago_label')
  },
  {
    title: '急救中心',
    subTitle: '120',
    callTime: $r('app.string.one_minute_ago_label')
  },
  {
    title: '火警',
    subTitle: '119',
    callTime: $r('app.string.two_minute_ago_label')
  }
];

@Builder
export function SplitViewLayoutTabBarBuilder() {
  SplitViewLayoutTabBar()
}

@ComponentV2
struct SplitViewLayoutTabBar {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local normalSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.phone_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.phone_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_2_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_2_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local textItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.all_phone_label') },
    { text: $r('app.string.missed_phone_label') }
  ]);
  // index of the selected segment
  @Local textSelectedIndex: number = 0;
  // navigation bar height
  @Local navigationBarHeight: Length | undefined = undefined;
  // status bar height
  @Local statusBarHeight: Length | undefined = undefined;
  private controller: HdsTabsController = new HdsTabsController();
  private winUtil: WindowUtil = WindowUtil.getInstance();
  private secondNavPathStack: NavPathStack = new NavPathStack();
  // the main window layout or the child window layout is immersive or not
  private isLayoutFullScreen: boolean = false;

  @Computed
  get horizontalPadding(): number {
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }) as number;
  }

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case WidthBreakpoint.WIDTH_XS:
      case WidthBreakpoint.WIDTH_SM:
        if (this.secondNavPathStack.size() > 0) {
          this.secondNavPathStack.pop(false);
        }
        break;
      case WidthBreakpoint.WIDTH_MD:
      case WidthBreakpoint.WIDTH_LG:
      case WidthBreakpoint.WIDTH_XL:
        if (this.secondNavPathStack.size() === 0) {
          this.secondNavPathStack.pushPath({ name: CommonConstants.PHONE_DIALER_PAGE_NAME }, false);
        }
        break;
      default:
        break;
    }
  }

  aboutToAppear(): void {
    if (!this.breakpointModel.isSmallScreen()) {
      this.secondNavPathStack.pushPath({ name: CommonConstants.PHONE_DIALER_PAGE_NAME }, false);
    }
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    if (!this.isLayoutFullScreen) {
      this.isLayoutFullScreen = true;
      this.winUtil.setFullScreen(true);
    }
    if (this.isLayoutFullScreen) {
      this.statusBarHeight = this.breakpointModel.windowInfo.statusBarHeight + 'px';
      this.navigationBarHeight = this.breakpointModel.windowInfo.navAvoidAreaHeight + 'px';
    }
  }

  aboutToDisappear(): void {
    if (this.isLayoutFullScreen) {
      this.winUtil.setFullScreen(false);
    }
    this.isLayoutFullScreen = false;
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  listBuilder() {
    List() {
      Repeat(CALL_RECORDS_DATA)
        .each((itemWrap) => {
          ListItem() {
            Row() {
              Column() {
                Row({ space: SpaceToken.SPACE_8 }) {
                  Column() {
                    SymbolGlyph($r('sys.symbol.phone_arrow_up_right_fill'))
                      .fontSize($r('sys.float.Subtitle_L'))
                      .fontColor([$r('sys.color.font_tertiary')])
                  }
                  .justifyContent(FlexAlign.Start)
                  .height(SizeToken.SIZE_PERCENT_100)
                  .padding({ top: PaddingToken.PADDING_16VP })

                  Column() {
                    Text(itemWrap.item.title)
                      .fontSize($r('sys.float.Subtitle_L'))
                      .fontColor($r('sys.color.font_primary'))
                      .fontWeight(FontWeight.Regular)

                    Text(itemWrap.item.subTitle)
                      .fontSize($r('sys.float.Body_M'))
                      .fontColor($r('sys.color.font_secondary'))
                      .fontWeight(FontWeight.Regular)
                  }
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Start)
                }
              }

              Row({ space: SpaceToken.SPACE_4 }) {
                Text(itemWrap.item.callTime)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor($r('sys.color.font_secondary'))
                  .fontWeight(FontWeight.Regular)

                SymbolGlyph($r('sys.symbol.info_circle'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Center)
            }
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_NUM_64)
          }
          .padding({
            left: this.breakpointModel.getValue(
              {
                sm: PaddingToken.PADDING_16VP,
                md: PaddingToken.PADDING_16VP,
                lg: PaddingToken.PADDING_24VP
              }),
            right: this.breakpointModel.getValue(
              {
                sm: PaddingToken.PADDING_16VP,
                md: PaddingToken.PADDING_16VP,
                lg: PaddingToken.PADDING_24VP
              })
          })
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor($r('app.color.list_item_pressed_color'))
            }
          })
        })
        .key((item) => JSON.stringify(item))
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height('calc(100% - 40vp - 56vp - 81vp - 16vp)')
    .scrollBar(BarState.Off)
    .margin({ top: PaddingToken.PADDING_16VP })
    .divider({
      strokeWidth: $r('sys.float.border_small'),
      color: $r('sys.color.comp_divider'),
      startMargin: this.breakpointModel.getValue(
        {
          sm: PaddingToken.PADDING_42VP,
          md: PaddingToken.PADDING_42VP,
          lg: PaddingToken.PADDING_50VP
        }),
      endMargin: this.horizontalPadding
    })
  }

  @Builder
  customNavDestinationTitle() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
          .height(SizeToken.SIZE_NUM_24)
          .width(SizeToken.SIZE_NUM_24)
          .fillColor($r('sys.color.font_primary'))
      }
      .width(SizeToken.SIZE_NUM_40)
      .height(SizeToken.SIZE_NUM_40)
      .backgroundColor($r('app.color.back_button_color'))
      .onClick(this.handleBackNavigation)

      Row() {
        Column() {
          Text($r('app.string.bottom_tab_bar_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Bold)

          Text($r('app.string.split_view_sync_nav_label'))
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_M'))
            .maxLines(CommonConstants.INTEGER_1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontWeight(FontWeight.Regular)
        }
        .height(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          SymbolGlyph($r('sys.symbol.dot_grid_2x2'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_primary')])
        }
        .width(SizeToken.SIZE_NUM_40)
        .height(SizeToken.SIZE_NUM_40)
        .backgroundColor($r('app.color.back_button_color'))
        .onClick(() => {
          CommonUtils.showToast('Dot button tapped.')
        })
      }
      .margin({ left: PaddingToken.PADDING_8VP })
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .padding({
      left: this.horizontalPadding,
      right: this.horizontalPadding
    })
  }

  @Builder
  tabContentBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.customNavDestinationTitle();

        Row() {
          Text($r('app.string.phone_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Bold)
        }
        .height(SizeToken.SIZE_NUM_81)
        .width(SizeToken.SIZE_PERCENT_100)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .padding({
          left: this.horizontalPadding,
          right: this.horizontalPadding
        })

        Row() {
          TabSegmentButtonV2({
            items: this.textItems,
            selectedIndex: this.textSelectedIndex!!
          })
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({
          left: this.horizontalPadding,
          right: this.horizontalPadding
        })

        if (this.textSelectedIndex === 0) {
          this.listBuilder()
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({ top: this.statusBarHeight })

      if (this.breakpointModel.isSmallScreen()) {
        this.dialButtonBuilder()
      }
    }
  }

  @Builder
  tabContentBuilderV2() {
    Column() {
      this.customNavDestinationTitle();
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({ top: this.statusBarHeight })
  }

  /**
   * Constructs the bottom green dial button
   */
  @Builder
  dialButtonBuilder() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      SymbolGlyph($r('sys.symbol.dial'))
        .fontSize(SizeToken.SIZE_NUM_34)
        .fontColor([$r('sys.color.font_on_primary')])
    }
    .width(SizeToken.SIZE_NUM_58)
    .height(SizeToken.SIZE_NUM_58)
    .backgroundColor($r('sys.color.confirm'))
    .margin({ bottom: PaddingToken.PADDING_26VP })
    .onClick(() => {
      CommonUtils.showToast('Dial button tapped.');
    })
  }

  build() {
    NavDestination() {
      Navigation(this.secondNavPathStack) {
        HdsTabs({ controller: this.controller }) {
          TabContent() {
            this.tabContentBuilder()
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier1,
            selected: this.selectSymbolModifier1
          }, $r('app.string.phone_label')))

          TabContent() {
            this.tabContentBuilderV2();
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier2,
            selected: this.selectSymbolModifier2
          }, $r('app.string.contacts_label')))

          TabContent() {
            this.tabContentBuilderV2();
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier3,
            selected: this.selectSymbolModifier3
          }, $r('app.string.favorites_label')))
        }
        .barPosition(!this.breakpointModel.isLargeOrExtraLargeScreen() ? BarPosition.End : BarPosition.Start)
        .vertical(!this.breakpointModel.isLargeOrExtraLargeScreen() ? false : true)
        .barMode(BarMode.Fixed)
        .divider({
          mode: !this.breakpointModel.isLargeOrExtraLargeScreen() ? DividerMode.NONE : DividerMode.VISIBLE
        })
        .scrollable(false)
        .padding({
          bottom: !this.breakpointModel.isLargeOrExtraLargeScreen() ? this.navigationBarHeight : undefined
        })
        .onChange((index: number) => {
          if (!this.breakpointModel.isSmallScreen()) {
            this.secondNavPathStack.replacePath({
              name: index === 0 ? CommonConstants.PHONE_DIALER_PAGE_NAME : CommonConstants.EMPTY_PAGE_NAME
            },
              false);
          }
        })
      }
      .navBarWidth(this.breakpointModel.getValue({
        sm: SizeToken.SIZE_PERCENT_100,
        md: SizeToken.SIZE_PERCENT_50,
        lg: this.getNavBarWidthRatio()
      }))
      .hideTitleBar(true)
    }
    .hideTitleBar(true)
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

  /**
   * Calculates the navigation bar width as a percentage of the total screen width.
   * The calculation includes both the tab bar width and a portion of the tab content area.
   *
   * @returns {string} The percentage value as a string with '%' suffix (e.g., '45.50%')
   */
  private getNavBarWidthRatio(): string {
    // Width of the tab bar in pixels
    const tabBarWidth: number = 276;
    // Current screen width in pixels
    const screenWidth: number = this.breakpointModel.windowInfo.windowSize.width;
    // Width of the tab content area in pixels (40% of remaining space after tab bar)
    const tabContentWidth: number = (screenWidth - tabBarWidth) * 0.4;
    return `${(tabBarWidth + tabContentWidth) / screenWidth * 100}%`;
  }
}