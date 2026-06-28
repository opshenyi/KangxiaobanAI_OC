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
import { Logger } from 'componentuxexamplesbase';

const TAG = 'TimePickerDemo';

@ComponentV2
export struct TimePickerDemo {
  @Local selectTime: Date = new Date();

  private getAmPmTime(date: Date) {
    let hours = date.getHours();
    let minutes = date.getMinutes();
    // Determine morning or afternoon
    let ampm = hours >= 12 ? 'PM' : 'AM';
    // Convert to 12-hour format
    hours = hours % 12;
    hours = hours || 12;
    // Pad with zeros
    let hh = String(hours).padStart(2, '0');
    let mm = String(minutes).padStart(2, '0');
    return `${ampm} ${hh}:${mm}`;
  }

  build() {
    CommonItem({ val: $r('app.string.time_picker_label'), hint: this.getAmPmTime(this.selectTime) })
      .onClick(() => {
        this.getUIContext().showTimePickerDialog({
          selected: this.selectTime,
          format: TimePickerFormat.HOUR_MINUTE,
          useMilitaryTime: false,
          dateTimeOptions: {
            hour: 'numeric',
            minute: '2-digit'
          },
          onAccept: (value: TimePickerResult) => {
            // Set selectTime to the time when the confirm button is pressed,
            // so that when the popup appears again, it shows the time selected last time
            if (value.hour !== undefined && value.minute !== undefined) {
              this.selectTime.setHours(value.hour, value.minute);
              Logger.info(TAG, `TimePickerDialog:onAccept, value: ${JSON.stringify(value)}`);
            }
          }
        })
      })
  }
}