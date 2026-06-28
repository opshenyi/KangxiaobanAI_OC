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
import { SubTitleViewV2 } from '../../../../common/SubTitleView';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';

@Builder
export function CustomToggle() {
  Column() {
    SubTitleViewV2({ val: $r('app.string.customize_parameters_such_as_rounded_corners_and_colors_label') })

    Row() {
      Text($r('app.string.toggle_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor($r('sys.color.multi_color_02'))
        .switchStyle({
          pointRadius: CornerRadiusToken.CORNER_RADIUS_8,
          trackBorderRadius: CornerRadiusToken.CORNER_RADIUS_4
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .justifyContent(FlexAlign.Center)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })

    SubTitleViewV2({ val: $r('app.string.customize_parameters_such_as_size_and_color_label') })

    Row() {
      Text($r('app.string.toggle_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: true })
        .width(SizeToken.SIZE_NUM_28)
        .height(SizeToken.SIZE_NUM_10)
        .selectedColor($r('app.color.multi_color_08'))
        .switchStyle({
          pointRadius: CornerRadiusToken.CORNER_RADIUS_8,
          trackBorderRadius: CornerRadiusToken.CORNER_RADIUS_12,
          pointColor: $r('sys.color.multi_color_08')
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .justifyContent(FlexAlign.Center)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
}