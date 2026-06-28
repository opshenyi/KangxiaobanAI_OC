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
import { CornerRadiusToken, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';

@ComponentV2
export struct BasicStyleCheckBox {
  @Local checkBoxVal1: Resource = $r('app.string.selected_label');
  @Local checkBoxVal2: Resource = $r('app.string.not_selected_label');
  @Local selectIndex: number = 0;
  
  build() {
    Column() {
      SubTitleView($r('app.string.basic_style_label'))

      Row() {
        Column({ space: SpaceToken.SPACE_4 }) {
          Text(this.checkBoxVal1)
            .fontColor($r('sys.color.font_primary'))

          Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
            .select(this.selectIndex === 0)
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectIndex = 0;
                this.checkBoxVal1 = $r('app.string.selected_label');
              } else {
                this.checkBoxVal1 = $r('app.string.not_selected_label');
              }
            })
        }
        .width(SizeToken.SIZE_NUM_100)

        Column({ space: SpaceToken.SPACE_4 }) {
          Text(this.checkBoxVal2)
            .fontColor($r('sys.color.font_primary'))

          Checkbox({ name: 'checkbox2', group: 'checkboxGroup' })
            .select(this.selectIndex === 1)
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectIndex = 1;
                this.checkBoxVal2 = $r('app.string.selected_label');
              } else {
                this.checkBoxVal2 = $r('app.string.not_selected_label');
              }
            })
        }
        .width(SizeToken.SIZE_NUM_100)
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