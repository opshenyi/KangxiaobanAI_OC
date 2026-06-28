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
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';

@Builder
function firstStyleTabBuilder(index: number) {
  Column() {
    if (index === 2) {
      Badge({
        value: '',
        style: {
          badgeSize: SizeToken.SIZE_NUM_6,
          badgeColor: $r('sys.color.warning')
        }
      }) {
        SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SizeToken.SIZE_NUM_24)
      .height(SizeToken.SIZE_NUM_24)
      .margin({ bottom: PaddingToken.PADDING_2VP })
    } else {
      SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor(index === 1 ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_fourth')])
    }
    Text($r('app.string.tab_label'))
      .fontSize($r('sys.float.Caption_M'))
      .fontColor(index === 1 ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
      .lineHeight(SizeToken.SIZE_NUM_14)
      .fontWeight(FontWeight.Medium)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_PERCENT_100)
  .justifyContent(FlexAlign.Center)
}

@Builder
function secondStyleTabBuilder(index: number, val: ResourceStr) {
  Column() {
    if (index === 2) {
      Badge({
        value: '',
        position: BadgePosition.Right,
        style: {
          badgeSize: SizeToken.SIZE_NUM_6,
          badgeColor: $r('sys.color.warning')
        }
      }) {
        Text(val)
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Regular)
          .width(SizeToken.SIZE_NUM_36)
      }
    } else {
      Text(val)
        .fontColor(index === 0 ? $r('sys.color.font_on_primary') : $r('sys.color.font_primary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
  }
  .width(SizeToken.SIZE_NUM_72)
  .height(SizeToken.SIZE_NUM_36)
  .justifyContent(FlexAlign.Center)
  .backgroundColor(index === 0 ? $r('sys.color.comp_background_emphasize') : $r('sys.color.comp_background_tertiary'))
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
  .margin({ right: PaddingToken.PADDING_8VP })
}

@Builder
function bottomTabBarBadge() {
  Tabs() {
    TabContent() {
    }
    .tabBar(firstStyleTabBuilder(0))

    TabContent() {
    }
    .tabBar(firstStyleTabBuilder(1))

    TabContent() {
    }
    .tabBar(firstStyleTabBuilder(2))

    TabContent() {
    }
    .tabBar(firstStyleTabBuilder(3))
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .height(SizeToken.SIZE_NUM_48)
  .backgroundColor($r('app.color.gray_08'))
}

@Builder
export function RecommendedStyleBadge() {
  Column() {
    SubTitleView($r('app.string.recommended_style_label'))

    Row() {
      bottomTabBarBadge()
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
    .margin({ bottom: PaddingToken.PADDING_12VP })

    Row() {
      Tabs() {
        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(0, $r('app.string.tab_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(1, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(2, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(3, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(4, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(5, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(6, $r('app.string.title_label')))
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_56)
      .backgroundColor($r('app.color.gray_08'))
      .barMode(BarMode.Scrollable)
      .fadingEdge(false)
      .padding({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_8VP
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
    .margin({ bottom: PaddingToken.PADDING_12VP })

    Row() {
      Grid() {
        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.picture'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_primary')])
            }
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .borderWidth(CommonConstants.FLOAT_0_POINT_5)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.picture_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.heart'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_primary')])
            }
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .borderWidth(CommonConstants.FLOAT_0_POINT_5)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.collect_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Badge({
              value: '',
              position: BadgePosition.RightTop,
              style: { badgeSize: SizeToken.SIZE_NUM_6 }
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.music'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .width(SizeToken.SIZE_NUM_40)
              .height(SizeToken.SIZE_NUM_40)
              .borderWidth(CommonConstants.FLOAT_0_POINT_5)
              .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.music_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.mic'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_primary')])
            }
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .borderWidth(CommonConstants.FLOAT_0_POINT_5)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.mic_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.picture'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_primary')])
            }
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .borderWidth(CommonConstants.FLOAT_0_POINT_5)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.picture_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Badge({
              count: CommonConstants.INTEGER_1000,
              maxCount: CommonConstants.INTEGER_99,
              position: BadgePosition.RightTop,
              style: {}
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.heart'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .width(SizeToken.SIZE_NUM_40)
              .height(SizeToken.SIZE_NUM_40)
              .borderWidth(CommonConstants.FLOAT_0_POINT_5)
              .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.collect_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Badge({
              count: CommonConstants.INTEGER_3,
              maxCount: CommonConstants.INTEGER_99,
              position: BadgePosition.RightTop,
              style: {}
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.music'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .width(SizeToken.SIZE_NUM_40)
              .height(SizeToken.SIZE_NUM_40)
              .borderWidth(CommonConstants.FLOAT_0_POINT_5)
              .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.music_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SpaceToken.SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.mic'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_primary')])
            }
            .width(SizeToken.SIZE_NUM_40)
            .height(SizeToken.SIZE_NUM_40)
            .borderWidth(CommonConstants.FLOAT_0_POINT_5)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.mic_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }
      }
      .rowsGap(SpaceToken.SPACE_30)
      .columnsGap(SpaceToken.SPACE_32)
      .columnsTemplate(CommonConstants.COLUMNS_TEMPLATE_4)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_16VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
}