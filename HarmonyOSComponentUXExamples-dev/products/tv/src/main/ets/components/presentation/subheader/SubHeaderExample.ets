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

import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { SizeToken } from 'componentuxexamplesbase';
import { ListSubHeader } from './components/ListSubHeader';
import { ContentSubHeader } from './components/ContentSubHeader';
import { BasicStyleHeader } from './components/BasicStyleHeader';

@Builder
export function SubHeaderExampleBuilder() {
  SubHeaderExample()
}

@ComponentV2
struct SubHeaderExample {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.basic_style_label'), $r('app.float.page_padding'))
          BasicStyleHeader()
          ListGroupTitle($r('app.string.list_with_subheader'), $r('app.float.page_padding'))
          ListSubHeader()
          ListGroupTitle($r('app.string.content_subheader'), $r('app.float.page_padding'))
          ContentSubHeader()
        }
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.subheader_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}