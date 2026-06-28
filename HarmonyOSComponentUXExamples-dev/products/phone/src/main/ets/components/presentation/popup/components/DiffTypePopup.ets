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
import { CommonListRow, CornerRadiusToken, SizeToken, SubTitleView as GroupHeader } from 'componentuxexamplesbase';

@ComponentV2
export struct DiffTypePopup {
  @Local subTitleName: ResourceStr = $r('app.string.type_label');
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();

  @Styles
  commonListItemStyles() {
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

  build() {
    ListItemGroup({
      header: GroupHeader(this.subTitleName, undefined, $r('app.color.default_background_color'))
    }) {
      ListItem() {
        CommonListRow({
          title: $r('app.string.directional_label'),
          onClickAction: () => {
            this.navPathStack.pushPath({ name: 'DirectionalPopup' });
          }
        })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.embedded_label'),
          onClickAction: () => {
            this.navPathStack.pushPath({ name: 'EmbeddedPopup' });
          }
        })
      }
      .commonListItemStyles()
    }
    .divider({
      strokeWidth: SizeToken.SIZE_NUM_12,
      color: $r('sys.color.background_secondary'),
    })
  }
}