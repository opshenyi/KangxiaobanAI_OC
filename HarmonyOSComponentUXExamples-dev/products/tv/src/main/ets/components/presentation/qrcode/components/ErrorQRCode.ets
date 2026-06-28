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

import { CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function ErrorQRCode(value: string) {
  Stack() {
    QRCode(value)
      .width($r('app.float.qrcode_size'))
      .height($r('app.float.qrcode_size'))
      .backgroundColor($r('sys.color.comp_focused_primary'))

    // Add Mask
    Stack()
      .height(SizeToken.SIZE_PERCENT_100)
      .width(SizeToken.SIZE_PERCENT_100)
      .backgroundColor($r('sys.color.mask_primary'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)

    Column({ space: PaddingToken.PADDING_12VP }) {
      SymbolGlyph($r('sys.symbol.arrow_clockwise'))
        .fontColor([$r('sys.color.icon_primary')])
        .fontSize(SizeToken.SIZE_NUM_54)
      Text($r('app.string.qrcode_error_tips_label'))
        .fontColor($r('sys.color.font_primary'))
    }
  }
  .height($r('app.float.qrcode_card_size'))
  .width($r('app.float.qrcode_card_size'))
  .alignContent(Alignment.Center)
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .backgroundColor($r('sys.color.comp_focused_primary'))
}