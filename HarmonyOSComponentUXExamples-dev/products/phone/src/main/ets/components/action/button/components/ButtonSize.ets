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
import { CommonUtils, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

@Builder
export function ButtonSize() {
  Column() {
    SubTitleView($r('app.string.button_size_label'))

    Column() {
      Flex({
        alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.Start,
        space: { main: LengthMetrics.vp(SpaceToken.SPACE_12) }
      }) {
        Button($r('app.string.medium_en_label'),
          { controlSize: ControlSize.NORMAL, buttonStyle: ButtonStyleMode.EMPHASIZED })
          .onClick(() => CommonUtils.showToast($r('app.string.medium_sized_button_toast_label')))

        Button($r('app.string.small_en_label'),
          { controlSize: ControlSize.SMALL, buttonStyle: ButtonStyleMode.EMPHASIZED })
          .onClick(() => CommonUtils.showToast($r('app.string.small_sized_button_toast_label')))
      }
    }
    .attributeModifier(new ButtonCardStyleModifier())
  }
}