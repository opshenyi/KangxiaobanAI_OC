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

const TAG = 'ProgressBarDialog';

@ComponentV2
export struct ProgressBarDialog {
  // Custom popup content area
  @Builder
  buildContent(): void {
    Row({ space: $r('sys.float.padding_level11') }) {
      Column({ space: SpaceToken.SPACE_16 }) {
        Row() {
          Text('Progress Title')
            .fontSize($r('app.float.list_item_text_size'))
            .fontColor($r('sys.color.font_primary'))
            .lineHeight($r('app.float.list_title_line_height'))

          Text('50%')
            .fontSize($r('app.float.list_item_text_size'))
            .fontColor($r('sys.color.font_secondary'))
            .lineHeight($r('app.float.list_title_line_height'))
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)

        Progress({ value: CommonConstants.INTEGER_50, type: ProgressType.Linear })
          .style({ strokeWidth: SizeToken.SIZE_NUM_6 }) // Set progress bar thickness
          .height($r('app.float.progress_size1'))
          .color($r('sys.color.font_primary'))
      }
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

      SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
        .fontSize($r('app.float.symbol_size_large'))
        .fontColor([$r('sys.color.icon_tertiary')])
        .alignSelf(ItemAlign.End)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
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
      ]
    })
  });

  build() {
    CommonItem({ val: $r('app.string.progressbar_dialog_label') })
      .onClick(() => {
        this.dialogController.open();
      })
  }
}