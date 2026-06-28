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

import { LengthMetrics } from '@ohos.arkui.node';
import {
  CommonUtils,
  CornerRadiusToken,
  CryptoUtil,
  Logger,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';

const TAG = 'CapsuleProgress';

@ComponentV2
export struct CapsuleProgress {
  // Current progress value
  @Local progressValue: number = 0;
  // Flag indicating whether a download is in progress
  @Local isDownloading: boolean = false;
  // Button display text (optional, for extending states like "Open" or "Installed")
  @Local btnText: ResourceStr = $r('app.string.install_app_label');
  // Timer ID
  private intervalId: number = -1;
  // Total progress bar value
  private total: number = 100;

  // Clean up timer when component is destroyed
  aboutToDisappear() {
    this.clearDownloadTimer();
  }

  build() {
    Column() {
      SubTitleView($r('app.string.capsule_shaped_progress_bar_label'))

      Row() {
        Row({ space: SpaceToken.SPACE_16 }) {
          Image($r('app.media.weather'))
            .width(SizeToken.SIZE_NUM_48)
            .height(SizeToken.SIZE_NUM_48)
          Text('APP')
            .fontSize($r('sys.float.Subtitle_M'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)

        Stack() {
          if (!this.isDownloading) {
            Button(this.btnText)
              .buttonStyle(ButtonStyleMode.NORMAL)
              .width(SizeToken.SIZE_NUM_72)
              .height(SizeToken.SIZE_NUM_28)
              .fontSize($r('sys.float.Subtitle_S'))
              .onClick(() => {
                if (CommonUtils.resourceStrEquals(this.btnText, $r('app.string.install_app_label'))) {
                  this.startDownload();
                }
              })
          } else {
            Progress({ value: this.progressValue, total: this.total, type: ProgressType.Capsule })
              .width(SizeToken.SIZE_NUM_72)
              .height(SizeToken.SIZE_NUM_28)
              .style({
                borderColor: $r('app.color.capsule_progress_border_color'),
                borderWidth: SizeToken.SIZE_NUM_1,
                borderRadius: LengthMetrics.vp(8),
                font: {
                  size: $r('sys.float.Body_M'),
                  weight: FontWeight.Medium
                },
                fontColor: $r('sys.color.font_primary'),
                enableScanEffect: false,
                showDefaultPercentage: true
              })
          }
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding(PaddingToken.PADDING_12VP)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  // Helper method to clear download timer
  private clearDownloadTimer() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
  }

  // Start simulated download
  private startDownload() {
    this.clearDownloadTimer();
    this.isDownloading = true;
    this.progressValue = 0;
    let increment: number = 0;
    this.intervalId = setInterval(() => {
      // Simulate network fluctuations with 2%-5% progress increments
      try {
        increment = CryptoUtil.generateRangeRandomSync(0, 3) + 2;
      } catch (error) {
        const err: BusinessError = error as BusinessError;
        Logger.error(TAG, `generateRangeRandomSync error: ${err.code}, ${err.message}.`);
      }
      this.progressValue = Math.min(this.progressValue + increment, this.total);

      // Download completion logic
      if (this.progressValue >= this.total) {
        this.progressValue = this.total;
        this.btnText = $r('app.string.open_label');
        this.isDownloading = false;
        this.clearDownloadTimer();
        CommonUtils.showToast($r('app.string.installation_successful_label'));
      }
    }, 100); // Update every 100ms
  }
}