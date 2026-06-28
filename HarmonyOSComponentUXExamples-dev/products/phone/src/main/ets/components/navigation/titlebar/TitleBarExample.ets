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
import { BreakpointModel, ComponentItem, HdsUtil, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { BaseTitle } from './components/BaseTitle';
import { DrawerTitle } from './components/DrawerTitle';
import { EditableTitle } from './components/EditableTitle';
import { EmphasizedTitle } from './components/EmphasizedTitle';
import { SecondaryPageTitle } from './components/SecondaryPageTitle';

@Builder
export function TitleBarExampleBuilder() {
  TitleBarExample()
}

@ComponentV2
struct TitleBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

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
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({ bottom: PaddingToken.PADDING_16VP })
      }
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
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.title_bar_title_label'), this.pageParam)
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}