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
import { CornerRadiusToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct ImageStyleQRCode {
  @Local value: string = 'Hello HarmonyOS, I\'m excited to explore your smooth and connected features.';

  build() {
    Column() {
      SubTitleView($r('app.string.avatar_image_style_qrcode_label'))

      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)

        Image($r('app.media.avatar1'))
          .width(SizeToken.SIZE_NUM_40)
          .height(SizeToken.SIZE_NUM_40)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
          .borderWidth(SizeToken.SIZE_NUM_1)
          .borderColor(Color.White)
      }
      .width(SizeToken.SIZE_NUM_180)
      .height(SizeToken.SIZE_NUM_180)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      SubTitleView($r('app.string.app_icon_image_style_qrcode_label'))

      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)

        Image($r('app.media.weather'))
          .width(SizeToken.SIZE_NUM_40)
          .height(SizeToken.SIZE_NUM_40)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_14)
          .borderWidth(SizeToken.SIZE_NUM_1)
          .borderColor(Color.White)
      }
      .width(SizeToken.SIZE_NUM_180)
      .height(SizeToken.SIZE_NUM_180)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)
    }
  }
}