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
  HdsNavDestination,
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarOperationType,
  SnackBarStyleOptions
} from '@kit.UIDesignKit';
import { ColorMetrics, display, LengthMetrics, window } from '@kit.ArkUI';
import { BreakpointModel, CommonConstants, HdsUtil, Logger, PaddingToken, WindowUtil } from 'componentuxexamplesbase';

const TAG = 'LandscapeSnackBarExample';

@Builder
export function LandscapeSnackBarExampleBuilder() {
  LandscapeSnackBarExample()
}

@ComponentV2
struct LandscapeSnackBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private winUtil: WindowUtil = WindowUtil.getInstance();
  private hdsSnackBar: HdsSnackBar | null = null;
  private curTitleColor: ColorMetrics | undefined = undefined;
  private message: SnackBarMessageOptions = {};
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
  };
  private operation: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_CLOSE,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton2',
    onContentClick: () => {
      Logger.info(TAG, 'Content clicked.');
    }
  };
  private style: SnackBarStyleOptions = {
    duration: CommonConstants.DURATION_NEGATIVE_1
  };

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
    const uiContext: UIContext = this.getUIContext();
    this.hdsSnackBar = new HdsSnackBar(uiContext);
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    try {
      this.curTitleColor = ColorMetrics.resourceColor($r('sys.color.font_primary'));
    } catch (err) {
      Logger.error(TAG, 'Failed to instantiate the ColorMetrics class using ResourceColor');
    }
    this.message = {
      title: $r('app.string.residency_label'),
      titleColor: this.curTitleColor
    };
    try {
      display.on('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      Logger.error(TAG,
        `Failed to register the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
    if (this.breakpointModel.isSmallScreen()) {
      this.winUtil.setMainWindowOrientation(window.Orientation.LANDSCAPE);
    }
    this.hdsSnackBar?.show(this.icon, this.message, this.operation, this.style);
  }

  aboutToDisappear(): void {
    this.hdsSnackBar?.dismiss();
    this.hdsSnackBar = null;
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
          mainTitle: $r('app.string.snack_bar_in_landscape_mode_label')
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