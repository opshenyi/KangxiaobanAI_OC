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
  ComponentGroup,
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';

/**
 * Master data source for toast view component list
 */
const TOAST_DATA: ComponentGroup[] = [
  {
    id: 'group_different_position_toast',
    title: $r('app.string.popup_position_label'),
    items: [
      { id: 'bottom_hint', name: $r('app.string.bottom_hint_label'), url: 'BottomToast' },
      {
        id: 'designated_location_hint',
        name: $r('app.string.designated_location_hint_label'),
        url: 'DesignatedPositionToast'
      }
    ]
  },
  {
    id: 'group_toast_display_in_portrait_mode',
    title: $r('app.string.responsive_design_label'),
    items: [
      {
        id: 'default_width_in_portrait_mode',
        name: $r('app.string.default_width_in_portrait_mode_label'),
        url: 'PortraitDefaultWidthToast'
      },
      {
        id: 'max_width_in_portrait_mode',
        name: $r('app.string.max_width_in_portrait_mode_label'),
        url: 'PortraitMaxWidthToast'
      }
    ]
  },
  {
    id: 'group_toast_display_in_landscape_mode',
    title: $r('app.string.landscape_specifications_label'),
    items: [
      {
        id: 'default_width_in_landscape_mode',
        name: $r('app.string.default_width_in_landscape_mode_label'),
        url: 'LandscapeDefaultWidthToast'
      },
      {
        id: 'max_width_in_landscape_mode',
        name: $r('app.string.max_width_in_landscape_mode_label'),
        url: 'LandscapeMaxWidthToast'
      }
    ]
  }
];

@Builder
export function ToastExampleBuilder() {
  ToastExample()
}

@ComponentV2
struct ToastExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
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
        Repeat(TOAST_DATA)
          .each((groupWrap) => {
            ListItemGroup({
              header: GroupHeader(groupWrap.item.title, undefined, $r('app.color.default_background_color'))
            }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Row() {
                      Text(itemWrap.item.name)
                        .fontColor($r('sys.color.font_primary'))
                        .fontSize($r('sys.float.Subtitle_M'))
                        .fontWeight(FontWeight.Medium)

                      SymbolGlyph($r('sys.symbol.chevron_right'))
                        .fontSize($r('sys.float.Title_M'))
                        .fontColor([$r('sys.color.icon_fourth')])
                    }
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                    .width(SizeToken.SIZE_PERCENT_100)
                    .height(SizeToken.SIZE_NUM_56)
                    .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
                    .justifyContent(FlexAlign.SpaceBetween)
                    .stateStyles({
                      normal: {
                        .backgroundColor($r('sys.color.comp_background_list_card'))
                      },
                      pressed: {
                        .backgroundColor($r('app.color.list_item_pressed_color'))
                      }
                    })
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
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.toast_label'), this.pageParam)
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}