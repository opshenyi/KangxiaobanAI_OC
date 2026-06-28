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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct TextTabBar {
  @Local currentIndex: number = 0;
  // Used to set the number of TabBars in Tabs
  @Param tabsNum: number = CommonConstants.INTEGER_5;
  // Is the TabBar arranged in a horizontally centered manner
  @Param isTabBarCenter: boolean = false;
  private tabBarModifier: CommonModifier = new CommonModifier();
  private controller: TabsController = new TabsController();
  private tabsIndexArray: number[] = [];

  aboutToAppear(): void {
    // Create an array for ForEach loop to render TabBar
    for (let i = CommonConstants.INTEGER_0; i < this.tabsNum; i++) {
      this.tabsIndexArray.push(i);
    }
    if (this.isTabBarCenter) {
      // Set TabBar to display centered horizontally
      this.tabBarModifier.align(Alignment.Center);
    } else {
      // Set TabBar to display on the left
      this.tabBarModifier.align(Alignment.Start);
    }
  }

  @Builder
  tabBuilder(index: number) {
    Column() {
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
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .margin({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.Start, controller: this.controller, barModifier: this.tabBarModifier }) {
      ForEach(this.tabsIndexArray, (item: number) => {
        TabContent() {
        }
        .tabBar(this.tabBuilder(item))
      }, (item: number) => item.toString())
    }
    .barMode(BarMode.Scrollable, { margin: PaddingToken.PADDING_18VP })
    .backgroundColor($r('app.color.title_background_color'))
    .barHeight(SizeToken.SIZE_NUM_86)
    .height(SizeToken.SIZE_NUM_86)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}