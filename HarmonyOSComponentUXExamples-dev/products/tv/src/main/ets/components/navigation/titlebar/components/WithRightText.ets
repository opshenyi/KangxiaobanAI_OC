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
import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@ComponentV2
export struct WithRightText {
  // Set the custom area at the top of the title bar
  @Builder
  ContentBuilder() {
    Column() {
      Text($r('app.string.function_tips_text_label'))
        .fontSize(SizeToken.SIZE_NUM_24)
        .fontColor($r('sys.color.font_secondary'))
        .margin({ right: PaddingToken.PADDING_56VP })
    }
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.End)
  }

  build() {
    Column() {
      Stack() {
        ListGroupTitle($r('app.string.title_with_right_text_label'))
      }.margin({ left: PaddingToken.PADDING_56VP })

      HdsNavigation() {
      }
      .height($r('app.float.nav_title_height'))
      .backgroundColor($r('app.color.title_background_color'))
      .titleBar({
        padding: {
          start: LengthMetrics.vp(PaddingToken.PADDING_56VP),
          end: LengthMetrics.vp(PaddingToken.PADDING_56VP)
        },
        content: {
          title: {
            mainTitle: $r('app.string.title_label')
          },
          stackBuilder: (): void => this.ContentBuilder()
        }
      })
      .hideBackButton(true)
      .mode(NavigationMode.Stack)
      .titleMode(HdsNavigationTitleMode.FULL)
    }
  }
}