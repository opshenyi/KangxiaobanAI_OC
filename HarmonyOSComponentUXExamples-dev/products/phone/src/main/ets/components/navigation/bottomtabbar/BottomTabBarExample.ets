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
import { HdsNavDestination } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import {
  BreakpointModel,
  CommonConstants,
  ComponentGroup,
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';

/**
 * Master data source for bottom tab bar view component list
 */
const BOTTOM_TAB_BAR_DATA: ComponentGroup[] = [
  {
    id: 'group_different_tab_style',
    title: $r('app.string.subtitle_tab_style_label'),
    items: [
      { id: 'default_tab_style', name: $r('app.string.default_tab_style_label'), url: 'DefaultStyleTabBar' },
      { id: 'custom_tab_style', name: $r('app.string.custom_tab_style_label'), url: 'RudderStyleTabBar' }
    ]
  },
  {
    id: 'group_blur_style',
    title: $r('app.string.subtitle_blur_style_label'),
    items: [
      { id: 'backdrop_blur', name: $r('app.string.backdrop_blur_label'), url: 'BackdropBlurStyleTabBar' },
      { id: 'gradient_blur', name: $r('app.string.gradient_blur_label'), url: 'GradientBlurTabBar' }
    ]
  },
  {
    id: 'group_layout_principles',
    title: $r('app.string.subtitle_layout_principles_label'),
    items: [
      { id: 'left_right_layout', name: $r('app.string.left_right_layout_label'), url: 'LeftRightLayoutTabBar' },
      { id: 'split_view_sync_nav', name: $r('app.string.split_view_sync_nav_label'), url: 'SplitViewLayoutTabBar' }
    ]
  }
];

@Builder
export function BottomTabBarExampleBuilder() {
  BottomTabBarExample()
}

@ComponentV2
struct BottomTabBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  // Extract common horizontal margin logic via `@Computed`
  @Computed
  get horizontalPadding(): number {
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }) as number;
  }

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.horizontalPadding);
  }

  build() {
    HdsNavDestination() {
      List() {
        Repeat(BOTTOM_TAB_BAR_DATA)
          .each((groupWrap) => {
            ListItemGroup({
              header: GroupHeader(groupWrap.item.title, undefined, $r('app.color.default_background_color'))
            }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Row({ space: SpaceToken.SPACE_12 }) {
                      Text(itemWrap.item.name)
                        .fontColor($r('sys.color.font_primary'))
                        .fontSize($r('sys.float.Subtitle_M'))
                        .fontWeight(FontWeight.Medium)

                      Row() {
                        if (!this.enableLeftRightLayout(itemWrap)) {
                          Text($r('app.string.left_right_bottom_tab_layout_description_label'))
                            .fontColor($r('sys.color.font_secondary'))
                            .fontSize($r('sys.float.Body_M'))
                            .fontWeight(FontWeight.Regular)
                            .wordBreak(WordBreak.HYPHENATION)
                            .margin({ right: PaddingToken.PADDING_4VP })
                        }

                        SymbolGlyph($r('sys.symbol.chevron_right'))
                          .fontSize($r('sys.float.Title_M'))
                          .fontColor([$r('sys.color.icon_fourth')])
                      }
                      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
                      .justifyContent(FlexAlign.End)
                    }
                    .enabled(this.enableLeftRightLayout(itemWrap))
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                    .width(SizeToken.SIZE_PERCENT_100)
                    .height(SizeToken.SIZE_NUM_56)
                    .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
                    .backgroundColor(this.enableLeftRightLayout(itemWrap) ? $r('sys.color.comp_background_list_card') :
                      $r('sys.color.background_tertiary'))
                    .stateStyles({
                      pressed: {
                        .backgroundColor($r('app.color.list_item_pressed_color'))
                      }
                    })
                    .justifyContent(FlexAlign.SpaceBetween)
                    .onClick(() => {
                      this.navPathStack.pushPath({ name: itemWrap.item.url.toString() });
                    })
                  }
                })
                .key((item) => item.id)
            }
            .divider({
              strokeWidth: SizeToken.SIZE_NUM_12,
              color: $r('sys.color.background_secondary'),
            })
          })
          .key((group) => group.id)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: this.horizontalPadding,
        right: this.horizontalPadding
      })
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clipContent(ContentClipMode.SAFE_AREA)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .hideBackButton(this.breakpointModel.shouldHideBackButton())
    .titleBar({
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.bottom_tab_bar_label'), this.pageParam)
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }

  private enableLeftRightLayout(itemWrap: RepeatItem<ComponentItem>): boolean {
    if (!this.breakpointModel.isSmallScreen() && itemWrap.item.id === 'left_right_layout') {
      return false;
    }
    return true;
  }
}