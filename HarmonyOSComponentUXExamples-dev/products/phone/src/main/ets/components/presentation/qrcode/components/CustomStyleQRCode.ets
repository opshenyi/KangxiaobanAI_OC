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
export struct CustomStyleQRCode {
  // The content payload to be encoded within the QR code
  @Local value: string = 'Hello HarmonyOS, I\'m excited to explore your smooth and connected features.';

  build() {
    Column() {
      SubTitleView($r('app.string.custom_effect_label'))

      Row() {
        Stack() {
          QRCode(this.value)
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_PERCENT_100)
            .color($r('sys.color.comp_common_contrary'))
            .backgroundColor(Color.Transparent)
        }
        .width(SizeToken.SIZE_NUM_180)
        .height(SizeToken.SIZE_NUM_180)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
        .padding(PaddingToken.PADDING_12_point_75VP)
        .backgroundColor($r('app.color.qrcode_background_neutral'))
      }
      .justifyContent(FlexAlign.Center)
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        top: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })

      Row() {
        // Outer Stack: Serves as the base layer for the linear gradient
        Stack() {
          // Inner Stack: Serves as the overlay layer for the radial gradient
          Stack() {
            // QR Code component with white foreground and transparent background
            QRCode(this.value)
              .width(SizeToken.SIZE_PERCENT_100)
              .height(SizeToken.SIZE_PERCENT_100)
              .color(Color.White)
              .backgroundColor(Color.Transparent)
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
          .padding(PaddingToken.PADDING_12_point_75VP)
          // Apply the radial gradient on the inner layer
          .radialGradient({
            // Positioning the center at the left edge ('0%') to create a "left-to-right" radial sweep
            center: ['0%', '50%'],
            radius: '80%',
            colors: [
              ['#FFD9B580', 0.0], // Starting color requested
              ['#00D9B580', 1.0]
            ]
          })
        }
        .width(SizeToken.SIZE_NUM_180)
        .height(SizeToken.SIZE_NUM_180)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
        .clip(true) // Crucial: Ensures the inner Stack respects the outer container's rounded corners
        // Apply the base multi-color linear gradient on the outer layer
        .linearGradient({
          direction: GradientDirection.LeftBottom, // Gradient flows from top-right to bottom-left
          colors: [
            ['#89A6DF', 0.0],
            ['#3EADE2', 0.11],
            ['#C5A7D4', 0.84],
            ['#EBC7D9', 1.0]
          ]
        })
      }
      .justifyContent(FlexAlign.Center)
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        top: PaddingToken.PADDING_12VP,
        bottom: PaddingToken.PADDING_12VP
      })
    }
  }
}