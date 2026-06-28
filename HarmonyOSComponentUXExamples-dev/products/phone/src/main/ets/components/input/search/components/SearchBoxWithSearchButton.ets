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
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'SearchBoxWithSearchButton';

@Builder
export function SearchBoxWithSearchButton() {
  Column() {
    SubTitleView($r('app.string.search_box_with_search_button_label'))

    Row() {
      Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_40)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .textFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        .searchButton($r('app.string.search_button_label'), {
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_emphasize')
        })
        .searchIcon({
          src: $r('sys.media.ohos_ic_public_search_filled')
        })
        .cancelButton({
          style: CancelButtonStyle.CONSTANT,
          icon: new SymbolGlyphModifier($r('sys.symbol.mic')).fontSize($r('sys.float.Subtitle_M'))
            .fontColor([$r('sys.color.icon_secondary')])
        })
        .onSubmit((value: string) => {
          Logger.info(TAG,
            `The search keyword currently submitted in the search box is: ${value}`);
        })
        .onChange((value: string) => {
          Logger.info(TAG,
            `The text content officially displayed in the search box is: ${value}`);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PaddingToken.PADDING_12VP)
  }
  .width(SizeToken.SIZE_PERCENT_100)
}