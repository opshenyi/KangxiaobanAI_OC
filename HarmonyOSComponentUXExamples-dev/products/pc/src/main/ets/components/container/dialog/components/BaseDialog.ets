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
import {
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';
import { CommonDivider } from '../common/CommonDivider';
import { CommonListRow } from '../common/CommonListRow';

const TAG = 'BaseDialog';

@Builder
export function BaseDialog() {
  ListItemGroup({
    header: GroupHeader($r('app.string.basic_composition_label'), undefined,
      $r('app.color.default_background_color'))
  }) {
    ListItem() {
      BaseDialogStyle1()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius({
      topLeft: CornerRadiusToken.CORNER_RADIUS_16,
      topRight: CornerRadiusToken.CORNER_RADIUS_16
    })

    ListItem() {
      BaseDialogStyle2()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      BaseDialogStyle3()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      BaseDialogStyle4()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      BaseDialogStyle5()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius({
      bottomLeft: CornerRadiusToken.CORNER_RADIUS_16,
      bottomRight: CornerRadiusToken.CORNER_RADIUS_16
    })
  }
}

/**
 * Basic Style 1: Body Text + Action Buttons
 */
@ComponentV2
struct BaseDialogStyle1 {
  private dialogController1: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController1 = new CustomDialogController({
      builder: CustomDialogContent1({
        onCancel: () => {
          Logger.info(TAG, 'Cancel button has been clicked.');
        }
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.body_text_and_action_buttons_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController1) {
            this.dialogController1.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

@CustomDialog
struct CustomDialogContent1 {
  controller?: CustomDialogController;
  // Callback for cancel click
  onCancel: VoidCallback = () => {
  }

  build() {
    Column({ space: SpaceToken.SPACE_16 }) {
      Text('A'.repeat(60) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .margin({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP
        })

      Row() {
        Button($r('app.string.normal_button_label'))
          .buttonStyle(ButtonStyleMode.NORMAL)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_40)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onCancel();
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_16VP
      })
    }
    .padding({
      top: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
}

/**
 * Basic Style 2: Title + Body Text + Action Buttons
 */
@ComponentV2
struct BaseDialogStyle2 {
  private dialogController2: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController2 = new CustomDialogController({
      builder: CustomDialogContent2({
        onConfirm: () => {
          Logger.info(TAG, 'Confirm button has been clicked.');
        },
        onCancel: () => {
          Logger.info(TAG, 'Cancel button has been clicked.');
        }
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.title_body_text_and_action_buttons_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController2) {
            this.dialogController2.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

@CustomDialog
struct CustomDialogContent2 {
  // Controller, must be defined, passed from outside
  controller?: CustomDialogController
  // Callback for confirm click
  onConfirm: () => void = () => {
  }
  // Callback for cancel click
  onCancel: () => void = () => {
  }

  build() {
    Column({ space: SpaceToken.SPACE_16 }) {
      Row() {
        Text($r('app.string.title_en_label'))
          .fontSize($r('sys.float.Title_S'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Bold)
      }
      .justifyContent(FlexAlign.Center)

      Text('A'.repeat(60) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .margin({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP
        })

      Row({ space: SpaceToken.SPACE_16 }) {
        Button($r('app.string.button_label'))
          .buttonStyle(ButtonStyleMode.NORMAL)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onConfirm();
          })

        Button($r('app.string.emphasized_button_label'))
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onCancel();
          })
      }
      .height(SizeToken.SIZE_NUM_40)
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_16VP
      })
    }
    .padding({
      top: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
}

/**
 * Basic Style 3: Title + Supporting Text + Body Text
 */
@ComponentV2
struct BaseDialogStyle3 {
  private dialogController3: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController3 = new CustomDialogController({
      builder: CustomDialogContent3(),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.title_supporting_text_and_body_text_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController3) {
            this.dialogController3.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

@CustomDialog
struct CustomDialogContent3 {
  // Controller, must be defined, passed from outside
  controller?: CustomDialogController

  build() {
    Column({ space: SpaceToken.SPACE_12 }) {
      Row() {
        Column({ space: SpaceToken.SPACE_4 }) {
          Text($r('app.string.title_en_label'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Bold)

          Text($r('app.string.auxiliary_text_label'))
            .fontSize($r('sys.float.Body_M'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)

      Text('A'.repeat(60) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .margin({
          left: PaddingToken.PADDING_24VP,
          right: PaddingToken.PADDING_24VP
        })
    }
    .padding({
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_24VP
    })
  }
}

/**
 * Basic Style 4: Body Text
 */
@ComponentV2
struct BaseDialogStyle4 {
  private dialogController4: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController4 = new CustomDialogController({
      builder: CustomContentDialog({
        contentBuilder: () => {
          this.AContent()
        }
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  @Builder
  AContent() {
    Row() {
      Text('A'.repeat(60) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
    }
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.body_text_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController4) {
            this.dialogController4.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Basic Style 5: Title + Body Text + Three-Row Buttons
 */
@ComponentV2
struct BaseDialogStyle5 {
  private dialogController5: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController5 = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_en_label'),
        contentBuilder: () => {
          this.AContent()
        },
        buttons: [
          {
            value: $r('app.string.emphasized_button_label'),
            buttonStyle: ButtonStyleMode.EMPHASIZED,
            action: () => {
              Logger.info(TAG, 'Callback when the button is clicked.');
            }
          },
          {
            value: $r('app.string.normal_button_label'),
            role: ButtonRole.NORMAL
          },
          {
            value: $r('app.string.normal_button_label'),
            role: ButtonRole.NORMAL
          }
        ],
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  @Builder
  AContent() {
    Row() {
      Text('A'.repeat(60) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
    }
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.title_body_text_and_three_row_buttons_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController5) {
            this.dialogController5.open();
          }
        }
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}