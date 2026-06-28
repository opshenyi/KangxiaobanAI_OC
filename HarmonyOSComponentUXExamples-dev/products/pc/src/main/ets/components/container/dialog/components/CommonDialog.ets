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

import { ConfirmDialog, CustomContentDialog, TipsDialog } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';

import {
  CommonConstants,
  CornerRadiusToken,
  CryptoUtil,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';
import { CommonDivider } from '../common/CommonDivider';
import { CommonListRow } from '../common/CommonListRow';

const TAG = 'CommonDialog';

/**
 * Unified modal option data structure
 * Supports both Radio (single-select) and Checkbox (multi-select) lists
 */
export interface OptionItem {
  id: string;
  label: ResourceStr;
}

@Builder
export function CommonDialog() {
  ListItemGroup({
    header: GroupHeader($r('app.string.common_dialog_label'), undefined,
      $r('app.color.default_background_color'))
  }) {
    ListItem() {
      CommonDialogStyle1()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius({
      topLeft: CornerRadiusToken.CORNER_RADIUS_16,
      topRight: CornerRadiusToken.CORNER_RADIUS_16
    })

    ListItem() {
      CommonDialogStyle2()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle3()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle4()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle5()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle6()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle7()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))

    ListItem() {
      CommonDialogStyle8()
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius({
      bottomLeft: CornerRadiusToken.CORNER_RADIUS_16,
      bottomRight: CornerRadiusToken.CORNER_RADIUS_16
    })
  }
}

/**
 * Common Style 1: Title + List + Action Buttons
 */
@ComponentV2
struct CommonDialogStyle1 {
  @Local selectedIds: string[] = ['option_1', 'option_2', 'option_3'];
  private options: OptionItem[] = [
    { id: 'option_1', label: $r('app.string.option_text_one_label') },
    { id: 'option_2', label: $r('app.string.option_text_two_label') },
    { id: 'option_3', label: $r('app.string.option_text_three_label') }
  ];
  private dialogController1: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: $r('app.string.title_en_label'),
      contentBuilder: () => {
        this.CheckboxBuilder()
      },
      buttons: [
        {
          value: $r('app.string.normal_button_label'),
          role: ButtonRole.NORMAL
        },
        {
          value: $r('app.string.emphasized_button_label'),
          buttonStyle: ButtonStyleMode.EMPHASIZED,
          action: () => {
            Logger.info(TAG, 'Callback when the button is clicked')
          }
        }
      ]
    }),
    alignment: DialogAlignment.Center,
    autoCancel: true,
    customStyle: false
  });

  @Builder
  CheckboxBuilder() {
    ForEach(this.options, (item: OptionItem, index: number) => {
      Column() {
        Row() {
          Text(item.label)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          Checkbox({ name: item.id, group: 'checkboxGroup1' })
            .select(this.selectedIds.includes(item.id))
            .shape(CheckBoxShape.CIRCLE)
            .onChange((value: boolean) => {
              if (value) {
                if (!this.selectedIds.includes(item.id)) {
                  this.selectedIds.push(item.id);
                }
              } else {
                const idx = this.selectedIds.indexOf(item.id);
                if (idx !== -1) {
                  this.selectedIds.splice(idx, 1);
                }
              }
            })
        }
        .height(SizeToken.SIZE_NUM_40)
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        if (index !== this.options.length - 1) {
          CommonDivider()
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
    }, (item: OptionItem) => item.id)
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.title_list_and_action_buttons_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          this.dialogController1.open();
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Common Style 2: Title + List + Action Buttons
 */
@ComponentV2
struct CommonDialogStyle2 {
  @Local isChecked: boolean = true;
  private dialogController2: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: $r('app.string.title_en_label'),
      content: 'A'.repeat(60) + '.',
      // Checkbox checked state
      isChecked: this.isChecked,
      // Checkbox label text
      checkTips: $r('app.string.do_not_show_again_label'),
      primaryButton: {
        value: $r('app.string.normal_button_label'),
        role: ButtonRole.NORMAL,
        action: () => {
          Logger.info(TAG, 'Callback when the normal button is clicked.');
        },
      },
      secondaryButton: {
        value: $r('app.string.emphasized_button_label'),
        buttonStyle: ButtonStyleMode.EMPHASIZED,
        action: () => {
          Logger.info(TAG, 'Callback when the emphasized button is clicked.');
        }
      },
      onCheckedChange: () => {
        Logger.info(TAG, 'Callback when the checkbox is clicked.');
      },
    }),
    alignment: DialogAlignment.Center,
    autoCancel: true,
    customStyle: false
  });

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.body_text_and_checkbox_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          this.dialogController2.open();
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}


/**
 * Common Style 3: Description Text + List
 */
@ComponentV2
struct CommonDialogStyle3 {
  @Local selectedId: string = 'option1';
  // Define single-choice group data source
  private options: OptionItem[] = [
    { id: 'option1', label: $r('app.string.option_text_one_label') },
    { id: 'option2', label: $r('app.string.option_text_two_label') },
    { id: 'option3', label: $r('app.string.option_text_three_label') }
  ];
  private dialogController3: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: $r('app.string.title_en_label'),
      contentBuilder: () => {
        this.RadioBuilder()
      },
      buttons: [
        {
          value: $r('app.string.normal_button_label'),
          role: ButtonRole.NORMAL
        },
        {
          value: $r('app.string.emphasized_button_label'),
          buttonStyle: ButtonStyleMode.EMPHASIZED,
          action: () => {
            Logger.info(TAG, 'Callback when the button is clicked')
          }
        }
      ]
    }),
    alignment: DialogAlignment.Center,
    autoCancel: true,
    customStyle: false
  });

  @Builder
  RadioBuilder() {
    Row() {
      Text('A'.repeat(20) + '.')
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
    }
    .justifyContent(FlexAlign.Center)
    .margin({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP
    })

    ForEach(this.options, (item: OptionItem, index: number) => {
      Column() {
        Row() {
          Text(item.label)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          Radio({ value: item.id, group: 'radioGroup1' })
            .checked(this.selectedId === item.id)
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectedId = item.id;
              }
            })
        }
        .height(SizeToken.SIZE_NUM_40)
        .width(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        if (index !== this.options.length - 1) {
          Divider()
            .color($r('sys.color.comp_divider'))
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
    }, (item: OptionItem) => item.id)
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.description_text_and_list_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          this.dialogController3.open();
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Common Style 4: With Input Field
 */
@ComponentV2
struct CommonDialogStyle4 {
  private dialogController4: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController4 = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_en_label'),
        contentBuilder: () => {
          this.TextInputBuilder()
        },
        buttons: [
          {
            value: $r('app.string.normal_button_label'),
            role: ButtonRole.NORMAL,
            action: () => {
              Logger.info(TAG, 'Callback when the normal button is clicked.');
            }
          },
          {
            value: $r('app.string.emphasized_button_label'),
            buttonStyle: ButtonStyleMode.EMPHASIZED,
            action: () => {
              Logger.info(TAG, 'Callback when the emphasized button is clicked.');
            }
          }
        ]
      }),
      alignment: DialogAlignment.Center,
      autoCancel: true,
      customStyle: false
    });
  }

  @Builder
  TextInputBuilder() {
    TextInput({ placeholder: $r('app.string.normal_en_label') })
      .placeholderColor($r('sys.color.font_secondary'))
      .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
      .width(SizeToken.SIZE_PERCENT_100)
      .fontSize($r('sys.float.Body_L'))
      .fontColor($r('sys.color.font_primary'))
      .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.with_input_field_label'),
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
 * Common Style 5: Image + Text
 */
@ComponentV2
struct CommonDialogStyle5 {
  private dialogController5: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController5 = new CustomDialogController({
      builder: TipsDialog({
        imageRes: $r('app.media.weather'),
        imageSize: {
          width: SizeToken.SIZE_NUM_80,
          height: SizeToken.SIZE_NUM_80
        },
        content: $r('app.string.delete_app_tips_label'),
        primaryButton: {
          value: $r('app.string.normal_button_label'),
          role: ButtonRole.NORMAL,
          action: () => {
            Logger.info(TAG, 'Callback when the normal button is clicked.');
          }
        },
        secondaryButton: {
          value: $r('app.string.emphasized_button_label'),
          buttonStyle: ButtonStyleMode.EMPHASIZED,
          action: () => {
            Logger.info(TAG, 'Callback when the emphasized button is clicked.');
          }
        },
        onCheckedChange: () => {
          Logger.info(TAG, 'Callback when the checkbox is clicked.');
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
        title: $r('app.string.image_and_text_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController5) {
            this.dialogController5.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Common Style 6: Image + Text + Checkbox
 */
@ComponentV2
struct CommonDialogStyle6 {
  private dialogController6: CustomDialogController | null = null;

  aboutToAppear(): void {
    this.dialogController6 = new CustomDialogController({
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
    Column() {
      CommonListRow({
        title: $r('app.string.image_text_and_checkbox_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController6) {
            this.dialogController6.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
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
    Column({ space: SizeToken.SIZE_NUM_16 }) {
      Row() {
        Image($r('app.media.rectangle'))
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_180)
          .fillColor($r('app.color.image_fill_color'))
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })

      Column() {
        Row() {
          Text($r('app.string.title_en_label'))
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.font_primary'))
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_56)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Text('A'.repeat(50) + '.')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
          .textAlign(TextAlign.Center)
          .maxLines(CommonConstants.TEXT_MAX_LINES_2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: SpaceToken.SPACE_8 }) {
          Checkbox({ name: 'checkBox1', group: 'ImageCustomDialogCheckGroup' })
            .select(true)
            .height(SizeToken.SIZE_NUM_20)
            .width(SizeToken.SIZE_NUM_20)
            .margin({ left: PaddingToken.PADDING_0VP })
            .onChange((isChecked: boolean) => {
              Logger.info(TAG, 'Checkbox status is ' + isChecked);
            })

          Text($r('app.string.do_not_show_again_label'))
            .fontSize($r('sys.float.Caption_L'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Regular)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_48)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
      }
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })


      Row({ space: SizeToken.SIZE_NUM_16 }) {
        Button($r('app.string.normal_button_label'))
          .buttonStyle(ButtonStyleMode.NORMAL)
          .role(ButtonRole.NORMAL)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onCancel();
          })

        Button($r('app.string.emphasized_button_label'))
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
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
      .padding({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_16VP
      })
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .padding({
      top: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
}

/**
 * Common Style 7: Progress Bar + Action Buttons
 */
@ComponentV2
struct CommonDialogStyle7 {
  private dialogController7: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogController7 = new CustomDialogController({
      builder: CustomContentDialog({
        contentBuilder: () => {
          this.ProgressBuilder()
        }
      }),
      alignment: DialogAlignment.Center,
      // Progress-related operations typically disable tap-to-dismiss on the overlay;
      // users must explicitly tap the close button instead.
      autoCancel: false,
      customStyle: false,
      width: SizeToken.SIZE_NUM_400
    });
  }

  @Builder
  ProgressBuilder() {
    // Pass the controller to the inner component so the popup can be dismissed when the X icon is tapped
    ProgressDialogContent({ dialogController: this.dialogController7 })
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.with_progress_bar_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController7) {
            this.dialogController7.open();
          }
        }
      })

      CommonDivider()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Internal content component for progress bar modal
 * Manages timers and progress state to prevent lifecycle-related memory leaks
 */
@ComponentV2
struct ProgressDialogContent {
  @Param @Require dialogController?: CustomDialogController;
  // Current progress value
  @Local currentProgress: number = 0;
  // Total progress bar value
  private total: number = 100;
  // Timer ID, used for clearing the
  private intervalId: number = -1;

  aboutToAppear() {
    this.startDownloadSimulation();
  }

  aboutToDisappear() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
  }

  build() {
    Column({ space: SizeToken.SIZE_NUM_2 }) {
      Row() {
        Text($r('app.string.paste_file_hint_label'))
          .fontSize($r('sys.float.Body_M'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .maxLines(CommonConstants.TEXT_MAX_LINES_1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text($r('app.string.progress_hint_label', this.currentProgress))
          .fontSize($r('sys.float.Body_M'))
          .fontColor($r('sys.color.font_secondary'))
          .margin({ left: PaddingToken.PADDING_8VP })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ right: PaddingToken.PADDING_40VP })

      Row({ space: SizeToken.SIZE_NUM_16 }) {
        Progress({ value: this.currentProgress, total: this.total, type: ProgressType.Linear })
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

        SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_tertiary')])
          .onClick(() => {
            if (this.dialogController) {
              this.dialogController.close();
            }
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .alignItems(VerticalAlign.Center)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  // Simulate download process
  private startDownloadSimulation() {
    let increment: number = 0;
    // Update progress every 100ms
    this.intervalId = setInterval(() => {
      if (this.currentProgress >= this.total) {
        // Download complete
        clearInterval(this.intervalId);
      } else {
        // Increase progress by 2% - 5% randomly to simulate real-world fluctuations

        try {
          increment = CryptoUtil.generateRangeRandomSync(0, 3) + 2;
        } catch (error) {
          const err: BusinessError = error as BusinessError;
          Logger.error(TAG, `startDownloadSimulation generateRangeRandomSync error: ${err.code}, ${err.message}.`);
        }
        this.currentProgress = Math.min(this.currentProgress + increment, this.total);
      }
    }, 100); // Update every 100ms
  }
}

/**
 * Common Style 8: Double Progress Bar + Action Buttons
 */
@ComponentV2
struct CommonDialogStyle8 {
  private dialogController8: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogController8 = new CustomDialogController({
      builder: CustomContentDialog({
        contentBuilder: () => {
          this.DoubleProgressBuilder()
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            role: ButtonRole.NORMAL,
            action: () => {
              // Cancel button tap auto-dismisses the modal
              // Closure triggers DoubleProgressDialogContent's aboutToDisappear lifecycle hook,
              // halting all progress indicators
              Logger.info(TAG,
                'Cancel button clicked, closing dialog and stopping all progress.');
            }
          }
        ]
      }),
      alignment: DialogAlignment.Center,
      autoCancel: false, // Disable overlay tap-to-close during progress operations
      customStyle: false,
      width: SizeToken.SIZE_NUM_400
    });
  }

  @Builder
  DoubleProgressBuilder() {
    DoubleProgressDialogContent({ dialogController: this.dialogController8 })
  }

  build() {
    Column() {
      CommonListRow({
        title: $r('app.string.progress_bar_and_action_buttons_label'),
        rowBorderRadius: CommonConstants.INTEGER_0,
        rowPadding: undefined,
        onClickAction: () => {
          if (this.dialogController8) {
            this.dialogController8.open();
          }
        }
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

/**
 * Internal content component for Double Progress bar modal
 */
@ComponentV2
struct DoubleProgressDialogContent {
  @Param @Require dialogController?: CustomDialogController;
  // Progress bar 1 state
  @Local currentProgress1: number = 0;
  @Local isVisible1: boolean = true;
  // Progress bar 2 state
  @Local currentProgress2: number = 0;
  @Local isVisible2: boolean = true;
  private intervalId1: number = -1;
  private intervalId2: number = -1;
  private total: number = 100;

  aboutToAppear() {
    this.startDownloadSimulation1();
    this.startDownloadSimulation2();
  }

  aboutToDisappear() {
    // Ensure all lingering timers are cleared when the popup dismisses (cancelled or completed)
    this.clearAllIntervals();
  }

  build() {
    Column({ space: SizeToken.SIZE_NUM_16 }) {
      // Progress bar 1 view
      if (this.isVisible1) {
        Column({ space: SizeToken.SIZE_NUM_2 }) {
          Row() {
            Text($r('app.string.paste_file_hint_label'))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)
              .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
              .maxLines(CommonConstants.TEXT_MAX_LINES_1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text($r('app.string.progress_hint_label', this.currentProgress1))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
              .margin({ left: PaddingToken.PADDING_8VP })
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ right: PaddingToken.PADDING_40VP })

          Row({ space: SizeToken.SIZE_NUM_16 }) {
            Progress({ value: this.currentProgress1, total: this.total, type: ProgressType.Linear })
              .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

            SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_tertiary')])
              .onClick(() => {
                // Cancel progress bar 1
                this.isVisible1 = false;
                clearInterval(this.intervalId1);
                this.intervalId1 = -1;
                this.checkAndCloseDialog();
              })
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .alignItems(VerticalAlign.Center)
        }
        .width(SizeToken.SIZE_PERCENT_100)
      }

      // Progress bar 2 view
      if (this.isVisible2) {
        Column({ space: SizeToken.SIZE_NUM_2 }) {
          Row() {
            Text($r('app.string.paste_file_hint_label'))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)
              .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
              .maxLines(CommonConstants.TEXT_MAX_LINES_1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text($r('app.string.progress_hint_label', this.currentProgress2))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
              .margin({ left: PaddingToken.PADDING_8VP })
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ right: PaddingToken.PADDING_40VP })

          Row({ space: SizeToken.SIZE_NUM_16 }) {
            Progress({ value: this.currentProgress2, total: this.total, type: ProgressType.Linear })
              .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)

            SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_tertiary')])
              .onClick(() => {
                // Cancel progress bar 2
                this.isVisible2 = false;
                clearInterval(this.intervalId2);
                this.intervalId2 = -1;
                this.checkAndCloseDialog();
              })
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .alignItems(VerticalAlign.Center)
        }
        .width(SizeToken.SIZE_PERCENT_100)
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }

  private clearAllIntervals() {
    if (this.intervalId1 !== -1) {
      clearInterval(this.intervalId1);
      this.intervalId1 = -1;
    }
    if (this.intervalId2 !== -1) {
      clearInterval(this.intervalId2);
      this.intervalId2 = -1;
    }
  }

  /**
   * Verify all progress bars are done
   */
  private checkAndCloseDialog() {
    if (!this.isVisible1 && !this.isVisible2) {
      if (this.dialogController) {
        this.dialogController.close();
      }
    }
  }

  /**
   * Mock task 1
   */
  private startDownloadSimulation1() {
    let increment: number = 0;
    this.intervalId1 = setInterval(() => {
      if (this.currentProgress1 >= this.total) {
        clearInterval(this.intervalId1);
        this.intervalId1 = -1;
      } else {
        try {
          increment = CryptoUtil.generateRangeRandomSync(0, 3) + 2;
        } catch (error) {
          const err: BusinessError = error as BusinessError;
          Logger.error(TAG, `startDownloadSimulation1 generateRangeRandomSync error: ${err.code}, ${err.message}.`);
        }
        this.currentProgress1 = Math.min(this.currentProgress1 + increment, this.total);
      }
    }, 120); // Introduce slight offset so the two progress bars animate at different rates
  }

  /**
   * Mock task 2
   */
  private startDownloadSimulation2() {
    let increment: number = 0;
    this.intervalId2 = setInterval(() => {
      if (this.currentProgress2 >= this.total) {
        clearInterval(this.intervalId2);
        this.intervalId2 = -1;
      } else {
        try {
          increment = CryptoUtil.generateRangeRandomSync(0, 2) + 1;
        } catch (error) {
          const err: BusinessError = error as BusinessError;
          Logger.error(TAG, `startDownloadSimulation2 generateRangeRandomSync error: ${err.code}, ${err.message}.`);
        }
        this.currentProgress2 = Math.min(this.currentProgress2 + increment, this.total);
      }
    }, 80);
  }
}