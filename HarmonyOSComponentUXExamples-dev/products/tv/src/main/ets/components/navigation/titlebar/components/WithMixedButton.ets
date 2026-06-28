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

import {
  HdsNavigation, HdsNavigationTitleMode
} from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@ComponentV2
export struct WithMixedButton {
  @Builder
  StackBuilder() {
    Row({ space: PaddingToken.PADDING_16VP }) {
      Button($r('app.string.common_button_label'))
        .buttonStyle(ButtonStyleMode.NORMAL)

      Button({ type: ButtonType.Circle, buttonStyle: ButtonStyleMode.NORMAL }) {
        SymbolGlyph($r('sys.symbol.circle_dashed'))
          .fontSize(SizeToken.SIZE_NUM_32)
          .fontColor([$r('sys.color.font_on_primary')])
      }
      .height(SizeToken.SIZE_NUM_54)
      .width(SizeToken.SIZE_NUM_54)
      .buttonStyle(ButtonStyleMode.NORMAL)

      Button({ type: ButtonType.Circle, buttonStyle: ButtonStyleMode.NORMAL }) {
        SymbolGlyph($r('sys.symbol.circle_dashed'))
          .fontSize(SizeToken.SIZE_NUM_32)
          .fontColor([$r('sys.color.font_on_primary')])
      }
      .height(SizeToken.SIZE_NUM_54)
      .width(SizeToken.SIZE_NUM_54)
      .buttonStyle(ButtonStyleMode.NORMAL)

      Button({ type: ButtonType.Circle, buttonStyle: ButtonStyleMode.NORMAL }) {
        SymbolGlyph($r('sys.symbol.circle_dashed'))
          .fontSize(SizeToken.SIZE_NUM_32)
          .fontColor([$r('sys.color.font_on_primary')])
      }
      .height(SizeToken.SIZE_NUM_54)
      .width(SizeToken.SIZE_NUM_54)

      Button({ type: ButtonType.Circle, buttonStyle: ButtonStyleMode.NORMAL }) {
        SymbolGlyph($r('sys.symbol.circle_dashed'))
          .fontSize(SizeToken.SIZE_NUM_32)
          .fontColor([$r('sys.color.font_on_primary')])
      }
      .height(SizeToken.SIZE_NUM_54)
      .width(SizeToken.SIZE_NUM_54)
    }
    .justifyContent(FlexAlign.End)
    .alignItems(VerticalAlign.Center)
    .width(SizeToken.SIZE_PERCENT_100)
    .padding({ right: $r('app.float.page_padding') })
  }

  build() {
    Column() {
      Stack() {
        ListGroupTitle($r('app.string.title_with_mixed_label'))
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
            mainTitle: $r('app.string.title_label'),
          },
          stackBuilder: () => this.StackBuilder()
        }
      })
      .hideBackButton(true)
      .mode(NavigationMode.Stack)
      .titleMode(HdsNavigationTitleMode.FULL)
    }
  }
}