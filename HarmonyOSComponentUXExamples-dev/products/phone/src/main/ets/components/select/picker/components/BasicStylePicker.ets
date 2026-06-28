/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { common } from '@kit.AbilityKit';
import { Logger } from 'componentuxexamplesbase';
import { CustomContentDialog } from '@ohos.arkui.advanced.Dialog';
import { ComponentContent } from '@ohos.arkui.node';
import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  PickerItemRow,
  SizeToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';

const TAG = 'BasicStylePicker';

/**
 * Formats a Date object into 12-hour time string with AM/PM indicator.
 *
 * Follows the principle of minimal scope - all variables are declared
 * with the narrowest scope necessary.
 *
 * @param {Date} date - The Date object to format
 * @returns {string} Formatted time string in "AM/PM HH:MM" format (e.g., "PM 03:45")
 */
function format12HourTime(ctx: Context | undefined, date: Date): string {
  let hours = date.getHours(); // Get hours in 24-hour format (0-23)
  let minutes = date.getMinutes(); // Get minutes (0-59)

  // Determine AM/PM period based on hour value
  const ampm = hours >= 12 ? $r('app.string.pm_label') : $r('app.string.am_label');

  // Convert to 12-hour format
  hours = hours % 12;
  hours = hours ? hours : 12; // Handle midnight (0) as 12

  // Pad with leading zeros for consistent formatting
  const hoursStr = hours.toString().padStart(2, '0');
  const minutesStr = minutes.toString().padStart(2, '0');

  // Return formatted string: "AM/PM HH:MM"
  return `${CommonUtils.getStrFromResource(ctx, ampm)} ${hoursStr}:${minutesStr}`;
}

const MONTH_NAMES =
  ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November',
    'December'];

/**
 * Formats a date string based on the system locale.
 *
 * Chinese format: "YYYY年 MM月, DD日" (e.g., "2023年 11月, 17日")
 * English format: "Month DD, YYYY" (e.g., "November 17, 2023")
 *
 * @param {Context | undefined} ctx - context of the ability
 * @param {Date} date - the date object to be formatted
 * @returns {string} the formatted date string according to the system locale
 */
function formatDateTitle(ctx: Context | undefined, date: Date): string {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  const context = ctx as common.UIAbilityContext;
  const isZh = context?.config?.language?.startsWith('zh') ?? false;

  return isZh
    ? `${year}年 ${month}月 ${day}日`
    : `${MONTH_NAMES[month - 1]} ${day}, ${year}`;
}

// --- Dialog parameter data class ---
class TimePickerParams {
  public initialTime: Date;
  public onConfirm: (time: Date) => void;
  public onCancel: () => void;

  constructor(initialTime: Date, onConfirm: (time: Date) => void, onCancel: () => void) {
    this.initialTime = initialTime;
    this.onConfirm = onConfirm;
    this.onCancel = onCancel;
  }
}

class DatePickerParams {
  public initialDate: Date;
  public onConfirm: (date: Date) => void;
  public onCancel: () => void;

  constructor(initialDate: Date, onConfirm: (date: Date) => void, onCancel: () => void) {
    this.initialDate = initialDate;
    this.onConfirm = onConfirm;
    this.onCancel = onCancel;
  }
}

// Params for TextPicker dialog
class TextPickerParams {
  public initialValue: string[];
  public onConfirm: (value: string[]) => void;
  public onCancel: () => void;

  constructor(initialValue: string[], onConfirm: (value: string[]) => void, onCancel: () => void) {
    this.initialValue = initialValue;
    this.onConfirm = onConfirm;
    this.onCancel = onCancel;
  }
}

// --- Main component ---
@ComponentV2
export struct BasicStylePicker {
  @Local selectedTime: Date = new Date('2026-01-01T08:08:00');
  @Local selectedDate: Date = new Date('2023-11-17T00:00:00');
  @Local selectedLocation: string[] = ['Guangdong', 'Guangzhou', 'Tianhe'];
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private timeDialogNode: ComponentContent<TimePickerParams> | null = null;
  private dateDialogNode: ComponentContent<DatePickerParams> | null = null;
  private textDialogNode: ComponentContent<TextPickerParams> | null = null;
  private ctx: Context | undefined = undefined;

  @Computed
  private get navAvoidAreaHeight() {
    return this.getUIContext().px2vp(this.breakpointModel.windowInfo.navAvoidAreaHeight);
  }

  aboutToAppear(): void {
    this.ctx = this.getUIContext().getHostContext();
  }

  @Styles
  commonListItemStyles() {
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .stateStyles({
      normal: {
        .backgroundColor($r('sys.color.comp_background_list_card'))
      },
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      }
    })
  }

  build() {
    ListItemGroup({
      header: GroupHeader($r('app.string.basic_style_label'), undefined,
        $r('app.color.default_background_color'))
    }) {
      // TimePicker list item
      ListItem() {
        PickerItemRow({
          label: $r('app.string.timepicker_en_label'),
          value: format12HourTime(this.ctx, this.selectedTime),
          onClickAction: () => {
            this.openTimePicker();
          }
        })
      }
      .commonListItemStyles()

      // DatePicker list item
      ListItem() {
        PickerItemRow({
          label: $r('app.string.datepicker_en_label'),
          value: formatDateTitle(this.ctx, this.selectedDate),
          onClickAction: () => {
            this.openDatePicker();
          }
        })
      }
      .commonListItemStyles()

      // TextPicker list item
      ListItem() {
        PickerItemRow({
          label: $r('app.string.text_picker_en_label'),
          value: this.selectedLocation.join(' '), // Dynamically display selected array
          onClickAction: () => {
            this.openTextPicker(); // Call the newly supplemented method
          }
        })
      }
      .commonListItemStyles()
    }
    .divider({
      strokeWidth: SizeToken.SIZE_NUM_12,
      color: $r('sys.color.background_secondary'),
    })
  }

  private openTimePicker() {
    const uiContext = this.getUIContext();
    const promptAction = uiContext.getPromptAction();

    this.timeDialogNode = new ComponentContent(uiContext, wrapBuilder(TimePickerDialogBuilder), new TimePickerParams(
      this.selectedTime,
      (confirmedTime: Date) => {
        // Update selected time
        this.selectedTime = new Date(confirmedTime.getTime());
        if (this.timeDialogNode) {
          promptAction.closeCustomDialog(this.timeDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close TimePicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      },
      () => {
        if (this.timeDialogNode) {
          promptAction.closeCustomDialog(this.timeDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close TimePicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      }
    ));

    promptAction.openCustomDialog(this.timeDialogNode, {
      alignment: this.breakpointModel.getValue({
        sm: DialogAlignment.Bottom,
        md: DialogAlignment.Center,
        lg: DialogAlignment.Center
      }),
      isModal: true,
      offset: { dx: 0, dy: -this.navAvoidAreaHeight }
    }).catch((error: BusinessError) => {
      Logger.info(TAG, `Failed to open TimePicker dialog, error: ${JSON.stringify(error)}`);
    });
  }

  private openDatePicker() {
    const uiContext = this.getUIContext();
    const promptAction = uiContext.getPromptAction();

    this.dateDialogNode = new ComponentContent(uiContext, wrapBuilder(DatePickerDialogBuilder), new DatePickerParams(
      this.selectedDate,
      (confirmedDate: Date) => {
        // Update selected date
        this.selectedDate = new Date(confirmedDate.getTime());
        if (this.dateDialogNode) {
          promptAction.closeCustomDialog(this.dateDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close DatePicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      },
      () => {
        if (this.dateDialogNode) {
          promptAction.closeCustomDialog(this.dateDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close DatePicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      }
    ));

    promptAction.openCustomDialog(this.dateDialogNode, {
      alignment: this.breakpointModel.getValue({
        sm: DialogAlignment.Bottom,
        md: DialogAlignment.Center,
        lg: DialogAlignment.Center
      }),
      isModal: true,
      offset: { dx: 0, dy: -this.navAvoidAreaHeight }
    }).catch((error: BusinessError) => {
      Logger.info(TAG, `Failed to open DatePicker dialog, error: ${JSON.stringify(error)}`);
    });
  }

  // Handle TextPicker dialog opening
  private openTextPicker() {
    const uiContext = this.getUIContext();
    const promptAction = uiContext.getPromptAction();

    this.textDialogNode = new ComponentContent(uiContext, wrapBuilder(TextPickerDialogBuilder), new TextPickerParams(
      this.selectedLocation,
      (confirmedLocation: string[]) => {
        // Update selected location
        this.selectedLocation = [...confirmedLocation];
        if (this.textDialogNode) {
          promptAction.closeCustomDialog(this.textDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close TextPicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      },
      () => {
        if (this.textDialogNode) {
          promptAction.closeCustomDialog(this.textDialogNode).catch((error: BusinessError) => {
            Logger.info(TAG, `Failed to close TextPicker dialog, error: ${JSON.stringify(error)}`);
          });
        }
      }
    ));

    promptAction.openCustomDialog(this.textDialogNode, {
      alignment: this.breakpointModel.getValue({
        sm: DialogAlignment.Bottom,
        md: DialogAlignment.Center,
        lg: DialogAlignment.Center
      }),
      isModal: true,
      offset: { dx: 0, dy: -this.navAvoidAreaHeight }
    }).catch((error: BusinessError) => {
      Logger.info(TAG, `Failed to open TextPicker dialog, error: ${JSON.stringify(error)}`);
    });
  }
}

// --- TimePicker dialog component ---
@Builder
function TimePickerDialogBuilder(params: TimePickerParams) {
  TimePickerContent({ params: params })
}

@ComponentV2
struct TimePickerContent {
  @Require @Param params: TimePickerParams;
  @Local tempTime: Date = new Date();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @Computed
  private get dialogWidth() {
    return Math.min(SizeToken.SIZE_NUM_400,
      this.getUIContext().px2vp(this.breakpointModel.windowInfo.windowSize.width) - this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_16VP * 2,
        md: PaddingToken.PADDING_16VP * 2,
        lg: PaddingToken.PADDING_24VP * 2
      }))
  }

  aboutToAppear() {
    this.tempTime = new Date(this.params.initialTime.getTime());
  }

  @Builder
  customTimePicker() {
    TimePicker({
      selected: this.tempTime,
    })
      .useMilitaryTime(false)
      .onChange((value: TimePickerResult) => {
        this.tempTime.setHours(value.hour, value.minute);
      })
  }

  build() {
    Column() {
      CustomContentDialog({
        primaryTitle: $r('app.string.timepicker_en_label'),
        contentBuilder: () => {
          this.customTimePicker()
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onCancel();
            }
          },
          {
            value: $r('app.string.confirm_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onConfirm(this.tempTime);
            }
          }
        ]
      })
    }
    .width(this.dialogWidth)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .backgroundColor($r('sys.color.background_primary'))
  }
}

// --- DatePicker dialog component ---
@Builder
function DatePickerDialogBuilder(params: DatePickerParams) {
  DatePickerContent({ params: params })
}

@ComponentV2
struct DatePickerContent {
  @Require @Param params: DatePickerParams;
  @Local tempDate: Date = new Date();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @Computed
  private get dialogWidth() {
    return Math.min(SizeToken.SIZE_NUM_400,
      this.getUIContext().px2vp(this.breakpointModel.windowInfo.windowSize.width) - this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_16VP * 2,
        md: PaddingToken.PADDING_16VP * 2,
        lg: PaddingToken.PADDING_24VP * 2
      }))
  }

  aboutToAppear() {
    this.tempDate = new Date(this.params.initialDate.getTime());
  }

  @Builder
  customDatePicker() {
    DatePicker({
      start: new Date('1970-01-01'),
      end: new Date('2100-12-31'),
      selected: this.tempDate,
    })
      .onDateChange((value: Date) => {
        this.tempDate = value;
      })
  }

  build() {
    Column() {
      CustomContentDialog({
        primaryTitle: $r('app.string.datepicker_en_label'),
        contentBuilder: () => {
          this.customDatePicker()
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onCancel();
            }
          },
          {
            value: $r('app.string.confirm_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onConfirm(this.tempDate);
            }
          }
        ]
      })
    }
    .width(this.dialogWidth)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .backgroundColor($r('sys.color.background_primary'))
  }
}

// --- TextPicker dialog component ---
// Mock data for region selection, scoped closely to where it's used
const REGION_DATA: TextCascadePickerRangeContent[] = [
  { text: 'Shanxi', children: [{ text: 'Taiyuan', children: [{ text: 'Xiaodian' }] }] },
  { text: 'Gansu', children: [{ text: 'Lanzhou', children: [{ text: 'Chengguan' }] }] },
  {
    text: 'Guangdong',
    children: [
      { text: 'Qingyuan', children: [{ text: 'Qingcheng' }] },
      { text: 'Dongguan', children: [{ text: 'Guancheng' }] },
      {
        text: 'Guangzhou',
        children: [
          { text: 'Liwan' },
          { text: 'Panyu' },
          { text: 'Tianhe' },
          { text: 'Haizhu' },
          { text: 'Huangpu' }
        ]
      },
      { text: 'Shenzhen', children: [{ text: 'Nanshan' }, { text: 'Futian' }] },
      { text: 'Zhuhai', children: [{ text: 'Xiangzhou' }] }
    ]
  },
  { text: 'Hunan', children: [{ text: 'Changsha', children: [{ text: 'Yuelu' }] }] },
  { text: 'Jiangsu', children: [{ text: 'Nanjing', children: [{ text: 'Xuanwu' }] }] }
];

@Builder
function TextPickerDialogBuilder(params: TextPickerParams) {
  TextPickerContent({ params: params })
}

@ComponentV2
struct TextPickerContent {
  @Require @Param params: TextPickerParams;
  @Local tempValue: string[] = [];
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @Computed
  private get dialogWidth() {
    return Math.min(SizeToken.SIZE_NUM_400,
      this.getUIContext().px2vp(this.breakpointModel.windowInfo.windowSize.width) - this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_16VP * 2,
        md: PaddingToken.PADDING_16VP * 2,
        lg: PaddingToken.PADDING_24VP * 2
      }))
  }

  aboutToAppear() {
    // Initialize temporary value from params
    this.tempValue = [...this.params.initialValue];
  }

  @Builder
  customTextPicker() {
    TextPicker({ range: REGION_DATA, value: this.tempValue })
      .canLoop(false)
      .disappearTextStyle({
        overflow: TextOverflow.Ellipsis
      })
      .selectedTextStyle({
        overflow: TextOverflow.Ellipsis
      })
      .onChange((value: string | string[]) => {
        // Safely cast to string array since we use a cascaded range
        this.tempValue = value as string[];
      })
  }

  build() {
    Column() {
      CustomContentDialog({
        primaryTitle: $r('app.string.text_picker_en_label'),
        contentBuilder: () => {
          this.customTextPicker()
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onCancel();
            }
          },
          {
            value: $r('app.string.confirm_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              this.params.onConfirm(this.tempValue);
            }
          }
        ]
      })
    }
    .width(this.dialogWidth)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_32)
    .backgroundColor($r('sys.color.background_primary'))
  }
}