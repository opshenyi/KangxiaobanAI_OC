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
import { ImageModifier, ListItemModifier } from '@kit.ArkUI';
import { CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

/**
 * Common modifier for Card Wrappers (Row/Column)
 * Encapsulates background, border radius, padding, width, and dynamic height.
 */
export class CardWrapperModifier implements AttributeModifier<RowAttribute> {
  private itemHeight: Length;
  private lrPadding: Length;

  constructor(itemHeight: Length, lrPadding: Length = PaddingToken.PADDING_6VP) {
    this.itemHeight = itemHeight;
    this.lrPadding = lrPadding;
  }

  applyNormalAttribute(instance: RowAttribute): void {
    instance.width(SizeToken.SIZE_PERCENT_100)
      .height(this.itemHeight)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .padding({ left: this.lrPadding, right: this.lrPadding })
      .backgroundColor($r('sys.color.comp_background_list_card'));
  }
}

/**
 * Basic modifier for a full-width Row with a specific height.
 */
export class FullWidthRowModifier implements AttributeModifier<RowAttribute> {
  private itemHeight: Length;

  constructor(itemHeight: Length) {
    this.itemHeight = itemHeight;
  }

  applyNormalAttribute(instance: RowAttribute): void {
    instance.width(SizeToken.SIZE_PERCENT_100)
      .height(this.itemHeight);
  }
}

/**
 * Modifier for ListItemGroup containers in efficient lists.
 */
export class ListItemGroupModifier implements AttributeModifier<ListItemGroupAttribute> {
  private lrPadding: Length;

  constructor(lrPadding: Length = PaddingToken.PADDING_12VP) {
    this.lrPadding = lrPadding;
  }

  applyNormalAttribute(instance: ListItemGroupAttribute): void {
    instance.borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .padding({ left: this.lrPadding, right: this.lrPadding })
      .backgroundColor($r('sys.color.comp_background_list_card'));
  }
}

/**
 * Helper to create and cache standard ImageModifiers.
 */
export function getAvatarImageModifier(width: Length, height: Length, radius: Length): ImageModifier {
  return new ImageModifier()
    .width(width)
    .height(height)
    .borderRadius(radius);
}

/**
 * Helper to create standard ListItemModifiers for HdsListItem.
 */
export function getHdsListItemModifier(itemHeight: Length): ListItemModifier {
  return new ListItemModifier()
    .width(SizeToken.SIZE_PERCENT_100)
    .height(itemHeight)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .padding({
      left: PaddingToken.PADDING_6VP,
      right: PaddingToken.PADDING_6VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'));
}

/**
 * Reusable Divider Style Options for consistent UI configuration.
 */
export class DividerConstants {
  public static readonly FULL_WIDTH: ListDividerOptions = {
    strokeWidth: SizeToken.SIZE_NUM_1,
    color: $r('sys.color.comp_background_tertiary')
  };
  public static readonly PADDING_6: ListDividerOptions = {
    strokeWidth: SizeToken.SIZE_NUM_1,
    startMargin: PaddingToken.PADDING_6VP,
    endMargin: PaddingToken.PADDING_6VP,
    color: $r('sys.color.comp_background_tertiary')
  };
  public static readonly PADDING_40_6: ListDividerOptions = {
    strokeWidth: SizeToken.SIZE_NUM_1,
    startMargin: PaddingToken.PADDING_40VP,
    endMargin: PaddingToken.PADDING_6VP,
    color: $r('sys.color.comp_background_tertiary')
  };
}