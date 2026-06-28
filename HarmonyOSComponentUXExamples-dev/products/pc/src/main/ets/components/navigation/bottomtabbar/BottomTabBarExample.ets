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

const BOTTOM_TAB_BAR_DATA_PC: ComponentGroup[] = [
  {
    id: 'group_different_tab_style',
    title: $r('app.string.subtitle_tab_style_label'),
    items: [
      { id: 'default_tab_style', name: $r('app.string.default_tab_style_label'), url: 'DefaultStyleTabBar' },
    ]
  }
];

@Builder
export function BottomTabBarExampleBuilder() {
  BottomTabBarExample()
}

@ComponentV2
struct BottomTabBarExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  build() {
    HdsNavDestination() {
      List() {
        Repeat(BOTTOM_TAB_BAR_DATA_PC)
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
                        SymbolGlyph($r('sys.symbol.chevron_right'))
                          .fontSize($r('sys.float.Title_M'))
                          .fontColor([$r('sys.color.icon_fourth')])
                      }
                      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
                      .justifyContent(FlexAlign.End)
                    }
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                    .width(SizeToken.SIZE_PERCENT_100)
                    .height(SizeToken.SIZE_NUM_56)
                    .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
                    .backgroundColor($r('sys.color.comp_background_list_card'))
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
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clipContent(ContentClipMode.SAFE_AREA)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.bottom_tab_bar_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}