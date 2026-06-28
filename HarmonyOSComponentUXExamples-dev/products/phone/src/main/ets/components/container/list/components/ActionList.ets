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
import { HdsListItem, HdsListItemCard, PrefixImage, SuffixArrowIconText, SuffixButton } from '@kit.UIDesignKit';
import { SymbolGlyphModifier } from '@kit.ArkUI';
import {
  CommonConstants,
  CommonUtils,
  CornerRadiusToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';
import { CardWrapperModifier, getAvatarImageModifier, getHdsListItemModifier } from '../common/ListStyleModifiers';

@ComponentV2
export struct ActionList {
  @Local dataArr: string[] = [];
  @Local listHeight: number = 256;
  // Cache modifiers to prevent recreation on every render cycle
  private readonly avatarMod =
    getAvatarImageModifier(SizeToken.SIZE_NUM_40, SizeToken.SIZE_NUM_40, CornerRadiusToken.CORNER_RADIUS_20);
  private readonly weatherMod =
    getAvatarImageModifier(SizeToken.SIZE_NUM_48, SizeToken.SIZE_NUM_48, CornerRadiusToken.CORNER_RADIUS_12);
  private readonly sceneryMod =
    getAvatarImageModifier(SizeToken.SIZE_NUM_86, SizeToken.SIZE_NUM_48, CornerRadiusToken.CORNER_RADIUS_8);
  private readonly rowMod72 = new CardWrapperModifier(SizeToken.SIZE_NUM_72);
  private readonly rowMod80 = new CardWrapperModifier(SizeToken.SIZE_NUM_80);
  private readonly hdsListItemMod80 = getHdsListItemModifier(SizeToken.SIZE_NUM_80);

  aboutToAppear() {
    this.dataArr.length = 0;
    for (let i = 0; i < 1; i++) {
      this.dataArr.push(i + '');
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.content_type_horizontally_swipe_interactive_list_label'))
      List({ space: SpaceToken.SPACE_12 }) {
        ListItem() {
          Row() {
            HdsListItemCard({
              prefixItem: new PrefixImage({
                image: $r('app.media.avatar3'),
                modifier: this.avatarMod
              }),
              textItem: {
                primaryText: { text: $r('app.string.avatar_and_double_line_text_label') },
                secondaryText: { text: $r('app.string.auxiliary_text_label') }
              },
              suffixItem: new SuffixArrowIconText({ endArrow: {} }),
              cardPrefixMargin: CommonConstants.INTEGER_0,
              cardSuffixMargin: CommonConstants.INTEGER_0,
              cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            })
          }
          .attributeModifier(this.rowMod72)
        }

        ListItem() {
          Row() {
            HdsListItemCard({
              prefixItem: new PrefixImage({
                image: $r('app.media.weather'),
                modifier: this.weatherMod
              }),
              textItem: {
                primaryText: { text: $r('app.string.icon_and_small_button_label') },
                secondaryText: { text: $r('app.string.auxiliary_text_label') }
              },
              suffixItem: new SuffixButton({
                text: $r('app.string.small_button_label'),
                onClick: () => {
                  CommonUtils.showToast($r('app.string.small_sized_button_toast_label'));
                }
              }),
              cardPrefixMargin: CommonConstants.INTEGER_0,
              cardSuffixMargin: CommonConstants.INTEGER_0,
              cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            })
          }
          .attributeModifier(this.rowMod80)
        }

        Repeat(this.dataArr)
          .each(() => {
            HdsListItem({
              hdsListItemCard: {
                prefixItem: new PrefixImage({
                  image: $r('app.media.scenery2'),
                  modifier: this.sceneryMod
                }),
                textItem: {
                  primaryText: { text: $r('app.string.sixteen_by_nine_illustration_label') },
                  secondaryText: { text: $r('app.string.auxiliary_text_label') }
                },
                cardPrefixMargin: CommonConstants.INTEGER_0,
                cardSuffixMargin: CommonConstants.INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              },
              swipeActionOptions: {
                icons: [
                  {
                    icon: new SymbolGlyphModifier($r('sys.symbol.share')).fontColor([Color.White])
                      .fontSize($r('sys.float.Body_L')),
                    backgroundColor: $r('sys.color.confirm'),
                    onAction: () => {
                      CommonUtils.showToast($r('app.string.share_button_toast_label'));
                    }
                  }
                ],
                deleteIconOptions: {
                  backgroundColor: Color.Red,
                  iconColor: Color.White,
                  onAction: () => {
                    CommonUtils.showToast($r('app.string.delete_button_toast_label'));
                    this.dataArr.splice(this.dataArr.length - 1, 1);
                    this.listHeight = this.listHeight - 92;
                  }
                },
                fullDeleteOptions: {
                  // Swipe distance exceeding the size of the swiped component automatically triggers deletion.
                  // Default is false.
                  isFullDelete: true,
                  onFullDeleteAction: () => {
                    this.getUIContext()?.animateTo({
                      duration: CommonConstants.DURATION_350,
                    }, () => {
                      this.dataArr.splice(this.dataArr.length - 1, 1);
                      this.listHeight = this.listHeight - 92;
                    });
                  }
                }
              },
              listItemModifier: this.hdsListItemMod80
            })
          })
          // Key generation mapped explicitly to the data elements.
          .key((item: string) => item)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(this.listHeight)
    }
  }
}