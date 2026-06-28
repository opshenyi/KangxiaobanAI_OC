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

import { HdsListItemCard, PrefixImage, SuffixButton, SuffixTextAndArrow } from '@kit.UIDesignKit';
import { ImageModifier } from '@kit.ArkUI';
import { CommonUtils, CornerRadiusToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function ContentList() {
  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixImage({
        image: $r('app.media.avatar3'),
        modifier: new ImageModifier()
          .width(SizeToken.SIZE_NUM_54)
          .height(SizeToken.SIZE_NUM_54)
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.icon_and_text_label')
        }
      },
      suffixItem: new SuffixTextAndArrow({
        text: $r('app.string.list_right_text_label')
      }, {})
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.double_line_text_and_button')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        }
      },
      suffixItem: new SuffixButton({
        text: $r('app.string.small_button_label'),
        onClick: () => {
          CommonUtils.showToast($r('app.string.small_sized_button_toast_label'));
        }
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixImage({
        image: $r('app.media.scenery3'),
        modifier: new ImageModifier()
          .width(SizeToken.SIZE_NUM_64)
          .height(SizeToken.SIZE_NUM_64)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.image_with_two_line_text_label')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        }
      },
      suffixItem: new SuffixTextAndArrow({
        text: $r('app.string.list_right_text_label')
      }, {})
    })
  }
}