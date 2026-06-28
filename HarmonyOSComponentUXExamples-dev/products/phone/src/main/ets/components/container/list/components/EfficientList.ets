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
import { LengthMetrics } from '@kit.ArkUI';
import {
  HdsListItemCard,
  IconSize,
  PrefixIcon,
  SuffixImage,
  SuffixSubIcon,
  SuffixSwitch,
  SuffixText,
  SuffixTextAndArrow
} from '@kit.UIDesignKit';
import { Logger } from 'componentuxexamplesbase';
import { CommonConstants, PaddingToken, SizeToken, SpaceToken, SubTitleViewV2 } from 'componentuxexamplesbase';
import { DividerConstants, FullWidthRowModifier, ListItemGroupModifier } from '../common/ListStyleModifiers';

const TAG = 'EfficientList';

@ComponentV2
export struct EfficientList {
  @Local isRadioChecked: boolean = false;
  @Param isPC: boolean = false;
  // Cached modifier instances
  private readonly groupMod12vp = new ListItemGroupModifier(PaddingToken.PADDING_12VP);
  private readonly groupMod6vp = new ListItemGroupModifier(PaddingToken.PADDING_6VP);
  private readonly rowMod56 = new FullWidthRowModifier(SizeToken.SIZE_NUM_56);
  private readonly rowMod64 = new FullWidthRowModifier(SizeToken.SIZE_NUM_64);
  private readonly rowMod104 = new FullWidthRowModifier(SizeToken.SIZE_NUM_104);

  @Builder
  DropdownMenuBuilder() {
    Menu() {
      MenuItem({ content: $r('app.string.menu_item_label') })
      MenuItem({ content: $r('app.string.menu_item_label') })
      MenuItem({ content: $r('app.string.menu_item_label') })
      MenuItem({ content: $r('app.string.menu_item_label') })
    }
    .menuItemDivider({
      strokeWidth: LengthMetrics.vp(SizeToken.SIZE_NUM_1),
      color: $r('sys.color.comp_background_tertiary'),
      mode: DividerMode.EMBEDDED_IN_MENU
    })
  }

  build() {
    Column() {
      SubTitleViewV2({ val: $r('app.string.efficiency_oriented_list_label') })
      List({ space: SpaceToken.SPACE_12 }) {
        ListItemGroup() {
          ListItem() {
            Row() {
              Text($r('app.string.single_line_list_and_drop_down_options_label'))
                .fontSize($r('sys.float.Body_L'))
                .fontWeight(FontWeight.Medium)
                .fontColor($r('sys.color.font_primary'))

              Blank()

              Row() {
                Text($r('app.string.drop_down_options_label'))
                  .fontSize($r('sys.float.Subtitle_S'))
                  .fontColor($r('sys.color.font_secondary'))
                  .margin({ right: PaddingToken.PADDING_8VP })

                SymbolGlyph($r('sys.symbol.arrowtriangle_down_fill'))
                  .fontSize($r('sys.float.Body_L'))
                  .fontColor([$r('sys.color.icon_fourth')])
              }
              .bindMenu(this.DropdownMenuBuilder)
            }
            .attributeModifier(this.rowMod56)
          }

          ListItem() {
            Row() {
              Text($r('app.string.right_side_checkbox_label'))
                .fontSize($r('sys.float.Body_L'))
                .fontWeight(FontWeight.Medium)
                .fontColor($r('sys.color.font_primary'))

              Blank()

              Radio({ value: 'Radio', group: 'radioGroup' })
                .checked(this.isRadioChecked)
                .onClick(() => {
                  this.isRadioChecked = !this.isRadioChecked;
                })
            }
            .attributeModifier(this.rowMod56)
          }
        }
        .attributeModifier(this.groupMod12vp)
        .divider(DividerConstants.FULL_WIDTH)

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: { text: $r('app.string.double_line_list_and_switch_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') }
                },
                suffixItem: new SuffixSwitch({
                  isCheck: false,
                  onChange: (isOn: boolean) => Logger.info(TAG,
                    `Current toggle isSelected status: ${isOn}`)
                }),
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod64)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: { text: $r('app.string.right_side_image_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') }
                },
                suffixItem: new SuffixImage({ image: $r('app.media.img_1') }),
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod64)
          }
        }
        .attributeModifier(this.groupMod6vp)
        .divider(DividerConstants.PADDING_6)

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: { text: $r('app.string.three_line_list_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') },
                  description: { text: $r('app.string.auxiliary_text_label') }
                },
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod104)
          }
        }
        .attributeModifier(this.groupMod6vp)

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: { symbol: $r('sys.symbol.star_circle_fill') }
                }),
                textItem: {
                  primaryText: { text: $r('app.string.icon_and_single_line_text_label') }
                },
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod56)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: { symbol: $r('sys.symbol.star_circle_fill') }
                }),
                textItem: {
                  primaryText: { text: $r('app.string.two_icons_on_the_right_label') }
                },
                suffixItem: new SuffixSubIcon(
                  {
                    iconValue: { symbol: $r('sys.symbol.circle_dashed') },
                    onClick: () => Logger.info(TAG, 'The circle dash has been clicked currently.')
                  },
                  {
                    iconValue: { symbol: $r('sys.symbol.circle_dashed') },
                    onClick: () => Logger.info(TAG, 'The circle dash has been clicked currently.')
                  }
                ),
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod56)
          }
        }
        .attributeModifier(this.groupMod6vp)
        .divider(DividerConstants.PADDING_40_6)

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: { symbol: $r('sys.symbol.star_circle_fill') }
                }),
                textItem: {
                  primaryText: { text: $r('app.string.icon_and_double_line_text_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') }
                },
                suffixItem: new SuffixText({ text: $r('app.string.right_text_label') }),
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod64)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: { symbol: $r('sys.symbol.star_circle_fill') }
                }),
                textItem: {
                  primaryText: { text: $r('app.string.icon_and_double_line_text_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') }
                },
                suffixItem: new SuffixTextAndArrow({ text: $r('app.string.right_text_label') }, {}),
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              })
            }
            .attributeModifier(this.rowMod64)
          }
        }
        .attributeModifier(this.groupMod6vp)
        .divider(DividerConstants.PADDING_40_6)
      }
      .height(SizeToken.SIZE_NUM_636)
      .width(SizeToken.SIZE_PERCENT_100)
    }
  }
}