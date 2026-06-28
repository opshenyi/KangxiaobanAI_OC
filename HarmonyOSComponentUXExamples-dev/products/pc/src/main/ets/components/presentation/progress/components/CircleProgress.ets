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
import {
  CommonConstants,
  CommonUtils,
  CornerRadiusToken,
  CryptoUtil,
  Logger,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';

// Defines the download state enumeration
enum DownloadState {
  IDLE, // Not started
  DOWNLOADING, // Downloading
  PAUSED, // Paused
  FINISHED // Completed
}

const TAG = 'CircleProgress';

@ComponentV2
export struct CircleProgress {
  // Current progress value
  @Local progressValue: number = 0;
  // Current download state
  @Local currentState: DownloadState = DownloadState.IDLE;
  // Overall size of the shape (in pixels)
  @Local shapeSize: number = 0;
  // Radius of the rounded corners (in pixels)
  @Local cornerRadius: number = 40;
  // Radius of the central hollow circle (in pixels)
  @Local hollowCircleRadius: number = 50;
  // Cached SVG path to avoid recalculating it on every frame render
  @Local cachedHollowSquarePath: string = '';
  // Timer ID
  private timerId: number = -1;
  // Total progress bar value
  private total: number = 100;
  // Enterprise Optimization: Lifecycle flag to prevent memory leaks and state updates on destroyed components
  private isComponentDestroyed: boolean = false;

  aboutToAppear(): void {
    this.isComponentDestroyed = false;
    const ctx = this.getUIContext();
    this.shapeSize = ctx.vp2px(48);
    this.cornerRadius = ctx.vp2px(12);
    this.hollowCircleRadius = ctx.vp2px(20);

    // Cache the path string once during initialization to save performance during rapid rendering
    this.cachedHollowSquarePath = this.getHollowSquarePathStr();
  }

  // Cleans up resources when the component is about to be destroyed
  aboutToDisappear() {
    // Mark the component as destroyed immediately
    this.isComponentDestroyed = true;
    this.clearTimer();
  }

  // Helper method to clear the timer
  clearTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  // Handles icon click event
  handleIconClick() {
    switch (this.currentState) {
      case DownloadState.IDLE:
      case DownloadState.PAUSED:
        // If idle or paused -> start/resume download
        this.startOrResumeDownload();
        break;
      case DownloadState.DOWNLOADING:
        // If currently downloading -> pause
        this.pauseDownload();
        break;
      case DownloadState.FINISHED:
        // Completed, here we demonstrate reset logic for easy repeated testing
        this.currentState = DownloadState.IDLE;
        this.progressValue = 0;
        break;
      default:
        this.currentState = DownloadState.IDLE;
        this.progressValue = 0;
        break;
    }
  }

  // Starts or resumes the download
  startOrResumeDownload() {
    this.currentState = DownloadState.DOWNLOADING;
    let increment: number = 0;

    this.timerId = setInterval(() => {
      // Guard clause to prevent execution if the component is unmounted
      // This stops the pending event loop callback from modifying destroyed state variables
      if (this.isComponentDestroyed) {
        this.clearTimer();
        return;
      }

      if (this.progressValue >= this.total) {
        this.finishDownload();
      } else {
        // Simulate network fluctuations with 2%-5% progress increments
        try {
          increment = CryptoUtil.generateRangeRandomSync(0, 3) + 2;
        } catch (error) {
          const err: BusinessError = error as BusinessError;
          Logger.error(TAG, `generateRangeRandomSync error: ${err.code}, ${err.message}.`);
        }
        this.progressValue = Math.min(this.progressValue + increment, this.total);
      }
    }, CommonConstants.DURATION_100); // Update every 100ms
  }

  // Pauses the download
  pauseDownload() {
    this.currentState = DownloadState.PAUSED;
    this.clearTimer();
  }

  // Finishes the download
  finishDownload() {
    this.progressValue = this.total;
    this.currentState = DownloadState.FINISHED;
    this.clearTimer();
    // Shows a toast notification
    CommonUtils.showToast($r('app.string.download_complete_notification_label'));
  }

  build() {
    Column() {
      SubTitleView($r('app.string.circle_progress_bar_label'))

      Row() {
        Stack({ alignContent: Alignment.Center }) {

          // Layer 1: App icon (background image)
          // Using a simple rectangle or image to simulate an app icon here
          Image($r('app.media.weather')) // Replace with your actual icon resource, or use the color block below instead
            .width(SizeToken.SIZE_NUM_48)
            .height(SizeToken.SIZE_NUM_48)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
            .clip(true)
            .objectFit(ImageFit.Cover)

          // Layer 2: UI mask layer
          if (this.currentState === DownloadState.IDLE) {
            Rect({ width: SizeToken.SIZE_NUM_48, height: SizeToken.SIZE_NUM_48 })
              .radiusWidth(CornerRadiusToken.CORNER_RADIUS_12)
              .fill($r('sys.color.icon_secondary'))
          }

          // Layer 3: Eclipse circular progress bar (overlay layer)
          // Displayed only when downloading or paused
          if (this.currentState === DownloadState.DOWNLOADING ||
            this.currentState === DownloadState.PAUSED) {
            Path()
            // Use the cached path instead of recalculating 10 times a second
              .commands(this.cachedHollowSquarePath)
              .fill($r('sys.color.icon_secondary'))
              .strokeWidth(CommonConstants.INTEGER_0)
              .width(this.shapeSize + 'px')
              .height(this.shapeSize + 'px')

            Progress({ value: this.total - this.progressValue, total: this.total, type: ProgressType.Eclipse })
              .width(SizeToken.SIZE_NUM_40)
              .height(SizeToken.SIZE_NUM_40)
              .color($r('sys.color.icon_secondary'))
              .style({
                strokeWidth: CommonConstants.INTEGER_0,
                enableSmoothEffect: this.progressValue === 0 ? false : true
              }) // Typically no border is needed for Eclipse style
              .clip(true) // Clips overflow
              .rotate({
                y: CommonConstants.INTEGER_1,
                angle: CommonConstants.INTEGER_180
              }) // Key logic: Mirror/flip the component
          }

          // Layer 4: Pause icon
          // Displayed only in paused state
          if (this.currentState === DownloadState.PAUSED) {
            SymbolGlyph($r('sys.symbol.pause'))
              .fontSize($r('sys.float.Subtitle_M'))
              .fontColor([$r('sys.color.icon_secondary')])
          }
        }
        .onClick(() => {
          this.handleIconClick();
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

  /**
   * Helper method: Generates an SVG path string
   * Note: This is now only called once during initialization to optimize rendering performance.
   * @returns an SVG path
   */
  private getHollowSquarePathStr(): string {
    const s = this.shapeSize;
    const cr = this.cornerRadius;
    const hr = this.hollowCircleRadius;
    const center = s / 2;

    // --- First part: Outer rounded square (drawn clockwise) ---
    // M: Move to (move to start point)
    // H: Horizontal line (horizontal line)
    // V: Vertical line (vertical line)
    // Q: Quadratic Bezier curve (quadratic Bezier curve for rounding corners)
    // -> Q control point x control point y end point x end point y
    // Z: Close path (close path)
    let outerPath = `M ${cr} 0 ` + // 1. Start from the top starting point (x=corner radius, y=0)
      `H ${s - cr} ` + // 2. Draw a horizontal line to the right
      `Q ${s} 0 ${s} ${cr} ` + // 3. Draw the top-right corner arc
      `V ${s - cr} ` + // 4. Draw a vertical line downwards
      `Q ${s} ${s} ${s - cr} ${s} ` + // 5. Draw the bottom-right corner arc
      `H ${cr} ` + // 6. Draw a horizontal line to the left
      `Q 0 ${s} 0 ${s - cr} ` + // 7. Draw the bottom-left corner arc
      `V ${cr} ` + // 8. Draw a vertical line upwards
      `Q 0 0 ${cr} 0 ` + // 9. Draw the top-left corner arc back to the start point
      `Z `; // 10. Close the outer shape

    // --- Second part: Inner hollow circle (must be drawn counterclockwise to create a hole) ---
    // We use the 'A' (Arc) command to draw the circle
    // A rx ry x-axis-rotation large-arc-flag sweep-flag x y
    // The key is the sweep-flag: 1 for clockwise and 0 for counterclockwise. Here it's set to 0.
    // We draw the circle in two parts (two half circles)
    let innerPath = `M ${center} ${center - hr} ` + // Move to the topmost point of the circle
      // Draw the left half circle (counterclockwise to the bottom of the circle)
      `A ${hr} ${hr} 0 0 0 ${center} ${center + hr} ` +
      // Draw the right half circle (counterclockwise back to the top of the circle)
      `A ${hr} ${hr} 0 0 0 ${center} ${center - hr} ` +
      `Z`; // Close the inner shape

    // Combine both paths
    return outerPath + innerPath;
  }
}