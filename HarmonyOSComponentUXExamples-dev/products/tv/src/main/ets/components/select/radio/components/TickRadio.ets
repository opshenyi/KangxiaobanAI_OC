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

import { CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';

@ComponentV2
export struct TickRadio {
  @Local radioVal1: Resource = $r('app.string.selected_label');
  @Local radioVal2: Resource = $r('app.string.not_selected_label');

  build() {
    Row({ space: SpaceToken.SPACE_60 }) {
      Column({ space: SpaceToken.SPACE_10 }) {
        Text(this.radioVal1)
          .lineHeight(SizeToken.SIZE_NUM_19)
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
        Radio({
          value: 'Radio1', group: 'tickRadioGroup',
          indicatorType: RadioIndicatorType.TICK
        })
          .height(SizeToken.SIZE_NUM_26)
          .width(SizeToken.SIZE_NUM_26)
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.radioVal1 = $r('app.string.selected_label');
            } else {
              this.radioVal1 = $r('app.string.not_selected_label');
            }
          })
      }
      .width(SizeToken.SIZE_NUM_60)

      Column({ space: SpaceToken.SPACE_10 }) {
        Text(this.radioVal2)
          .lineHeight(SizeToken.SIZE_NUM_19)
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
        Radio({
          value: 'Radio2', group: 'tickRadioGroup',
          indicatorType: RadioIndicatorType.TICK
        })
          .height(SizeToken.SIZE_NUM_26)
          .width(SizeToken.SIZE_NUM_26)
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.radioVal2 = $r('app.string.selected_label');
            } else {
              this.radioVal2 = $r('app.string.not_selected_label');
            }
          })
      }
      .width(SizeToken.SIZE_NUM_60)
    }
    .backgroundColor($r('app.color.item_background_color'))
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width(SizeToken.SIZE_PERCENT_100)
    .padding({
      top: PaddingToken.PADDING_11VP,
      bottom: PaddingToken.PADDING_11VP,
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP
    })
  }
}