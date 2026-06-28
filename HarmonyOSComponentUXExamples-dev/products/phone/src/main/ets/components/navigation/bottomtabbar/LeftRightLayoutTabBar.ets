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

import { HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { display, LengthMetrics, SymbolGlyphModifier, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import {
  BreakpointModel,
  CommonConstants,
  CornerRadiusToken,
  Logger,
  PaddingToken,
  SizeToken,
  SpaceToken,
  WindowUtil
} from 'componentuxexamplesbase';

const TAG = 'LeftRightLayoutTabBar';

@Builder
export function LeftRightLayoutTabBarBuilder() {
  LeftRightLayoutTabBar()
}

@ComponentV2
struct LeftRightLayoutTabBar {
  @Local boundingRect: display.Rect[] = []; // Unavailable area data
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local normalSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.picture_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.picture_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.rectangle_on_rectangle_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.rectangle_on_rectangle_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local menuItems: NavigationMenuItem[] = [
    {
      value: 'menuItem',
      symbolIcon: new SymbolGlyphModifier($r('sys.symbol.share')),
      action: () => {
        Logger.info(TAG, 'The share button has been clicked.');
      }
    }
  ];
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private controller: HdsTabsController | undefined;
  private winUtil: WindowUtil = WindowUtil.getInstance();

  @Computed
  get boundingRectLeft() {
    const rect = this.boundingRect[0];
    return this.getUIContext().px2vp((rect?.height ?? 0) + (rect?.top ?? 0));
  }

  aboutToAppear(): void {
    this.controller = new HdsTabsController();
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    if (this.breakpointModel.isSmallScreen()) {
      this.winUtil.setMainWindowOrientation(window.Orientation.LANDSCAPE, () => {
        this.avoidDisplayCutout();
      });
    }
    try {
      display.on('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      Logger.error(TAG,
        `Failed to register the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
  }

  aboutToDisappear(): void {
    this.winUtil.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
    try {
      display.off('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      Logger.error(TAG,
        `Failed to unregister the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
  }

  avoidDisplayCutout() {
    try {
      display.getDefaultDisplaySync().getCutoutInfo().then((data) => {
        this.boundingRect = data.boundingRects;
      }).catch((err: BusinessError) => {
        Logger.error(TAG, 'Failed to obtain all the display objects. Error info:' + JSON.stringify(err));
      });
    } catch (err) {
      Logger.error(TAG, 'Failed to obtain the default display object. Error info:' + JSON.stringify(err))
    }
  }

  @Builder
  TabContentBuilder() {
    Grid() {
      Repeat(CommonConstants.IMAGE_DETAIL_DATA)
        .each((itemWrap) => {
          GridItem() {
            Stack({ alignContent: Alignment.BottomStart }) {
              Image(itemWrap.item.imgSrc)
                .objectFit(ImageFit.Contain)
                .width(SizeToken.SIZE_PERCENT_100)
                .hoverEffect(HoverEffect.Scale)
                .focusable(true)
                .groupDefaultFocus(itemWrap.index === 0 ? true : false)
                .draggable(false)
                .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                .id(JSON.stringify(itemWrap.item))

              this.iconBuilder(itemWrap.item.littleIcon)
            }
          }
        })
    }
    .editMode(false)
    .columnsTemplate(CommonConstants.COLUMNS_TEMPLATE_4)
    .width(SizeToken.SIZE_PERCENT_100)
    .rowsGap(SpaceToken.SPACE_12)
    .columnsGap(SpaceToken.SPACE_12)
    .scrollBar(BarState.Off)
    .padding({
      left: PaddingToken.PADDING_16VP + this.boundingRectLeft,
      right: PaddingToken.PADDING_24VP,
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_6VP
    })
  }

  @Builder
  iconBuilder(icon: Resource | undefined) {
    SymbolGlyph(icon)
      .fontSize($r('sys.float.Title_S'))
      .fontColor([$r('sys.color.icon_on_primary')])
      .margin({
        left: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text($r('app.string.bottom_tab_bar_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.left_right_layout_label'))
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
      HdsTabs({
        barPosition: BarPosition.End,
        controller: this.controller,
        index: CommonConstants.DEFAULT_SELECTED_TAB_INDEX_1
      }) {
        TabContent() {
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier1,
          selected: this.selectSymbolModifier1
        }, $r('app.string.photos_label')).layoutMode(LayoutMode.HORIZONTAL))

        TabContent() {
          this.TabContentBuilder()
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier2,
          selected: this.selectSymbolModifier2
        }, $r('app.string.albums_label')).layoutMode(LayoutMode.HORIZONTAL))

        TabContent() {
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier3,
          selected: this.selectSymbolModifier3
        }, $r('app.string.highlight_label')).layoutMode(LayoutMode.HORIZONTAL))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barHeight(SizeToken.SIZE_NUM_40)
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .barBackgroundColor($r('app.color.default_background_color'))
    }
    .title(this.customNavDestinationTitle(), {
      paddingStart: LengthMetrics.vp(PaddingToken.PADDING_16VP + this.boundingRectLeft),
      paddingEnd: LengthMetrics.vp(PaddingToken.PADDING_24VP)
    })
    .menus(this.menuItems)
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  private foldStatusChangeCallback: Callback<display.FoldStatus> = (status: display.FoldStatus) => {
    switch (status) {
      case display.FoldStatus.FOLD_STATUS_EXPANDED:
      case display.FoldStatus.FOLD_STATUS_EXPANDED_WITH_SECOND_EXPANDED:
      case display.FoldStatus.FOLD_STATUS_FOLDED_WITH_SECOND_EXPANDED:
        this.navPathStack.pop();
        break;
      default:
        break;
    }
  };
}