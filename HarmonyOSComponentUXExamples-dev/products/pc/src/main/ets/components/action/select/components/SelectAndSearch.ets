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

const TAG = 'SelectAndSearch';

@ComponentV2
export struct SelectAndSearch {
  // State management: category selection and search keyword
  @Local selectedCategory: ResourceStr = 'Select';
  @Local searchValue: string = '';
  // Extract dropdown data source (mock search categories)
  private readonly categoryOptions: SelectOption[] = [
    { value: 'All' },
    { value: 'Images' },
    { value: 'Videos' },
    { value: 'Articles' }
  ];

  build() {
    Column() {
      SubTitleView($r('app.string.drop_down_button_and_search_box_label'))

      Column() {
        Row({ space: SpaceToken.SPACE_16 }) {
          // Left: Dropdown button (content area)
          Select(this.categoryOptions)
            .value(this.selectedCategory)
            .controlSize(ControlSize.NORMAL)
            .avoidance(AvoidanceMode.COVER_TARGET)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .dividerStyle({
              strokeWidth: LengthMetrics.vp(0),
              color: Color.Transparent
            })
            .onSelect((_index: number, value: string) => {
              if (this.selectedCategory !== value) {
                this.selectedCategory = value;
                Logger.info(TAG, `Search category switched to: ${value}`);
              }
            })

          // Right: Search box
          Search({ value: this.searchValue!!, placeholder: 'Search...' })
            .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .placeholderColor($r('sys.color.font_secondary'))
            .textFont({ size: $r('sys.float.Body_L') })
            .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
            .onChange((value: string) => {
              Logger.info(TAG, `Search typing: ${value}`);
            })
            .onSubmit((searchContent: string) => {
              Logger.info(TAG,
                `Submit search: [${searchContent}] in category [${this.selectedCategory}]`);
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