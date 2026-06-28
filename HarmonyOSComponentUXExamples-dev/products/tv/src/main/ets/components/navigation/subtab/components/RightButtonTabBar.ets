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

import { CommonModifier } from '@kit.ArkUI';
import { CommonConstants, CommonUtils, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';

@ComponentV2
export struct RightButtonTabBar {
  @Local currentIndex: number = 0;
  private controller: TabsController = new TabsController();
  private tabsIndexArray: number[] = [];
  private tabBarModifier: CommonModifier = new CommonModifier();

  aboutToAppear(): void {
    // Create an array for ForEach loop to render TabBar
    for (let i = CommonConstants.INTEGER_0; i < CommonConstants.INTEGER_4; i++) {
      this.tabsIndexArray.push(i);
    }
    this.tabBarModifier.padding({ right: PaddingToken.PADDING_64VP })
  }

  @Builder
  tabBuilder(index: number) {
    Row({ space: SpaceToken.SPACE_8 }) {
      SymbolGlyph($r('sys.symbol.star_fill'))
        .fontColor([this.currentIndex === index ? $r('sys.color.font_primary') : $r('sys.color.font_secondary')])
        .fontSize(SizeToken.SIZE_NUM_24)
      Text(this.currentIndex === index ? $r('app.string.tab_bar_label') : $r('app.string.title_label'))
        .fontColor(this.currentIndex === index ? $r('sys.color.font_primary') : $r('sys.color.font_secondary'))
        .fontSize($r('app.float.list_item_text_size'))
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Regular)
    }
    .padding({
      left: PaddingToken.PADDING_22VP,
      right: PaddingToken.PADDING_22VP
    })
    .hoverEffect(HoverEffect.Highlight)
    .height(SizeToken.SIZE_NUM_48)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .margin({
      left: PaddingToken.PADDING_8VP,
      right: PaddingToken.PADDING_8VP
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Tabs({ barPosition: BarPosition.Start, controller: this.controller, barModifier: this.tabBarModifier }) {
        ForEach(this.tabsIndexArray, (item: number) => {
          TabContent() {
          }
          .tabBar(this.tabBuilder(item))
        }, (item: number) => item.toString())
      }
      .barMode(BarMode.Scrollable)
      .barHeight(SizeToken.SIZE_NUM_86)
      .height(SizeToken.SIZE_NUM_86)
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      Column() {
        Button({ type: ButtonType.Circle, buttonStyle: ButtonStyleMode.NORMAL }) {
          SymbolGlyph($r('sys.symbol.dot_grid_2x2'))
            .fontColor([$r('sys.color.font_on_primary')])
            .fontSize($r('app.float.symbol_size_large'))
        }
        .height($r('app.float.backward_icon_size'))
        .width($r('app.float.backward_icon_size'))
        .onClick(() => {
          CommonUtils.showToast('The dot button has been clicked currently.');
        })
      }
      .height(SizeToken.SIZE_NUM_86)
      .padding({ right: SizeToken.SIZE_NUM_56 })
      .justifyContent(FlexAlign.Center)
    }
    .backgroundColor($r('app.color.title_background_color'))
  }
}