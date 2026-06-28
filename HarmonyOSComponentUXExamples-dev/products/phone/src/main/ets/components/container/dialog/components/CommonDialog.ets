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

import { CornerRadiusToken, SizeToken, SubTitleView as GroupHeader } from 'componentuxexamplesbase';
import { ActionDialog } from './ActionDialog';
import { CustomSelectDialog } from './CustomSelectDialog';
import { GraphicDialog } from './GraphicDialog';
import { InputDialog } from './InputDialog';
import { MessageDialog } from './MessageDialog';

@Extend(ListItem)
function commonListItemStyles() {
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .stateStyles({
    normal: {
      .backgroundColor($r('sys.color.comp_background_list_card'))
    },
    pressed: {
      .backgroundColor($r('app.color.list_item_pressed_color'))
    }
  })
}

@Builder
export function CommonDialog() {
  ListItemGroup({
    header: GroupHeader($r('app.string.common_dialog_label'), undefined,
      $r('app.color.default_background_color'))
  }) {
    ListItem() {
      CustomSelectDialog()
    }
    .commonListItemStyles()

    ListItem() {
      GraphicDialog()
    }
    .commonListItemStyles()

    ListItem() {
      InputDialog()
    }
    .commonListItemStyles()

    ListItem() {
      MessageDialog()
    }
    .commonListItemStyles()

    ListItem() {
      ActionDialog()
    }
    .commonListItemStyles()
  }
  .divider({
    strokeWidth: SizeToken.SIZE_NUM_12,
    color: $r('sys.color.background_secondary'),
  })
}