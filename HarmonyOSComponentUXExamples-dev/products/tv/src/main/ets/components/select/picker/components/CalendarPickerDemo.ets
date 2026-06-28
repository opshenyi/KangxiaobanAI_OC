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

const TAG = 'CalendarPickerDemo';

@ComponentV2
export struct CalendarPickerDemo {
  private selectedDate: Date = new Date('2026-01-01');

  build() {
    CalendarPicker({ selected: this.selectedDate })
      .edgeAlign(CalendarAlign.END)
      .onChange((value) => {
        Logger.info(TAG, `CalendarPicker:onChange, value: ${JSON.stringify(value)}`);
      })
  }
}