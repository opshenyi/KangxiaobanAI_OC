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

import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

@Builder
export function MultiLineTextBox() {
  Column() {
    SubTitleView($r('app.string.multi_line_text_box_label'))

    Column({ space: SpaceToken.SPACE_10 }) {

      // Scenario 1: Expandable container height
      // No fixed height is set; maxLines is used to limit the maximum number of lines.
      // The container expands automatically with input content. After exceeding 10 lines,
      // internal adaptive scrolling is enabled with scrollbar display.
      TextArea({
        text: 'A'.repeat(210),
        placeholder: $r('app.string.textinput_placeholder_label_4')
      })
        .width(SizeToken.SIZE_PERCENT_100)
        .textOverflow(TextOverflow.Clip)
        .maxLines(CommonConstants.INTEGER_10, { overflowMode: MaxLinesMode.SCROLL })
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

      // Scenario 2: Fixed container height
      // A fixed height is set. By default, it displays as a multi-line input box height.
      // When input content exceeds the fixed height, it automatically wraps, moves upward,
      // and enables internal adaptive scrolling with scrollbar display.
      TextArea({
        text: 'A'.repeat(7),
        placeholder: $r('app.string.textinput_placeholder_label_4')
      })
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_94)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

      // Scenario 3: Demonstrates the counter functionality
      TextArea({
        text: 'A'.repeat(100),
        placeholder: $r('app.string.textinput_placeholder_label_4')
      })
        .width(SizeToken.SIZE_PERCENT_100)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        .showCounter(true, { thresholdPercentage: CommonConstants.TEXT_THRESHOLD_PERCENTAGE, highlightBorder: true })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_16VP,
      bottom: PaddingToken.PADDING_16VP
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
}