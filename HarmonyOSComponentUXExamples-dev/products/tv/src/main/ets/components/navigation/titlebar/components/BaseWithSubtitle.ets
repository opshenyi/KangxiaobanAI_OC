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

import { HdsNavigation, HdsNavigationTitleMode } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { PaddingToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@Builder
export function BaseWithSubtitle() {
  Column() {
    Stack() {
      ListGroupTitle($r('app.string.basic_title_with_subtitle_label'))
    }.margin({ left: PaddingToken.PADDING_56VP })

    HdsNavigation() {
    }
    .height($r('app.float.nav_with_subtitle_height'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_56VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_56VP)
      },
      content: {
        title: {
          mainTitle: $r('app.string.title_label'),
          subTitle: $r('app.string.sub_title_label')
        }
      }
    })
    .hideBackButton(true)
    .mode(NavigationMode.Stack)
    .titleMode(HdsNavigationTitleMode.FULL)
    .backgroundColor($r('app.color.title_background_color'))
  }
}