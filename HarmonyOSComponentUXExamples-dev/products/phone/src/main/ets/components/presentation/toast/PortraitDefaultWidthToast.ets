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
import { LengthMetrics, PromptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Logger } from 'componentuxexamplesbase';
import { BreakpointModel, CommonConstants, HdsUtil, PaddingToken } from 'componentuxexamplesbase';
import { HdsNavDestination } from '@kit.UIDesignKit';

const TAG = 'PortraitDefaultWidthToast';

@Builder
export function PortraitDefaultWidthToastBuilder() {
  PortraitDefaultWidthToast();
}

@ComponentV2
struct PortraitDefaultWidthToast {
  @Local toastId: number = -1;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private promptAction: PromptAction | undefined = undefined;

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
    this.promptAction.openToast({
      message: 'A'.repeat(13),
      duration: CommonConstants.DURATION_3000
    }).then((toastId: number) => {
      this.toastId = toastId;
    }).catch((err: BusinessError) => {
      Logger.error(TAG,
        `Failed to open the toast dialog, error code is ${err.code}, message is ${err.message}`);
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
  }

  build() {
    HdsNavDestination() {
    }
    .titleBar({
      content: {
        title: {
          mainTitle: $r('app.string.toast_label'),
          subTitle: $r('app.string.default_width_in_portrait_mode_label')
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
}