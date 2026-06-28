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
import { LengthMetrics } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { CommonConstants, SizeToken, SubTitleView } from 'componentuxexamplesbase';
import { SelectCardStyleModifier } from '../common/CommonStyles';

const TAG = 'InputAndUnitSelect';

@ComponentV2
export struct InputAndUnitSelect {
  // Independent state management: input value and selected unit
  @Local inputValue: string = '';
  // Default selected unit: MB
  @Local selectedUnit: ResourceStr = 'MB';
  // Dropdown data source
  private readonly unitOptions: SelectOption[] = [
    { value: 'KB' },
    { value: 'MB' },
    { value: 'GB' },
    { value: 'TB' }
  ];

  @Builder
  UnitSelectBuilder() {
    Select(this.unitOptions)
      .value(this.selectedUnit)
      .controlSize(ControlSize.NORMAL)
      .avoidance(AvoidanceMode.COVER_TARGET)
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .dividerStyle({
        strokeWidth: LengthMetrics.vp(0),
        color: Color.Transparent
      })
      .onSelect((_index: number, value: string) => {
        if (this.selectedUnit !== value) {
          this.selectedUnit = value;
          Logger.info(TAG, `Unit switched to: ${value}`);
        }
      })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.unit_switch_label'))

      Column() {
        TextInput({ placeholder: 'Package Traffic', text: this.inputValue!! })
          .width(SizeToken.SIZE_PERCENT_100)
          .showUnderline(true)
          .backgroundColor(Color.Transparent)
          .fontSize($r('sys.float.Body_L'))
          .placeholderColor($r('sys.color.font_secondary'))
          .showUnit(this.UnitSelectBuilder)
          .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
          .onChange((value: string) => {
            Logger.info(TAG, `Input traffic value changed: ${value}`);
          })
      }
      .attributeModifier(new SelectCardStyleModifier())
    }
  }
}