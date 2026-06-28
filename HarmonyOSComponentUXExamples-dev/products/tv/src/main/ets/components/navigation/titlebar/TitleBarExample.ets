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

import { SubNavigationTitle } from '../../common/SubNavTitle'
import { BaseTitle } from './components/BaseTitle'
import { WithCircleButton } from './components/WithCircleButton'
import { BaseWithSubtitle } from './components/BaseWithSubtitle'
import { WithCapsuleButton } from './components/WithCapsuleButton'
import { WithMixedButton } from './components/WithMixedButton'
import { WithRightText } from './components/WithRightText'
import { SubpageWithSingleLint } from './components/SubpageWithSingleLint'
import { SubpageWithDoubleLine } from './components/SubpageWithDoubleLine'

@Builder
export function TitleBarExampleBuilder() {
  TitleBarExample()
}

@ComponentV2
struct TitleBarExample {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          BaseTitle()
          BaseWithSubtitle()
          WithRightText()
          WithCircleButton()
          WithCapsuleButton()
          WithMixedButton()
          SubpageWithSingleLint()
          SubpageWithDoubleLine()
        }
      }
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
      builder: SubNavigationTitle($r('app.string.title_bar_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}