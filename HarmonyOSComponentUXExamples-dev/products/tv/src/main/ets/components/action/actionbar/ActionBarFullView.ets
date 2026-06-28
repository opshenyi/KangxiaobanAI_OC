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

import { SubNavTitleWithBack } from '../../common/SubNavTitleWithBack';
import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { FiveIconBar } from './components/FiveIconBar';
import { ThreeIconBar } from './components/ThreeIconBar';
import { ActionBarParam } from './model/ActionBarParam';

@Builder
export function ActionBarFullViewBuilder() {
  ActionBarFullView()
}

@ComponentV2
export struct ActionBarFullView {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Consumer('isSplit') isSplit: boolean = false;
  @Local pageParam: ActionBarParam = new ActionBarParam(false, false);

  build() {
    NavDestination() {
      Column() {
        if (this.pageParam.isThreeIcon) {
          ThreeIconBar({ isHorizontal: this.pageParam.isHorizontal })
        } else {
          FiveIconBar({ isHorizontal: this.pageParam.isHorizontal })
        }
      }
      .justifyContent(this.pageParam.isHorizontal ? FlexAlign.End : FlexAlign.Center)
      .alignItems(this.pageParam.isHorizontal ? HorizontalAlign.Center : HorizontalAlign.End)
      .height(SizeToken.SIZE_PERCENT_100)
      .width(SizeToken.SIZE_PERCENT_100)
      .padding(PaddingToken.PADDING_32VP)
    }
    .title({
      builder: SubNavTitleWithBack(() => {
        this.navPathStack.pop();
      }),
      height: $r('app.float.nav_height')
    })
    .hideBackButton(true)
    .onWillDisappear(() => {
      this.isSplit = true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ActionBarParam;
    })
  }
}