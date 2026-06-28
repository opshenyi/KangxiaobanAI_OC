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

import { SizeToken } from 'componentuxexamplesbase'
import { ListGroupTitle } from '../../common/ListGroupTitle'
import { SubNavigationTitle } from '../../common/SubNavTitle'
import { DigitIndicatorDemo } from './components/DigitIndicatorDemo'
import { DotIndicatorDemo } from './components/DotIndicatorDemo'

@Builder
export function SwiperExampleBuilder() {
  SwiperExample()
}

@ComponentV2
struct SwiperExample {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.dot_indicator_label'))
          DotIndicatorDemo()
          ListGroupTitle($r('app.string.digit_indicator_label'))
          DigitIndicatorDemo()
        }
      }
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .height(SizeToken.SIZE_PERCENT_100)
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
      builder: SubNavigationTitle($r('app.string.Swiper_title')),
      height: $r('app.float.nav_height')
    })
  }
}