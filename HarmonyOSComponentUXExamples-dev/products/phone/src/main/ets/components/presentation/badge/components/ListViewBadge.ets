/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@Builder
export function ListViewBadge() {
  Column() {
    SubTitleView($r('app.string.list_style_label'))

    Column() {
      Row() {
        Badge({
          count: CommonConstants.INTEGER_3,
          position: BadgePosition.Right,
          style: { badgeColor: $r('sys.color.warning') }
        }) {
          Text($r('app.string.single_list_1_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .margin({ left: PaddingToken.PADDING_4VP })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(SizeToken.SIZE_NUM_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Badge({
          value: CommonConstants.EMPTY_STRING,
          position: BadgePosition.Right,
          style: {
            badgeSize: SizeToken.SIZE_NUM_8,
            badgeColor: $r('app.color.badge_color_1'),
            borderColor: Color.Transparent
          }
        }) {
          Text($r('app.string.single_list_2_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .margin({ left: PaddingToken.PADDING_4VP })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(SizeToken.SIZE_NUM_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Badge({
          count: CommonConstants.INTEGER_3,
          position: BadgePosition.Left,
          style: { badgeColor: $r('sys.color.warning') }
        }) {
          Text($r('app.string.single_list_3_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontWeight(FontWeight.Medium)
            .margin({ left: PaddingToken.PADDING_28VP })
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .margin({ left: PaddingToken.PADDING_4VP })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(SizeToken.SIZE_NUM_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Badge({
          value: CommonConstants.EMPTY_STRING,
          position: BadgePosition.Left,
          style: {
            badgeSize: SizeToken.SIZE_NUM_8,
            badgeColor: $r('app.color.badge_color_1'),
            borderColor: Color.Transparent
          }
        }) {
          Text($r('app.string.single_list_4_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontWeight(FontWeight.Medium)
            .margin({ left: PaddingToken.PADDING_20VP })
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_4VP,
      bottom: PaddingToken.PADDING_4VP
    })
    .margin({ bottom: PaddingToken.PADDING_12VP })

    Column() {
      Row() {
        Row() {
          Image($r('app.media.avatar1'))
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .margin({ right: PaddingToken.PADDING_16VP })

          Column() {
            Badge({
              value: CommonConstants.EMPTY_STRING,
              position: BadgePosition.Right,
              style: {
                badgeSize: SizeToken.SIZE_NUM_6,
                badgeColor: $r('sys.color.warning')
              }
            }) {
              Text($r('app.string.evelyn_label'))
                .fontColor($r('sys.color.font_primary'))
                .fontSize($r('sys.float.Subtitle_M'))
                .fontWeight(FontWeight.Medium)
                .width(SizeToken.SIZE_NUM_60)
            }

            Text($r('app.string.auxiliary_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Body_M'))
              .fontWeight(FontWeight.Regular)
          }
          .alignItems(HorizontalAlign.Start)
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_63)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(CommonConstants.LAYOUT_WEIGHT_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Row() {
          Image($r('app.media.avatar2'))
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .margin({ right: PaddingToken.PADDING_16VP })

          Column() {
            Text($r('app.string.marcia_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Subtitle_M'))
              .fontWeight(FontWeight.Medium)

            Text($r('app.string.auxiliary_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Body_M'))
              .fontWeight(FontWeight.Regular)
          }
          .alignItems(HorizontalAlign.Start)
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_63)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_4VP,
      bottom: PaddingToken.PADDING_4VP
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
}