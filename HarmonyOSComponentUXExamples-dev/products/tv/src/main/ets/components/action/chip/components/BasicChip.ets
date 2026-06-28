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
import { CommonUtils, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { Chip, ChipSize } from '@ohos.arkui.advanced.Chip';

@Builder
export function BasicChip() {
  Column() {
    Row({ space: SpaceToken.SPACE_16 }) {
      Chip({
        label: {
          text: 'Chips',
        },
        size: ChipSize.NORMAL,
        allowClose: false,
        enabled: true,
        backgroundColor: $r('sys.color.comp_background_tertiary'),
        onClose: () => {
          CommonUtils.showToast('Chip onClose');
        },
        onClicked: () => {
          CommonUtils.showToast('Chip onClicked');
        }
      })

      Chip({
        label: {
          text: 'Chips',
        },
        size: ChipSize.NORMAL,
        allowClose: true,
        enabled: true,
        backgroundColor: $r('sys.color.comp_background_tertiary'),
        onClose: () => {
          CommonUtils.showToast('Chip onClose');
        },
        onClicked: () => {
          CommonUtils.showToast('Chip onClicked');
        }
      })

      Chip({
        // Set the prefix icon property
        prefixSymbol: {
          normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
            .fontSize(SizeToken.SIZE_NUM_22)
            .fontColor([$r('sys.color.icon_primary')]),
        },
        // Set text properties
        label: {
          text: 'Chips'
        },
        size: ChipSize.NORMAL,
        backgroundColor: $r('sys.color.comp_background_tertiary'),
        allowClose: false,
        enabled: true,
        onClose: () => {
          CommonUtils.showToast('Chip onClose');
        }
      })

      Chip({
        prefixSymbol: {
          normal: new SymbolGlyphModifier($r('sys.symbol.ohos_star'))
            .fontSize(SizeToken.SIZE_NUM_22)
            .fontColor([$r('sys.color.icon_primary')]),
        },
        label: {
          text: 'Chips'
        },
        size: {
          width: 160
        },
        allowClose: true,
        enabled: true,
        backgroundColor: $r('sys.color.comp_background_tertiary'),
        onClose: () => {
          CommonUtils.showToast('Chip onClose');
        },
        onClicked: () => {
          CommonUtils.showToast('Chip onClicked');
        }
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('app.color.item_background_color'))
    .borderWidth(SizeToken.SIZE_NUM_1)
    .borderColor($r('app.color.item_border_color'))
    .padding(PaddingToken.PADDING_16VP)
  }
}