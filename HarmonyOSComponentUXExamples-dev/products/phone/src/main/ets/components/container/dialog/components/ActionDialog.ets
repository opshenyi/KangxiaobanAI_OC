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
import { CustomContentDialog } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { CommonListRow, SizeToken, SpaceToken } from 'componentuxexamplesbase';

const TAG = 'ActionDialog';

@ComponentV2
export struct ActionDialog {
  @Local isPressedActionDialog: boolean = false;
  private dialogControllerConfirm: CustomDialogController | undefined = undefined;

  @Builder
  buildContent(): void {
    Column() {
      Text($r('app.string.operation_confirmation_dialog_label'))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.JUSTIFY)
        .wordBreak(WordBreak.HYPHENATION)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  aboutToAppear(): void {
    this.dialogControllerConfirm = new CustomDialogController({
      builder: CustomContentDialog({
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              Logger.info(TAG, 'The cancel button has been clicked currently.');
            }
          },
          {
            value: $r('app.string.delete_label'),
            role: ButtonRole.ERROR,
            action: () => {
              Logger.info(TAG, 'The delete button has been clicked currently.');
            }
          }
        ]
      })
    });
  }

  build() {
    Column({ space: SpaceToken.SPACE_12 }) {
      CommonListRow({
        title: $r('app.string.operation_confirmation_label'),
        onClickAction: () => {
          this.dialogControllerConfirm?.open();
        }
      })
    }
  }
}
