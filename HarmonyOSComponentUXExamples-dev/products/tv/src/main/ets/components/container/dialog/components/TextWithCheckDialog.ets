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

import { Logger } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';
import { ConfirmDialog } from '@kit.ArkUI';

const TAG = 'TextWithCheckDialog';

@ComponentV2
export struct TextWithCheckDialog {
  private dialogControllerConfirm: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: $r('app.string.dialog_title_label'),
      content: $r('app.string.dialog_content_label'),
      // Checkbox selected state
      isChecked: true,
      // Checkbox description text
      checkTips: $r('app.string.dialog_tips_label'),
      primaryButton: {
        value: $r('app.string.common_button_dialog_label'),
        role: ButtonRole.NORMAL,
        action: () => {
          Logger.info(TAG, 'Callback when the primaryButton is clicked');
        }
      },
      secondaryButton: {
        value: $r('app.string.common_button_dialog_label'),
        role: ButtonRole.NORMAL,
        action: () => {
          Logger.info(TAG, 'Callback when the secondaryButton is clicked');
        }
      },
      onCheckedChange: (isChecked: boolean) => {
        Logger.info(TAG, `onCheckedChange value is ${isChecked}`);
      },
    })
  })

  build() {
    CommonItem({ val: $r('app.string.text_with_checkbox_dialog_label') })
      .onClick(() => {
        this.dialogControllerConfirm.open();
      })
  }
}