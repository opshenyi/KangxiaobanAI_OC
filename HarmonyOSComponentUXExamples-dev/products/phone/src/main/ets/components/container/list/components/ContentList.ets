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
import { HdsListItemCard, PrefixImage } from '@kit.UIDesignKit';
import { CommonConstants, CornerRadiusToken, Logger, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { CardWrapperModifier, getAvatarImageModifier } from '../common/ListStyleModifiers';

const TAG = 'ContentList';

interface BasicImageTextListItemTypes {
  imageRes: Resource,
  imgWidth: Length,
  imgHeight: Length,
  primaryText: Resource,
  rowHeight: Length
}

/**
 * Reusable Builder for standard static image-text ListItems.
 * Centralizes UI configuration to drastically reduce repetitive boilerplate code.
 */
@Builder
function BasicImageTextListItem(param: BasicImageTextListItemTypes) {
  ListItem() {
    Row() {
      HdsListItemCard({
        prefixItem: new PrefixImage({
          image: param.imageRes,
          modifier: getAvatarImageModifier(param.imgWidth, param.imgHeight, CornerRadiusToken.CORNER_RADIUS_8)
        }),
        textItem: {
          primaryText: { text: param.primaryText },
          secondaryText: { text: $r('app.string.auxiliary_text_label') },
          description: { text: $r('app.string.auxiliary_text_label') }
        },
        cardPrefixMargin: CommonConstants.INTEGER_0,
        cardSuffixMargin: CommonConstants.INTEGER_0,
        cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
      })
    }
    .attributeModifier(new CardWrapperModifier(param.rowHeight))
  }
}

@Builder
export function ContentList() {
  Column() {
    SubTitleView($r('app.string.content_type_expandable_list_label'))
    List({ space: SpaceToken.SPACE_12 }) {
      ListItem() {
        ExpandableListItem()
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height('auto')

    SubTitleView($r('app.string.content_type_list_label'))
    List({ space: SpaceToken.SPACE_12 }) {
      BasicImageTextListItem({
        imageRes: $r('app.media.scenery3'),
        imgWidth: SizeToken.SIZE_NUM_56,
        imgHeight: SizeToken.SIZE_NUM_56,
        primaryText: $r('app.string.small_image_and_three_line_list_label'),
        rowHeight: SizeToken.SIZE_NUM_88
      })

      BasicImageTextListItem({
        imageRes: $r('app.media.scenery4'),
        imgWidth: SizeToken.SIZE_NUM_48,
        imgHeight: SizeToken.SIZE_NUM_64,
        primaryText: $r('app.string.three_by_four_small_image_label'),
        rowHeight: SizeToken.SIZE_NUM_88
      })

      BasicImageTextListItem({
        imageRes: $r('app.media.scenery5'),
        imgWidth: SizeToken.SIZE_NUM_72,
        imgHeight: SizeToken.SIZE_NUM_72,
        primaryText: $r('app.string.image_and_three_line_list_label'),
        rowHeight: SizeToken.SIZE_NUM_104
      })

      BasicImageTextListItem({
        imageRes: $r('app.media.scenery6'),
        imgWidth: SizeToken.SIZE_NUM_66,
        imgHeight: SizeToken.SIZE_NUM_88,
        primaryText: $r('app.string.three_by_four_image_label'),
        rowHeight: SizeToken.SIZE_NUM_128
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_444)
  }
}

@ComponentV2
export struct ExpandableListItem {
  // Controls the expanded and collapsed state
  @Local isExpanded: boolean = false;
  // Simulates data source for three child items
  private readonly childItems: number[] = [1, 2, 3];

  build() {
    Column() {
      // Parent node ListItem (with expand/collapse arrow)
      Row() {
        Text($r('app.string.expandable_list_label'))
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        // Toggles between up/down arrows based on isExpanded state
        SymbolGlyph(this.isExpanded ? $r('sys.symbol.chevron_up') : $r('sys.symbol.chevron_down'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_tertiary')])
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_40)
      .onClick(() => {
        this.getUIContext().animateTo({
          // Sets up collapse/expand animation effects for the button
          duration: CommonConstants.DURATION_300,
onFinish: () => {
            Logger.info(TAG, 'animation end');
          }
        }, () => {
          // Toggles the expanded/collapsed state on click
          this.isExpanded = !this.isExpanded;
        });
      })

      // Child node ListItems (visible when expanded, indented 24vp inward)
      if (this.isExpanded) {
        ForEach(this.childItems, (item: number, index: number) => {
          Row({ space: SpaceToken.SPACE_8 }) {
            Image($r('app.media.avatar1'))
              .width(SizeToken.SIZE_NUM_32)
              .height(SizeToken.SIZE_NUM_32)

            Column() {
              Row({ space: SpaceToken.SPACE_16 }) {
                Text($r('app.string.list_item_label', item))
                  .fontSize($r('sys.float.Body_L'))
                  .fontColor($r('sys.color.font_primary'))
                  .fontWeight(FontWeight.Medium)

                Blank()

                SymbolGlyph($r('sys.symbol.circle_dashed'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])

                SymbolGlyph($r('sys.symbol.circle_dashed'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .width(SizeToken.SIZE_PERCENT_100)
              .height(SizeToken.SIZE_NUM_40)

              if (index !== this.childItems.length - 1) {
                Divider().color($r('sys.color.comp_divider'))
              }
            }
            .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          }
          .width(SizeToken.SIZE_PERCENT_100)
        }, (item: number, index: number) => `${index}_${item}`)
      }
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_4VP,
      bottom: PaddingToken.PADDING_4VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }
}