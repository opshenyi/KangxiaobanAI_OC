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
  BreakpointModel,
  ComponentItem,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';
import { CollapsedActionBar } from './components/CollapsedActionBar';
import { HorizontalActionBar } from './components/HorizontalActionBar';
import { VerticalActionBar } from './components/VerticalActionBar';

@Builder
export function ActionBarExampleBuilder() {
  ActionBarExample()
}

@ComponentV2
struct ActionBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  // Extract the padding computation logic for breakpoints
  @Computed
  get sectionPadding(): number {
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_4VP,
      md: PaddingToken.PADDING_4VP,
      lg: PaddingToken.PADDING_12VP
    });
  }

  // Extract NavDestination Title padding calculation logic
  @Computed
  get titlePadding(): LengthMetrics {
    return this.breakpointModel.getValue({
      sm: LengthMetrics.vp(PaddingToken.PADDING_16VP),
      md: LengthMetrics.vp(PaddingToken.PADDING_16VP),
      lg: LengthMetrics.vp(PaddingToken.PADDING_24VP)
    });
  }

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          GroupHeader($r('app.string.horizontal_label'), this.sectionPadding)
          CollapsedActionBar()
          HorizontalActionBar()

          GroupHeader($r('app.string.vertical_side_floating_action_bar_label'), this.sectionPadding)
          VerticalActionBar()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_0VP
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
        start: this.titlePadding,
        end: this.titlePadding
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.action_bar_label'), this.pageParam)
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}