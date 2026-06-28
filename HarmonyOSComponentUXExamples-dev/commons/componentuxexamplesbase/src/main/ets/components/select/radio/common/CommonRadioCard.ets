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

import { SubTitleView } from '../../../../common/SubTitleView';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';

@ComponentV2
export struct CommonRadioCard {
  // Externally passed configuration options
  @Require @Param title: Resource;
  @Require @Param groupName: string;
  @Require @Param indicatorType: RadioIndicatorType;
  // Internal state
  @Local selectedValue: string = 'Radio1';

  @Builder
  RadioItem(itemValue: string) {
    Column({ space: SpaceToken.SPACE_4 }) {
      Text(this.selectedValue === itemValue ? $r('app.string.selected_label') : $r('app.string.not_selected_label'))
        .fontColor($r('sys.color.font_primary'))

      Radio({
        value: itemValue,
        group: this.groupName,
        indicatorType: this.indicatorType
      })
        .checked(this.selectedValue === itemValue)
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.selectedValue = itemValue;
          }
        })
    }
    .width(SizeToken.SIZE_NUM_100)
  }

  build() {
    Column() {
      SubTitleView(this.title)

      Row() {
        this.RadioItem('Radio1')
        this.RadioItem('Radio2')
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_83)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}