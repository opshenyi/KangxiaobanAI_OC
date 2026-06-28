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
import { ComponentItem, HdsUtil, PaddingToken } from 'componentuxexamplesbase';
import { EmphasizedTitle } from './components/EmphasizedTitle';
import { BaseTitle } from './components/BaseTitle';
import { DrawerTitle } from './components/DrawerTitle';
import { SecondaryPageTitle } from './components/SecondaryPageTitle';
import { EditableTitle } from './components/EditableTitle';

@Builder
export function TitleBarExampleBuilder() {
  TitleBarExample()
}

@ComponentV2
struct TitleBarExample {
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          EmphasizedTitle()
          BaseTitle()
          DrawerTitle()
          SecondaryPageTitle()
          EditableTitle()
        }
        .padding({ bottom: PaddingToken.PADDING_16VP })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clipContent(ContentClipMode.SAFE_AREA)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.title_bar_title_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}