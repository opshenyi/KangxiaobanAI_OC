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

import { CommonItem } from '../../../common/CommonItem';
import { TipsDialog } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';

const TAG = 'TextWithPicDialog';

@ComponentV2
export struct TextWithPicDialog {
  dialogControllerImage: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      imageRes: $r('app.media.scenery5'),
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
      }
    })
  })

  build() {
    CommonItem({ val: $r('app.string.pic_with_text_dialog_label') })
      .onClick(() => {
        this.dialogControllerImage.open()
      })
  }
}