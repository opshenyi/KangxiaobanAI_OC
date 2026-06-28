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

const TAG = 'DatePickerDemo';

@ComponentV2
export struct DatePickerDemo {
  @Local selectedDate: Date = new Date();

  build() {
    CommonItem({ val: $r('app.string.date_picker_label'), hint: this.selectedDate.toLocaleDateString() })
      .onClick(() => {
        this.getUIContext().showDatePickerDialog({
          start: new Date('2000-01-01'),
          end: new Date('2100-12-31'),
          selected: this.selectedDate,
          mode: DatePickerMode.DATE,
          onDateAccept: (value: Date) => {
            // Save the date when the confirm button is pressed,
            // so that when the popup appears again, it shows the date that was confirmed last time
            this.selectedDate = value;
            Logger.info(TAG, `DatePickerDemo:onAccept, value: ${JSON.stringify(value)}`);
          }
        })
      })
  }
}