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
import { CommonConstants, CommonListRow, CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

const TAG = 'GraphicDialog';

@ComponentV2
export struct GraphicDialog {
  // Initialize custom dialog controller
  private dialogController: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController = new CustomDialogController({
      builder: ImageCustomDialog({
        onConfirm: () => {
          Logger.info(TAG, 'Confirm button has been clicked.');
        },
        onCancel: () => {
          Logger.info(TAG, 'Cancel button has been clicked.');
        }
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false,
    });
  }

  build() {
    CommonListRow({
      title: $r('app.string.graphical_dialog_label'),
      onClickAction: () => {
        if (this.dialogController) {
          this.dialogController.open();
        }
      }
    })
  }
}

/**
 * Custom dialog component
 */
@CustomDialog
struct ImageCustomDialog {
  // Controller, must be defined, passed from outside
  controller?: CustomDialogController
  // Callback for confirm click
  onConfirm: () => void = () => {
  }
  // Callback for cancel click
  onCancel: () => void = () => {
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.rectangle'))
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_188)
          .fillColor($r('app.color.image_fill_color'))
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
          .clip(true)

        Text($r('app.string.image_area_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.brand'))
          .fontWeight(FontWeight.Medium)
      }

      Row() {
        Text($r('app.string.graphical_dialog_label'))
          .fontSize($r('sys.float.Title_S'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_56)
      .margin({ top: PaddingToken.PADDING_8VP })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Text('A'.repeat(45))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: PaddingToken.PADDING_8VP })

      Row() {
        Button($r('app.string.cancel_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onCancel();
          })

        Divider()
          .vertical(true)
          .width(SizeToken.SIZE_NUM_16)
          .height(SizeToken.SIZE_NUM_24)
          .color($r('sys.color.comp_divider'))

        Button($r('app.string.confirm_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onConfirm();
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_40)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP,
      top: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
}