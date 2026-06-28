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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct LoadingStyleProgress {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local subTitleName: ResourceStr = $r('app.string.no_clear_progress_bar_label');

  build() {
    Column() {
      SubTitleView(this.subTitleName)

      Column() {
        Row() {
          Text($r('app.string.for_component_combination_scenarios_label'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          LoadingProgress()
            .width(SizeToken.SIZE_NUM_24)
            .height(SizeToken.SIZE_NUM_24)
            .color($r('sys.color.icon_tertiary'))
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Divider()

        Row() {
          Text($r('app.string.for_full_page_loading_scenarios_label'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_fourth')])
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.navPathStack.pushPath({ name: CommonConstants.LOADING_PROGRESS_EXAMPLE_NAME });
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding({
        left: PaddingToken.PADDING_12VP,
        right: PaddingToken.PADDING_12VP,
        top: PaddingToken.PADDING_4VP,
        bottom: PaddingToken.PADDING_4VP
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}