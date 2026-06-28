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
import { ComponentItem, HdsUtil, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { DifferentSizeSelect } from './components/DifferentSizeSelect';
import { InputAndUnitSelect } from './components/InputAndUnitSelect';
import { SelectAndInput } from './components/SelectAndInput';
import { SelectAndSearch } from './components/SelectAndSearch';

@Builder
export function SelectExampleBuilder() {
  SelectExample()
}

@ComponentV2
struct SelectExample {
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          DifferentSizeSelect()
          SelectAndInput()
          SelectAndSearch()
          InputAndUnitSelect()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP,
          bottom: PaddingToken.PADDING_16VP
        })
      }
      .align(Alignment.Top)
      .height(SizeToken.SIZE_PERCENT_100)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .clipContent(ContentClipMode.SAFE_AREA)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.select_en_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}