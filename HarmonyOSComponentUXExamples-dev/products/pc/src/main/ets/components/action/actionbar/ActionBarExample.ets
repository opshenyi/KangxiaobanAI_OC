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
import { HdsNavDestination } from '@kit.UIDesignKit';
import {
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';

@Builder
export function ActionBarExampleBuilder() {
  ActionBarExample()
}

@ComponentV2
struct ActionBarExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  @Builder
  ListItemBuilder(val: ResourceStr, routerName: string) {
    Row() {
      Text(val)
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_48)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
    .onClick(() => {
      this.navPathStack.pushPath({ name: routerName });
    })
  }

  build() {
    HdsNavDestination() {
      Column() {
        GroupHeader($r('app.string.basic_style_label'), PaddingToken.PADDING_12VP)
        this.ListItemBuilder($r('app.string.vertical_layout_label'), 'VerticalActionBar')
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.action_bar_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}