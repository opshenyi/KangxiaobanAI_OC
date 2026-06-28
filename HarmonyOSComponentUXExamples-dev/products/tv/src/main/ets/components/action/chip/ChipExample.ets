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

import { SizeToken } from 'componentuxexamplesbase';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { ListGroupTitle } from '../../common/ListGroupTitle';
import { BasicChip } from './components/BasicChip';
import { SizeChip } from './components/SizeChip';
import { TabChip } from './components/TabChip';
import { FilterChip } from './components/FilterChip';

@Builder
export function ChipExampleBuilder() {
  ChipExample();
}

@ComponentV2
struct ChipExample {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.basic_style_label'))
          BasicChip()
          ListGroupTitle($r('app.string.chip_size_label'))
          SizeChip()
          ListGroupTitle($r('app.string.tab_type_chip_label'))
          TabChip()
          ListGroupTitle($r('app.string.filter_type_chip_label'))
          FilterChip()
        }
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.title_chip_label')),
      height: $r('app.float.nav_height')
    })
  }
}