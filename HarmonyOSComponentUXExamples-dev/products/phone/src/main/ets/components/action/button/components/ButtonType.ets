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
import {
  CommonConstants, CommonUtils, SizeToken, SpaceToken, SubTitleView
} from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

@Extend(Button)
function commonBtnStyle(role: ButtonRole = ButtonRole.NORMAL) {
  .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
  .height(SizeToken.SIZE_NUM_40)
  .role(role)
}

@Builder
export function ButtonType() {
  Column() {
    SubTitleView($r('app.string.button_type_label'))

    Column({ space: SpaceToken.SPACE_16 }) {
      Row({ space: SpaceToken.SPACE_12 }) {
        Button($r('app.string.emphasize_en_label'))
          .commonBtnStyle()
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .onClick(() => CommonUtils.showToast($r('app.string.emphasized_button_toast_label')))

        Button($r('app.string.normal_en_label'))
          .commonBtnStyle()
          .buttonStyle(ButtonStyleMode.NORMAL)
          .onClick(() => CommonUtils.showToast($r('app.string.normal_button_toast_label')))
      }

      Row({ space: SpaceToken.SPACE_12 }) {
        Button($r('app.string.warning_en_label'))
          .commonBtnStyle(ButtonRole.ERROR)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .onClick(() => CommonUtils.showToast($r('app.string.warning_button_toast_label')))

        Button($r('app.string.text_en_label'))
          .commonBtnStyle()
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .onClick(() => CommonUtils.showToast($r('app.string.textual_button_toast_label')))
      }
    }
    .attributeModifier(new ButtonCardStyleModifier())
  }
}