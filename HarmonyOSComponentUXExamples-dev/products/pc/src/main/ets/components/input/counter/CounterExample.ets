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
  CompactCounter,
  ComponentItem,
  HdsUtil,
  InlineCounter,
  InlineDateCounter,
  ListCounter,
  PaddingToken
} from 'componentuxexamplesbase';

@Builder
export function CounterExampleBuilder() {
  CounterExample()
}

@ComponentV2
export struct CounterExample {
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          ListCounter()
          CompactCounter()
          InlineCounter()
          InlineDateCounter()
        }
        .padding({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP
        })
      }
      .clipContent(ContentClipMode.SAFE_AREA)
      .scrollBar(BarState.Off)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.counter_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}