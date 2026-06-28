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
import { ComponentItem, HdsUtil, PaddingToken, SizeToken, SubTitleView as GroupHeader } from 'componentuxexamplesbase';
import { DropdownMenu } from './components/DropdownMenu';
import { IconStyledMenu } from './components/IconStyledMenu';
import { TitleStyledMenu } from './components/TitleStyledMenu';
import { MultiLevelMenu } from './components/MultiLevelMenu';
import { DirectionalMenu } from './components/DirectionalMenu';

@Builder
export function MenuExampleBuilder() {
  MenuExample()
}

@ComponentV2
struct MenuExample {
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  build() {
    HdsNavDestination() {
      List() {
        ListItemGroup({
          header: GroupHeader($r('app.string.basic_style_label'), undefined, $r('app.color.default_background_color'))
        }) {
          DropdownMenu()
          IconStyledMenu()
          TitleStyledMenu()
          MultiLevelMenu()
          DirectionalMenu()
        }
        .divider({
          strokeWidth: SizeToken.SIZE_NUM_12,
          color: $r('sys.color.background_secondary'),
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clipContent(ContentClipMode.SAFE_AREA)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.menu_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}