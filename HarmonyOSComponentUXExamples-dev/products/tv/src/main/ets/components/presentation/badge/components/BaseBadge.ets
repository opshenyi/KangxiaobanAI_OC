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

import { CommonConstants, CornerRadiusToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

@Builder
function CircleImage() {
  Stack() {
    Circle({ width: 54, height: 54 })
      .fill($r('app.color.item_background_color'))
      .stroke($r('app.color.item_border_color'))
      .strokeWidth(SizeToken.SIZE_NUM_1)
    SymbolGlyph($r('sys.symbol.ellipsis_message'))
      .fontSize($r('app.float.symbol_size_large'))
      .fontColor([$r('app.color.symbol_img_color')])
  }
}

@Builder
export function BaseBadge() {
  Column() {
    ListGroupTitle($r('app.string.basic_style_label'))
    Row({ space: $r('app.float.badge_space') }) {
      Badge({
        count: CommonConstants.INTEGER_3,
        position: BadgePosition.RightTop,
        style: { badgeSize: $r('app.float.badge_size_large') }
      }) {
        CircleImage()
      }

      Badge({
        value: CommonConstants.INTEGER_36.toString(),
        position: BadgePosition.RightTop,
        style: { badgeSize: $r('app.float.badge_size_large') }
      }) {
        CircleImage()
      }

      Badge({
        count: CommonConstants.INTEGER_1000,
        maxCount: CommonConstants.INTEGER_99,
        position: BadgePosition.RightTop,
        style: { badgeSize: $r('app.float.badge_size_large') }
      }) {
        CircleImage()
      }

      Badge({
        value: '',
        position: BadgePosition.RightTop,
        style: { badgeSize: $r('app.float.badge_size_small') }
      }) {
        CircleImage()
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .padding($r('sys.float.padding_level8'))
  }
  .width(SizeToken.SIZE_PERCENT_100)
}