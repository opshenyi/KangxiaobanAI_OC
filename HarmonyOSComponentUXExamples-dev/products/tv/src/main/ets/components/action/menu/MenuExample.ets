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

import { DropdownMenu } from './components/DropdownMenu';
import { IconStyledMenu } from './components/IconStyledMenu';
import { LongPressFloatingMenu } from './components/LongPressFloatingMenu';
import { TitleStyledMenu } from './components/TitleStyledMenu';
import { BreakpointModel, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { SubTitleStyledMenu } from './components/SubTitleStyledMenu';

@Builder
export function MenuExampleBuilder() {
  MenuExample()
}

@ComponentV2
struct MenuExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      List() {
        ListItemGroup({
          header: ListGroupTitle($r('app.string.basic_style_label'))
        }) {
          DropdownMenu()
          IconStyledMenu()
          TitleStyledMenu()
          SubTitleStyledMenu()
        }
        .divider({
          strokeWidth: SizeToken.SIZE_NUM_12,
          color: Color.Transparent
        })

        ListItemGroup({
          header: ListGroupTitle($r('app.string.floating_menu_label'))
        }) {
          LongPressFloatingMenu()
        }
        .divider({
          strokeWidth: SizeToken.SIZE_NUM_12,
          color: Color.Transparent
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
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
      builder: SubNavigationTitle($r('app.string.menu_label')),
      height: $r('app.float.nav_height')
    })
  }
}