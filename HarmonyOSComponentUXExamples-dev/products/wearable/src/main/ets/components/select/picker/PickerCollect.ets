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
import { ComponentItem, Logger, SizeToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

const TAG = 'PickerCollect';

@Builder
export function PickerCollectBuilder() {
  PickerCollect()
}

@ComponentV2
struct PickerCollect {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  context: UIContext = this.getUIContext();
  @Local isLunar: boolean = false;
  private selectedDate: Date = new Date('2021-08-08');
  private multi: string[][] =
    [['1', '2', '3', '4', '5'], ['6', '7', '8', '9', '0'], ['7', '4', '1', '8', '5', '2'], ['1', '2', '3', '4', '5'],
      ['6', '7', '8', '9', '0']];

  @Builder
  CustomDatePicker() {
    DatePicker({
      start: new Date('1970-1-1'),
      end: new Date('2100-1-1'),
      selected: this.selectedDate
    })
      .height('75%')
      .width('75%')
      .margin({ top: 10 })
      .lunar(this.isLunar)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
.onDateChange((value: Date) => {
         this.selectedDate = value;
         Logger.info(TAG, 'select current date is: ' + value.toString());
       })
  }

  @Builder
  CustomTimePicker() {
    TimePicker()
      .useMilitaryTime(false)
      .height('75%')
      .width('75%')
      .margin({ top: 10 })
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
.onChange((value: TimePickerResult) => {
         if (value.hour >= 0) {
           Logger.info(TAG, 'select current time is: ' + JSON.stringify(value));
         }
       })
  }

  @Builder
  CustomTextPicker() {
    TextPicker({ range: this.multi, selected: 1 })
      .height('75%')
      .width('75%')
      .margin({ top: 10 })
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
.onChange((value: string | string[], index: number | number[]) => {
         Logger.info(TAG, 'Picker item changed, value: ' + value + ', index: ' + index);
       })
  }

  build() {
    NavDestination() {
      if (this.param.id === 'date_picker') {
        this.CustomDatePicker()
      }
      if (this.param.id === 'time_picker') {
        this.CustomTimePicker()
      }
      if (this.param.id === 'text_picker') {
        this.CustomTextPicker()
      }
    }
    .title({ builder: TitleComponent(this.param.name), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}