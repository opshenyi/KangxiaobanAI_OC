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

import { CommonConstants, CornerRadiusToken, Logger, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../../common/ListGroupTitle';

const TAG = 'StandardSearch';

@Builder
export function StandardSearch() {
  Column() {
    ListGroupTitle($r('app.string.standard_search_label'))
    Column({ space: SpaceToken.SPACE_16 }) {
      Search({ placeholder: $r('app.string.search_label') })
        .width(SizeToken.SIZE_PERCENT_100)
        .height($r('app.float.item_height'))
        .backgroundColor($r('app.color.item_background_color'))
        .placeholderColor($r('sys.color.font_secondary'))
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        // Set clear button
        .cancelButton({
          style: CancelButtonStyle.INPUT,
          icon: {
            src: $r('sys.media.ohos_ic_public_cancel_filled')
          }
        })
        .placeholderFont({
          size: $r('app.float.list_item_text_size'),
          weight: FontWeight.Regular
        })
        .textFont({
          size: $r('app.float.list_item_text_size'),
          weight: FontWeight.Regular
        })
        .onSubmit((value: string) => {
          Logger.info(TAG, `The search keyword currently submitted in the search box is: ${value}`);
        })
        .onChange((value: string) => {
          Logger.info(TAG, `The text content officially displayed in the search box is: ${value}`);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(CommonConstants.FLOAT_1)
    .borderColor($r('app.color.item_border_color'))
    .padding($r('sys.float.padding_level8'))
  }
  .width(SizeToken.SIZE_PERCENT_100)
}