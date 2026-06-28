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
import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { CommonConstants } from '../../../../constants/CommonConstants';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';

const TAG = 'BaseSlider';

/**
 * Extract file-level global common card styles
 */
@Styles
function baseCardStyle() {
  .width(SizeToken.SIZE_PERCENT_100)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('sys.color.comp_background_list_card'))
}

@Builder
export function BaseSlider() {
  Column() {
    SubTitleView($r('app.string.common_slider_label'))

    Row() {
      Slider({
        value: CommonConstants.INTEGER_50,
        min: CommonConstants.INTEGER_0,
        max: CommonConstants.INTEGER_100,
        style: SliderStyle.NONE
      })
        .trackColor($r('sys.color.comp_background_tertiary'))
        .selectedColor($r('sys.color.comp_background_secondary'))
        .onChange((value: number) => {
          Logger.info(TAG, `Current slider progress value: ${value}`);
        })
    }
    .baseCardStyle()
    .padding(PaddingToken.PADDING_12VP)

    SubTitleView($r('app.string.outset_slider_label'))

    Row() {
      Slider({
        value: CommonConstants.INTEGER_50,
        min: CommonConstants.INTEGER_0,
        max: CommonConstants.INTEGER_100,
        style: SliderStyle.OutSet
      })
        .trackColor($r('sys.color.comp_background_tertiary'))
        .onChange((value: number) => {
          Logger.info(TAG, `Current slider progress value: ${value}`);
        })
    }
    .baseCardStyle()
    .padding({
      left: PaddingToken.PADDING_3VP,
      right: PaddingToken.PADDING_3VP,
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_12VP
    })

    SubTitleView($r('app.string.inset_slider_label'))

    Row({ space: SpaceToken.SPACE_8 }) {
      SymbolGlyph($r('sys.symbol.sun_max'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_secondary')])

      Slider({
        value: CommonConstants.INTEGER_50,
        min: CommonConstants.INTEGER_0,
        max: CommonConstants.INTEGER_100,
        style: SliderStyle.InSet
      })
        .blockColor($r('sys.color.ohos_id_color_foreground_contrary'))
        .trackColor($r('sys.color.comp_background_tertiary'))
        .selectedColor($r('sys.color.ohos_id_color_emphasize'))
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .onChange((value: number) => {
          Logger.info(TAG, `Current slider progress value: ${value}`);
        })

      SymbolGlyph($r('sys.symbol.sun_max_fill'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_secondary')])
    }
    .baseCardStyle()
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}