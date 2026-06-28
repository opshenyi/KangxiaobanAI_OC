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

import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';

@Builder
export function NonInteractiveRatingScene() {
  Row({ space: SpaceToken.SPACE_10 }) {
    Image($r('app.media.avatar1'))
      .width(SizeToken.SIZE_NUM_40)
      .height(SizeToken.SIZE_NUM_40)

    Column() {
      Row() {
        Text($r('app.string.comment_user_name_label'))
          .fontColor($r('sys.color.font_primary'))
          .lineHeight(SizeToken.SIZE_NUM_19)
          .fontSize($r('app.float.content_text_size14'))
          .fontWeight(FontWeight.Bold)

        Text($r('app.string.comment_right_text_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.content_text_size12'))
          .fontWeight(FontWeight.Regular)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: PaddingToken.PADDING_2VP })

      Row({ space: SpaceToken.SPACE_8 }) {
        Text($r('app.string.comment_user_name_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.content_text_size10'))
          .fontWeight(FontWeight.Regular)

        Rating({ rating: CommonConstants.INTEGER_2, indicator: true })
          .stars(CommonConstants.INTEGER_5)
          .stepSize(CommonConstants.FLOAT_0_POINT_5)

        Text($r('app.string.comment_date_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.content_text_size10'))
          .fontWeight(FontWeight.Regular)

        Blank()
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .margin({ bottom: PaddingToken.PADDING_10VP })

      Row() {
        Text($r('app.string.comment_section_content_info_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('app.float.content_text_size12'))
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.JUSTIFY)  // Enables justification
          .wordBreak(WordBreak.HYPHENATION)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .margin({ bottom: PaddingToken.PADDING_8VP })

      Row({ space: PaddingToken.PADDING_4VP }) {
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
  .backgroundColor($r('app.color.item_background_color'))
  .borderWidth(SizeToken.SIZE_NUM_1)
  .borderColor($r('app.color.item_border_color'))
  .padding(PaddingToken.PADDING_16VP)
}