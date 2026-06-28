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
import { LengthMetrics, SymbolGlyphModifier, window } from '@kit.ArkUI';
import { DividerMode, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import {
  BreakpointModel,
  CommonConstants,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  WindowUtil
} from 'componentuxexamplesbase';

@Builder
export function BackdropBlurStyleTabBarBuilder() {
  BackdropBlurStyleTabBar();
}

@ComponentV2
struct BackdropBlurStyleTabBar {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local currentGridColumn: string = BreakpointModel.getInstance().currentGridColumn;
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
    new SymbolGlyphModifier($r('sys.symbol.heart_square_stack_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.heart_square_stack_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  private controller: HdsTabsController | undefined = undefined;
  private winUtil: WindowUtil = WindowUtil.getInstance();

  aboutToAppear(): void {
    this.controller = new HdsTabsController();
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    if (this.breakpointModel.isSmallScreen()) {
      this.currentGridColumn = '1fr';
    }
    this.winUtil.setMainWindowOrientation(window.Orientation.PORTRAIT);
  }

  aboutToDisappear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
    this.winUtil.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
  }

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case WidthBreakpoint.WIDTH_XS:
      case WidthBreakpoint.WIDTH_SM:
        this.currentGridColumn = '1fr';
        break;
      case WidthBreakpoint.WIDTH_MD:
        this.currentGridColumn = '1fr 1fr 1fr';
        break;
      case WidthBreakpoint.WIDTH_LG:
      case WidthBreakpoint.WIDTH_XL:
        this.currentGridColumn = '1fr 1fr 1fr 1fr';
        break;
      default:
        this.currentGridColumn = '1fr 1fr';
        break;
    }
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text('Bottom Tab Bar')
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.backdrop_blur_label'))
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: PaddingToken.PADDING_8VP })
  }

  @Builder
  tabContentBuilder() {
    Grid() {
      Repeat(CommonConstants.IMAGE_ARRAY)
        .each((itemWrap) => {
          GridItem() {
            Image(itemWrap.item)
              .objectFit(ImageFit.Contain)
              .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
              .clip(true)
          }
        })
        .key((item: Resource, index: number) => `${index}_${JSON.stringify(item)}`)
    }
    .editMode(false)
    .columnsTemplate(this.currentGridColumn)
    .width(SizeToken.SIZE_PERCENT_100)
    .rowsGap(SpaceToken.SPACE_12)
    .columnsGap(SpaceToken.SPACE_12)
    .scrollBar(BarState.Off)
    .padding({
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_48VP
    })
    .padding({ bottom: PaddingToken.PADDING_48VP })
    .gesture(PinchGesture({ fingers: 2 }).onActionUpdate((event: GestureEvent) => {
      if (event.scale > 1 && !this.breakpointModel.isSmallScreen()) {
        if (this.breakpointModel.isMiddleScreen()) {
          this.getUIContext().animateTo({
            duration: CommonConstants.DURATION_500
          }, () => {
            this.currentGridColumn = '1fr 1fr 1fr';
          })
        } else {
          this.getUIContext().animateTo({
            duration: CommonConstants.DURATION_500
          }, () => {
            this.currentGridColumn = '1fr 1fr 1fr 1fr';
          })
        }
      } else if (event.scale < 1 && !this.breakpointModel.isSmallScreen()) {
        if (this.breakpointModel.isMiddleScreen()) {
          this.getUIContext().animateTo({
            duration: CommonConstants.DURATION_500
          }, () => {
            this.currentGridColumn = '1fr 1fr 1fr 1fr';
          })
        } else {
          this.getUIContext().animateTo({
            duration: CommonConstants.DURATION_500
          }, () => {
            this.currentGridColumn = '1fr 1fr 1fr 1fr 1fr';
          })
        }
      } else {
        CommonUtils.showToast(`Two-finger operation is not supported`);
      }
    }))
  }

  build() {
    NavDestination() {
      HdsTabs({ controller: this.controller, index: CommonConstants.DEFAULT_SELECTED_TAB_INDEX_2 }) {
        TabContent() {
        }.tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier1,
          selected: this.selectSymbolModifier1
        }, $r('app.string.photo_label')))


        TabContent() {
        }.tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier2,
          selected: this.selectSymbolModifier2
        }, $r('app.string.photo_album_label')))

        TabContent() {
          Column() {
            this.tabContentBuilder();
          }
          .padding({
            left: this.breakpointModel.getValue({
              sm: PaddingToken.PADDING_16VP,
              md: PaddingToken.PADDING_24VP,
              lg: PaddingToken.PADDING_32VP
            }),
            right: this.breakpointModel.getValue({
              sm: PaddingToken.PADDING_16VP,
              md: PaddingToken.PADDING_24VP,
              lg: PaddingToken.PADDING_32VP
            })
          })
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
        }.tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier3,
          selected: this.selectSymbolModifier3
        }, $r('app.string.moment_label')))
      }
      .barPosition(BarPosition.End)
      .vertical(false)
      .barOverlap(true)
      .divider({ mode: DividerMode.FOLLOW_SCROLL })
      .barBackgroundColor(Color.Transparent)
      .barBackgroundBlurStyle(BlurStyle.BACKGROUND_THICK,
        { colorMode: ThemeColorMode.LIGHT, adaptiveColor: AdaptiveColor.DEFAULT, scale: CommonConstants.FLOAT_1 })
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
    }
    .title(this.customNavDestinationTitle(), {
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
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}