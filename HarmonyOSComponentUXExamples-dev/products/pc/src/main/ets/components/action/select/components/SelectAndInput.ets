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
import { CommonConstants, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { SelectCardStyleModifier } from '../common/CommonStyles';

const TAG = 'SelectAndInput';

// Static map: associate Select values with placeholders
const PLACEHOLDER_MAP: Record<string, string> = {
  'Phone': 'Phone number',
  'Email': 'Email address',
  'Username': 'Username'
};

@ComponentV2
export struct SelectAndInput {
  // Track dropdown value and input text
  @Local selectedContactType: ResourceStr = 'Phone';
  @Local inputValue: string = '';
  // Track placeholder state
  @Local inputPlaceholder: string = PLACEHOLDER_MAP['Phone'];
  // Extract the data source for the dropdown menu
  private readonly contactOptions: SelectOption[] = [
    { value: 'Phone' },
    { value: 'Email' },
    { value: 'Username' }
  ];

  build() {
    Column() {
      SubTitleView($r('app.string.drop_down_button_and_text_box_label'))

      Column() {
        Row({ space: SpaceToken.SPACE_16 }) {
          // Left side: Dropdown button
          Select(this.contactOptions)
            .value(this.selectedContactType)
            .controlSize(ControlSize.NORMAL)
            .avoidance(AvoidanceMode.COVER_TARGET)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .dividerStyle({
              strokeWidth: LengthMetrics.vp(0),
              color: Color.Transparent
            })
            .onSelect((_index: number, value: string) => {
              if (this.selectedContactType !== value) {
                this.selectedContactType = value;
                // Dynamically retrieve the corresponding placeholder from the mapping dictionary and update the state
                this.inputPlaceholder = PLACEHOLDER_MAP[value] || 'Please enter';
                // Clear previous mismatched input when switching types
                this.inputValue = '';
                Logger.info(TAG, `Type switched to: ${value}`);
              }
            })

          // Right side: Input box
          TextInput({ placeholder: this.inputPlaceholder, text: this.inputValue!! })
            .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
            .showUnderline(true)
            .backgroundColor(Color.Transparent)
            .fontSize($r('sys.float.Body_L'))
            .placeholderColor($r('sys.color.font_secondary'))
            .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
            .onChange((value: string) => {
              Logger.info(TAG, `Input value changed: ${value}`);
            })
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
      }
      .attributeModifier(new SelectCardStyleModifier())
    }
  }
}