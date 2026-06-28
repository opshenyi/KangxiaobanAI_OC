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
import { PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'EditableTitle';

@Builder
export function EditableTitle() {
  Column() {
    SubTitleView($r('app.string.editing_page_single_line_title_bar_label'), PaddingToken.PADDING_28VP)
    EditableTitleBar({
      leftIconStyle: EditableLeftIconType.Back,
      title: $r('app.string.title_en_label'),
      contentMargin: {
        start: LengthMetrics.vp(PaddingToken.PADDING_16VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_16VP)
      },
      onSave: () => {
        Logger.info(TAG, 'The save has been clicked currently.');
      }
    })
      .height(SizeToken.SIZE_NUM_56)
      .backgroundColor($r('sys.color.comp_background_list_card'))

    SubTitleView($r('app.string.editing_page_double_line_title_bar_label'), PaddingToken.PADDING_28VP)
    EditableTitleBar({
      leftIconStyle: EditableLeftIconType.Back,
      title: $r('app.string.title_en_label'),
      subtitle: $r('app.string.subtitle_en_label'),
      contentMargin: {
        start: LengthMetrics.vp(PaddingToken.PADDING_16VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_16VP)
      },
      onSave: () => {
        Logger.info(TAG, 'The save has been clicked currently.');
      }
    })
      .height(SizeToken.SIZE_NUM_56)
      .backgroundColor($r('sys.color.comp_background_list_card'))
  }
}