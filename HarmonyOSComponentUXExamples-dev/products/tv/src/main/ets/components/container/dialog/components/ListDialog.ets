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
import { CustomContentDialog } from '@kit.ArkUI';
import { CommonConstants, Logger, SizeToken, SpaceToken } from 'componentuxexamplesbase';

const TAG = 'ListDialog';

@ComponentV2
export struct ListDialog {
  // Custom popup content area
  @Builder
  buildContent(): void {
    Row({ space: $r('sys.float.padding_level11') }) {
      List({ space: SizeToken.SIZE_NUM_16 }) {
        ListItem() {
          CommonItem({ val: $r('app.string.single_list_label'), hint: $r('app.string.list_right_text_label') })
        }

        ListItem() {
          CommonItem({ val: $r('app.string.single_list_label'), hint: $r('app.string.list_right_text_label') })
        }

        ListItem() {
          CommonItem({ val: $r('app.string.single_list_label'), hint: $r('app.string.list_right_text_label') })
        }

        ListItem() {
          CommonItem({ val: $r('app.string.single_list_label'), hint: $r('app.string.list_right_text_label') })
        }
      }
      .height(SizeToken.SIZE_NUM_64 * CommonConstants.INTEGER_4 + SpaceToken.SPACE_16 * CommonConstants.INTEGER_3)
      .width(SizeToken.SIZE_PERCENT_100)
      .clip(false)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: $r('app.string.title_label'),
      contentBuilder: () => {
        this.buildContent();
      },
      buttons: [
        {
          value: $r('app.string.common_button_dialog_label'),
          buttonStyle: ButtonStyleMode.NORMAL,
          role: ButtonRole.NORMAL,
          action: () => {
            Logger.info(TAG, 'Callback when the button1 is clicked');
          }
        },
        {
          value: $r('app.string.common_button_dialog_label'),
          buttonStyle: ButtonStyleMode.NORMAL,
          role: ButtonRole.NORMAL,
          action: () => {
            Logger.info(TAG, 'Callback when the button2 is clicked');
          }
        }
      ],
    }),
  });

  build() {
    CommonItem({ val: $r('app.string.list_dialog_label') })
      .onClick(() => {
        this.dialogController.open()
      })
  }
}