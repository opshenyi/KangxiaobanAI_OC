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
import { ListDialog } from './components/ListDialog';
import { TextDialog } from './components/TextDialog';
import { TextWithCheckDialog } from './components/TextWithCheckDialog';
import { ProgressBarDialog } from './components/ProgressBarDialog';
import { TextWithPicDialog } from './components/TextWithPicDialog';
import { WithLoadingDialog } from './components/WithLoadingDialog';

@Builder
export function DialogExampleBuilder() {
  DialogExample()
}

@ComponentV2
struct DialogExample {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.left_text_tab_label'))
          Column({ space: SizeToken.SIZE_NUM_16 }) {
            TextDialog()
            TextWithCheckDialog()
            ListDialog()
            WithLoadingDialog()
            ProgressBarDialog()
            TextWithPicDialog()
          }
        }
      }
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .height(SizeToken.SIZE_PERCENT_100)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11'),
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.dialog_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}