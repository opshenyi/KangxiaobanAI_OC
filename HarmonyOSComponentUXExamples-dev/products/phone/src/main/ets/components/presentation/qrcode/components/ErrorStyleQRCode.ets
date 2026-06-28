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
import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct ErrorStyleQRCode {
  // Tracks whether the QR code is currently expired
  @Local isExpired: boolean = true;
  // Dynamic value to simulate a real token refresh
  @Local qrValue: string = 'Hello HarmonyOS, I\'m excited to explore your smooth and connected features.';
  // Used to store the timeout ID to prevent memory leaks
  private timeoutId: number = -1;

  // Always clean up asynchronous tasks when the component is destroyed
  aboutToDisappear(): void {
    this.clearTimer();
  }

  build() {
    Column() {
      SubTitleView($r('app.string.error_status_label'))

      Stack({ alignContent: Alignment.Bottom }) {
        // QR Code Layer
        QRCode(this.qrValue)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
          // Dynamically adjust opacity based on the expiration state
          .contentOpacity(this.isExpired ? 0.1 : 1.0)
          // Add a subtle animation for a smooth visual transition
          .animation({ duration: CommonConstants.DURATION_300, curve: Curve.EaseInOut })

        // Error & Refresh Overlay Layer
        // Only render the overlay when the QR code is expired
        if (this.isExpired) {
          Column({ space: SpaceToken.SPACE_8_point_75VP }) {
            SymbolGlyph($r('sys.symbol.arrow_clockwise'))
              .fontSize($r('sys.float.Title_L'))

            Text($r('app.string.expiration_prompt_message_en_label'))
              .fontSize($r('sys.float.Body_L'))
              .fontColor('#e5000000')
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
          }
          .margin({ bottom: PaddingToken.PADDING_22_point_75VP })
          .transition(TransitionEffect.OPACITY)
          .onClick(() => {
            this.refreshQRCode();
          })
        }
      }
      .width(SizeToken.SIZE_NUM_180)
      .height(SizeToken.SIZE_NUM_180)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)
    }
  }

  /**
   * Safely clears the existing timer if one is running.
   */
  private clearTimer(): void {
    if (this.timeoutId !== -1) {
      clearTimeout(this.timeoutId);
      this.timeoutId = -1;
    }
  }

  /**
   * Handles the QR code refresh logic.
   * Resets the expiration state, updates the QR value, and triggers the 5-second countdown.
   */
  private refreshQRCode(): void {
    // Clear any existing timer to prevent overlapping countdowns
    this.clearTimer();

    // Update state to valid and generate a new QR code value
    this.isExpired = false;
    this.qrValue = `Hello HarmonyOS_${Date.now()}`;

    // Set a 5-second timer to expire the QR code again
    this.timeoutId = setTimeout(() => {
      this.isExpired = true;
    }, 5000);
  }
}