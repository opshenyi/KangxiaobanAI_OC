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
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';

@Builder
export function AlphabetIndexerExampleBuilder() {
  AlphabetIndexerExample()
}

@ComponentV2
struct AlphabetIndexerExample {
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

  @Builder
  LayoutStyleAlphabetIndexer() {
    Column() {
      SubTitleView($r('app.string.layout_label'))

      Row() {
        Text($r('app.string.portrait_and_landscape_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_56)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: PaddingToken.PADDING_12VP,
        right: PaddingToken.PADDING_12VP
      })
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })
      .onClick(() => {
        this.navPathStack.pushPath({ name: 'BasicStyleAlphabetIndexer' });
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          this.LayoutStyleAlphabetIndexer()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({
          left: this.horizontalPadding,
          right: this.horizontalPadding,
          bottom: PaddingToken.PADDING_16VP
        })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
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
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.alphabet_indexer_en_label'), this.pageParam)
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}