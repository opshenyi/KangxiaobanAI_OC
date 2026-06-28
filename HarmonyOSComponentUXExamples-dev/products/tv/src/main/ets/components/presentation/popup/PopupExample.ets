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
import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { ButtonPopup } from './components/ButtonPopup';
import { TextPopup } from './components/TextPopup';

@Builder
export function PopupExampleBuilder() {
  PopupExample()
}

@ComponentV2
struct PopupExample {
  build() {
    NavDestination() {
      Column() {
        ListGroupTitle($r('app.string.text_popup_label'))
        TextPopup()
        ListGroupTitle($r('app.string.action_button_popup_label'))
        ButtonPopup()
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.popup_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}