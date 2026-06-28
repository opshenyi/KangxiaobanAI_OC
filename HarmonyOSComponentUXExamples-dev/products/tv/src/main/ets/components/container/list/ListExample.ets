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

import { PaddingToken, SizeToken } from 'componentuxexamplesbase'
import { ListGroupTitle } from '../../common/ListGroupTitle'
import { SubNavigationTitle } from '../../common/SubNavTitle'
import { EfficientList } from './components/EfficientList'
import { ContentList } from './components/ContentList'

@Builder
export function ListExampleBuilder() {
  ListExample()
}

@ComponentV2
struct ListExample {
  build() {

    NavDestination() {
      Column() {
        List() {
          ListItemGroup({
            header: ListGroupTitle($r('app.string.efficiency_oriented_list_label'), $r('app.float.page_padding')),
            space: PaddingToken.PADDING_16VP
          }) {
            EfficientList()
          }

          ListItemGroup({
            header: ListGroupTitle($r('app.string.content_type_list_label'), $r('app.float.page_padding')),
            space: PaddingToken.PADDING_16VP
          }) {
            ContentList()
          }
        }
        .height(SizeToken.SIZE_PERCENT_100)
        .width(SizeToken.SIZE_PERCENT_100)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
        .fadingEdge(true)
      }
      .padding({
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.list_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}