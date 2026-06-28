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
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SubTitleView as GroupHeader } from '../../../../common/SubTitleView';

/**
 * Formats a Date object into a "YYYY/MM/DD" string.
 * Placed outside the component to follow the principle of minimal scope.
 *
 * @param {Date} date - The Date object to format
 * @returns {string} Formatted date string (e.g., "2024/03/14")
 */
function formatDateYYYYMMDD(date: Date): string {
  const year = date.getFullYear();
  // Month is 0-indexed, add 1 and pad with leading zero if necessary
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  return `${year}/${month}/${day}`;
}

@ComponentV2
export struct CalendarStylePicker {
  // Add local state to dynamically track the selected date (initialized to match your attachment)
  @Local selectedDate: Date = new Date('2024-03-14T00:00:00');

  @Styles
  commonListItemStyles() {
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_24)
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
      header: GroupHeader($r('app.string.date_picker_in_the_calendar_label'), undefined,
        $r('app.color.default_background_color'))
    }) {
      ListItem() {
        Row() {
          // Replaced hardcoded text with dynamically formatted state
          Text(formatDateYYYYMMDD(this.selectedDate))
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Regular)

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            SymbolGlyph($r('sys.symbol.calendar'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_primary')])
          }
          .backgroundColor(Color.Transparent)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_40)
        .padding({
          left: PaddingToken.PADDING_16VP,
          right: PaddingToken.PADDING_16VP
        })
        .onClick(() => {
          // Trigger the native CalendarPickerDialog
          CalendarPickerDialog.show({
            selected: this.selectedDate,
            onAccept: (value: Date) => {
              // Update the local state when the user confirms a new date
              this.selectedDate = value;
            }
          });
        })
      }
      .commonListItemStyles()
    }
  }
}