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
import { display, LengthMetrics, PromptAction, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { BreakpointModel, CommonConstants, HdsUtil, Logger, PaddingToken, WindowUtil } from 'componentuxexamplesbase';
import { HdsNavDestination } from '@kit.UIDesignKit';

const TAG = 'LandscapeDefaultWidthToast';

@Builder
export function LandscapeDefaultWidthToastBuilder() {
  LandscapeDefaultWidthToast()
}

@ComponentV2
struct LandscapeDefaultWidthToast {
  @Local toastId: number = -1;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private promptAction: PromptAction | undefined = undefined;
  private winUtil: WindowUtil = WindowUtil.getInstance();

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  aboutToAppear(): void {
    this.promptAction = this.getUIContext().getPromptAction();
    try {
      display.on('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      Logger.error(TAG,
        `Failed to register the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
    if (this.breakpointModel.isSmallScreen()) {
      this.winUtil.setMainWindowOrientation(window.Orientation.LANDSCAPE);
    }
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    this.promptAction?.openToast({
      message: 'A'.repeat(13),
      duration: CommonConstants.DURATION_3000
    }).then((toastId: number) => {
      this.toastId = toastId;
    }).catch((err: BusinessError) => {
      Logger.error(TAG,
        `Failed to open the toast dialog, error info:${JSON.stringify(err)}`);
    })
  }

  aboutToDisappear(): void {
    try {
      if (this.toastId !== -1) {
        this.promptAction?.closeToast(this.toastId);
        this.toastId = -1;
      }
    } catch (err) {
      Logger.error(TAG,
        `Failed to close the toast dialog, error info:${JSON.stringify(err)}`)
    }
    this.promptAction = undefined;
    this.winUtil.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
    try {
      display.off('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      Logger.error(TAG,
        `Failed to unregister the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
  }

  build() {
    HdsNavDestination() {
    }
    .titleBar({
      content: {
        title: {
          mainTitle: $r('app.string.toast_label'),
          subTitle: $r('app.string.default_width_in_landscape_mode_label')
        }
      },
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle()
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }

  private foldStatusChangeCallback: Callback<display.FoldStatus> = (status: display.FoldStatus) => {
    const curOrientation = this.winUtil.getMainWindowOrientation();
    switch (status) {
      case display.FoldStatus.FOLD_STATUS_FOLDED:
        // Device is in folded state (single-screen / F mode)
        if (curOrientation != undefined && curOrientation != window.Orientation.LANDSCAPE) {
          this.winUtil.setMainWindowOrientation(window.Orientation.LANDSCAPE);
        }
        break;
      default:
        if (curOrientation != undefined && curOrientation != window.Orientation.FOLLOW_DESKTOP) {
          this.winUtil.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
        }
        break;
    }
  };
}