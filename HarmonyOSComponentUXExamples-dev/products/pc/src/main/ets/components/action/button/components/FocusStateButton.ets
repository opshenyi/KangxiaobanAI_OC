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

import { LengthMetrics } from '@kit.ArkUI';
import { CommonUtils, Logger, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

const TAG = 'FocusStateButton';

@Extend(Button)
function commonBtnStyle(role: ButtonRole = ButtonRole.NORMAL) {
  .width(SizeToken.SIZE_NUM_120)
  .height(SizeToken.SIZE_NUM_40)
  .role(role)
  .focusable(true) // Ensure the component has focus capability enabled
  // Core configuration: Custom focus ring style for focus traversal
  .focusBox({
    // Outline offset 2vp from Button border
    margin: LengthMetrics.vp(PaddingToken.PADDING_2VP),
    // Outline width 1vp
    strokeWidth: LengthMetrics.vp(SizeToken.SIZE_NUM_1),
    // Outline color
    strokeColor: CommonUtils.getColorMetrics($r('sys.color.interactive_focus'))
  })
}

@ComponentV2
export struct FocusStateButton {
  aboutToAppear(): void {
    this.getUIContext().getFocusController().activate(true, false);
  }

  aboutToDisappear(): void {
    this.getUIContext().getFocusController().activate(false);
  }

  build() {
    Column() {
      SubTitleView($r('app.string.focus_state_label'))

      Column() {
        Flex({
          space: { main: LengthMetrics.vp(SpaceToken.SPACE_12), cross: LengthMetrics.vp(SpaceToken.SPACE_16) },
          justifyContent: FlexAlign.Start
        }) {
          Button($r('app.string.emphasize_en_label'))
            .defaultFocus(true)
            .commonBtnStyle()
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .id('btn1')
            .onClick(() => this.handleButtonClick('btn1', $r('app.string.emphasized_button_toast_label')))

          Button($r('app.string.normal_en_label'))
            .commonBtnStyle()
            .buttonStyle(ButtonStyleMode.NORMAL)
            .id('btn2')
            .onClick(() => this.handleButtonClick('btn2', $r('app.string.normal_button_toast_label')))

          Button($r('app.string.warning_en_label'))
            .commonBtnStyle(ButtonRole.ERROR)
            .buttonStyle(ButtonStyleMode.NORMAL)
            .id('btn3')
            .onClick(() => this.handleButtonClick('btn3', $r('app.string.warning_button_toast_label')))

          Button($r('app.string.text_en_label'))
            .commonBtnStyle()
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .id('btn4')
            .onClick(() => this.handleButtonClick('btn4', $r('app.string.textual_button_toast_label')))
        }
      }
      .attributeModifier(new ButtonCardStyleModifier())
    }
  }

  /**
   * Centralized handling for button click events: requests focus and displays a toast message
   * @param buttonId The ID of the target button
   * @param toastLabel The string resource ID for the toast message to display
   */
  private handleButtonClick(buttonId: string, toastLabel: Resource): void {
    try {
      this.getUIContext().getFocusController().requestFocus(buttonId);
    } catch (error) {
      Logger.error(
        TAG,
        `Failed to request focus for component [${buttonId}], error info: ${JSON.stringify(error)}`
      );
    }
    CommonUtils.showToast(toastLabel);
  }
}