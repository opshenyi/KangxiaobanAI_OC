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

import { SpaceToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../common/CommonItem';
import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { ActionBarParam } from './model/ActionBarParam';

@Builder
export function ActionBarExampleBuilder() {
  ActionBarExample()
}

@ComponentV2
export struct ActionBarExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Consumer('isSplit') isSplit: boolean = false;

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.horizontal_label'))
          CommonItem({ val: $r('app.string.three_icon_label') })
            .margin({ bottom: SpaceToken.SPACE_12 })
            .onClick(() => {
              this.isSplit = false;
              this.navPathStack.pushPath({ name: 'ActionBarFullView', param: new ActionBarParam(true, true) });
            })
          CommonItem({ val: $r('app.string.five_icon_label') })
            .onClick(() => {
              this.isSplit = false;
              this.navPathStack.pushPath({ name: 'ActionBarFullView', param: new ActionBarParam(true, false) });
            })
          ListGroupTitle($r('app.string.vertical_label'))
          CommonItem({ val: $r('app.string.three_icon_label') })
            .margin({ bottom: SpaceToken.SPACE_12 })
            .onClick(() => {
              this.isSplit = false;
              this.navPathStack.pushPath({ name: 'ActionBarFullView', param: new ActionBarParam(false, true) });
            })
          CommonItem({ val: $r('app.string.five_icon_label') })
            .onClick(() => {
              this.isSplit = false;
              this.navPathStack.pushPath({ name: 'ActionBarFullView', param: new ActionBarParam(false, false) });
            })
        }
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clip(false)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.action_bar_label')),
      height: $r('app.float.nav_height')
    })
  }
}