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

import { EditableLeftIconType, EditableTitleBar, LengthMetrics } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { BreakpointModel, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'EditableTitle';

@ComponentV2
export struct EditableTitle {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  build() {
    Column() {
      SubTitleView($r('app.string.edit_page_title_bar_label'), PaddingToken.PADDING_28VP)
      EditableTitleBar({
        leftIconStyle: EditableLeftIconType.Cancel,
        title: $r('app.string.edit_label'),
        contentMargin: {
          start: this.horizontalPaddingLength,
          end: this.horizontalPaddingLength
        },
        menuItems: [],
        imageItem: {
          value: '',
          isEnabled: true
        },
        onSave: () => {
          Logger.info(TAG, 'The save has been clicked currently.');
        }
      })
        .height(SizeToken.SIZE_NUM_56)
        .backgroundColor($r('sys.color.comp_background_list_card'))
    }
  }
}