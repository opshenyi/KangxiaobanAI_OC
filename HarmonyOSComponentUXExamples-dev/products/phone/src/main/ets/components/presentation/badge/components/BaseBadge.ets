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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@Builder
export function BaseBadge() {
  Column() {
    SubTitleView($r('app.string.basic_type_label'))

    Row() {
      Badge({
        count: CommonConstants.INTEGER_3,
        position: BadgePosition.RightTop,
        style: {}
      }) {
        Rect({ width: SizeToken.SIZE_NUM_40, height: SizeToken.SIZE_NUM_40 })
          .radiusWidth(CornerRadiusToken.CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        value: CommonConstants.INTEGER_36.toString(),
        position: BadgePosition.RightTop,
        style: {}
      }) {
        Rect({ width: SizeToken.SIZE_NUM_40, height: SizeToken.SIZE_NUM_40 })
          .radiusWidth(CornerRadiusToken.CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        count: CommonConstants.INTEGER_1000,
        maxCount: CommonConstants.INTEGER_99,
        position: BadgePosition.RightTop,
        style: {}
      }) {
        Rect({ width: SizeToken.SIZE_NUM_40, height: SizeToken.SIZE_NUM_40 })
          .radiusWidth(CornerRadiusToken.CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        value: '',
        position: BadgePosition.RightTop,
        style: { badgeSize: SizeToken.SIZE_NUM_6 }
      }) {
        Rect({ width: SizeToken.SIZE_NUM_40, height: SizeToken.SIZE_NUM_40 })
          .radiusWidth(CornerRadiusToken.CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}