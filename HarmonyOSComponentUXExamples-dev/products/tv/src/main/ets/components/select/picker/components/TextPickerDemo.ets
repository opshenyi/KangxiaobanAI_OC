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
import { CITY_DATA } from '../constant/Constants';
import { CustomContentDialog, LengthMetrics } from '@kit.ArkUI';
import { Logger, SizeToken } from 'componentuxexamplesbase';

const TAG = 'TextPickerDemo';

@ComponentV2
export struct TextPickerDemo {
  private selectedIndex: number | number[] = [0, 0, 0];
  private tempValue: string[] = ['Hubei', 'Wuhan', 'Jiang\'an'];
  private tempIndex: number | number[] = [0, 0, 0];
  @Local selectedValue: string = this.transformSelectedValue(this.tempValue);

  private transformSelectedValue(selectedStr: string[]): string {
    let result: string = '';
    for (let i = 0; i < selectedStr.length; i++) {
      result += ' ' + selectedStr[i];
    }
    return result;
  }

  private cascadeColumnWidths: LengthMetrics[] = [
    LengthMetrics.percent(SizeToken.SIZE_NUM_35),
    LengthMetrics.percent(SizeToken.SIZE_NUM_35),
    LengthMetrics.percent(SizeToken.SIZE_NUM_35)
  ];

  // Custom popup content area
  @Builder
  buildContent(): void {
    TextPicker({ range: CITY_DATA, selected: this.selectedIndex, columnWidths: this.cascadeColumnWidths })
      .width(SizeToken.SIZE_PERCENT_100)
      .disappearTextStyle({ font: { size: 22 } })
      .textStyle({ font: { size: 26 } })
      .selectedTextStyle({ font: { size: 30 } })
      .onChange((value: string | string[], index: number | number[]) => {
        if (value instanceof Array) {
          this.tempValue = value;
        }
        this.tempIndex = index;
      })
  }

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: $r('app.string.select_city_label'),
      contentBuilder: () => {
        this.buildContent();
      },
      buttons: [
        {
          value: $r('app.string.cancel_label'),
          buttonStyle: ButtonStyleMode.NORMAL,
          role: ButtonRole.NORMAL,
          action: () => {
            Logger.info(TAG, 'Callback when the cancel is button clicked');
          }
        },
        {
          value: $r('app.string.confirm_label'),
          buttonStyle: ButtonStyleMode.NORMAL,
          role: ButtonRole.NORMAL,
          action: () => {
            Logger.info(TAG, 'Callback when the confirm button is clicked');
            this.selectedValue = this.transformSelectedValue(this.tempValue);
            this.selectedIndex = this.tempIndex;
          }
        }
      ],
    }),
  });

  build() {
    CommonItem({ val: $r('app.string.text_picker_label'), hint: this.selectedValue })
      .onClick(() => {
        this.dialogController.open();
      })
  }
}