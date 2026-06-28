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
import { SubTitleView } from '../../../../common/SubTitleView'
import { CommonConstants } from '../../../../constants/CommonConstants'
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken'
import { PaddingToken } from '../../../../designtoken/PaddingToken'
import { SizeToken } from '../../../../designtoken/SizeToken'
import { SpaceToken } from '../../../../designtoken/SpaceToken'

@Builder
export function NonInteractiveRating() {
  Column() {
    SubTitleView($r('app.string.non_interactive_rating_bar_label'))

    Row() {
      Rating({ rating: CommonConstants.INTEGER_1, indicator: true })
        .stars(CommonConstants.INTEGER_5)
        .stepSize(CommonConstants.FLOAT_0_POINT_5)
        .width(SizeToken.SIZE_NUM_28 * 5)
        .height(SizeToken.SIZE_NUM_28)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)

    SubTitleView($r('app.string.common_scenarios_for_non_interactive_rating_bar_label'))

    Row({ space: SpaceToken.SPACE_8 }) {
      Image($r('app.media.avatar1'))
        .width(SizeToken.SIZE_NUM_40)
        .height(SizeToken.SIZE_NUM_40)

      Column() {
        Row() {
          Text('Jia')
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_S'))
            .fontWeight(FontWeight.Bold)

          Text('First')
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Regular)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)

        Row({ space: SpaceToken.SPACE_8 }) {
          Text('Jia')
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Caption_M'))
            .fontWeight(FontWeight.Regular)

          Rating({ rating: CommonConstants.INTEGER_2, indicator: true })
            .stars(CommonConstants.INTEGER_5)
            .stepSize(CommonConstants.FLOAT_0_POINT_5)

          Text('2017/12/08')
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Caption_M'))
            .fontWeight(FontWeight.Regular)

          Blank()
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .margin({ bottom: PaddingToken.PADDING_12VP })

        Row() {
          Text($r('app.string.comment_section_content_info_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.JUSTIFY)  // Enables justification
            .wordBreak(WordBreak.HYPHENATION)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .margin({ bottom: PaddingToken.PADDING_8VP })

        Row({ space: SpaceToken.SPACE_12 }) {
          Image($r('app.media.img_1'))
            .width(SizeToken.SIZE_NUM_77)
            .height(SizeToken.SIZE_NUM_77)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
            .clip(true)

          Image($r('app.media.img_2'))
            .width(SizeToken.SIZE_NUM_77)
            .height(SizeToken.SIZE_NUM_77)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
            .clip(true)

          Image($r('app.media.img_3'))
            .width(SizeToken.SIZE_NUM_77)
            .height(SizeToken.SIZE_NUM_77)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
            .clip(true)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Top)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}