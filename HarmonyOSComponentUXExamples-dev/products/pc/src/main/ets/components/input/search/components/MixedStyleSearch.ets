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
import { Logger } from 'componentuxexamplesbase';
import {
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';

const TAG = 'MixedStyleSearch';

@Builder
export function MixedStyleSearch() {
  Column() {
    // Style 1: Search bar + right-side icon
    SubTitleView($r('app.string.search_box_and_icon_label'))
    Row({ space: SpaceToken.SPACE_8 }) {
      SearchInput()
      TrailingButton()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .searchRowStyle()

    // Style 2: Left-side icon + search bar
    SubTitleView($r('app.string.icon_and_search_box_label'))
    Row({ space: SpaceToken.SPACE_8 }) {
      LeadingButton()
      SearchInput()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .searchRowStyle()

    // Style 3: Left-side icon + search bar + right-side icon
    SubTitleView($r('app.string.icon_and_search_box_and_icon_label'))
    Row({ space: SpaceToken.SPACE_8 }) {
      LeadingButton()
      SearchInput()
      TrailingButton()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .searchRowStyle()


    // Style 4: Dropdown select + search bar
    SubTitleView($r('app.string.select_and_search_box_label'))
    Row({ space: SpaceToken.SPACE_8 }) {
      CategorySelect()
      SearchInput()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .searchRowStyle()

    // Style 5: Dropdown select + search bar + right-side icon
    SubTitleView($r('app.string.select_and_search_box_and_icon_label'))
    Row({ space: SpaceToken.SPACE_8 }) {
      CategorySelect()
      SearchInput()
      TrailingButton()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .searchRowStyle()
  }
  .width(SizeToken.SIZE_PERCENT_100)
}

// Extract common Row styles
@Extend(Row)
function searchRowStyle() {
  .width(SizeToken.SIZE_PERCENT_100)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('sys.color.comp_background_list_card'))
  .padding(PaddingToken.PADDING_12VP)
}

// Extract reusable Search input component
@Builder
function SearchInput() {
  Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_40)
    .backgroundColor($r('sys.color.comp_background_tertiary'))
    .placeholderColor($r('sys.color.font_secondary'))
    .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
    .textFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
    .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
    .onSubmit((value: string) => {
      Logger.info(TAG, `The search keyword length: ${value.length}`);
    })
    .onChange(() => {
      Logger.info(TAG, `The search keyword is changed.`);
    })
    .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
}

// Extract common left icon button (Chevron Left)
@Builder
function LeadingButton() {
  Button({ type: ButtonType.Circle, stateEffect: true }) {
    SymbolGlyph($r('sys.symbol.chevron_left'))
      .fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_primary')])
  }
  .width(SizeToken.SIZE_NUM_40)
  .height(SizeToken.SIZE_NUM_40)
  .backgroundColor(Color.Transparent)
}

// Extract common right icon button (Scan / Dot Grid)
@Builder
function TrailingButton() {
  Button({ type: ButtonType.Circle, stateEffect: true }) {
    SymbolGlyph($r('sys.symbol.dot_grid_2x2'))
      .fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_primary')])
  }
  .width(SizeToken.SIZE_NUM_40)
  .height(SizeToken.SIZE_NUM_40)
  .backgroundColor(Color.Transparent)
}

// Extract common Select dropdown
@Builder
function CategorySelect() {
  Select([
    { value: 'aaa', icon: $r('sys.media.ohos_app_icon') },
    { value: 'bbb', icon: $r('sys.media.ohos_app_icon') },
    { value: 'ccc', icon: $r('sys.media.ohos_app_icon') },
    { value: 'ddd', icon: $r('sys.media.ohos_app_icon') }
  ])
    .value($r('app.string.search_placeholder_label'))
    .dividerStyle({
      strokeWidth: LengthMetrics.vp(0),
      color: Color.Transparent
    })
    .avoidance(AvoidanceMode.COVER_TARGET)
}