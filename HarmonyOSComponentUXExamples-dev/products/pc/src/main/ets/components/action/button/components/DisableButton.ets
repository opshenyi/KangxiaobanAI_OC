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
import { SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

@Extend(Button)
function disabledBtnStyle(role: ButtonRole = ButtonRole.NORMAL) {
  .width(SizeToken.SIZE_NUM_120)
  .height(SizeToken.SIZE_NUM_40)
  .stateEffect(false)
  .hoverEffect(HoverEffect.None)
  .enabled(false)
  .role(role)
}

@Builder
export function DisableButton() {
  Column() {
    SubTitleView($r('app.string.disabled_status_or_disable_label'))

    Column() {
      Flex({
        space: { main: LengthMetrics.vp(SpaceToken.SPACE_12), cross: LengthMetrics.vp(SpaceToken.SPACE_16) },
        justifyContent: FlexAlign.Start
      }) {
        Button($r('app.string.disable_en_label'))
          .disabledBtnStyle()
          .buttonStyle(ButtonStyleMode.EMPHASIZED)

        Button($r('app.string.disable_en_label'))
          .disabledBtnStyle()
          .buttonStyle(ButtonStyleMode.NORMAL)

        Button($r('app.string.disable_en_label'))
          .disabledBtnStyle(ButtonRole.ERROR)
          .buttonStyle(ButtonStyleMode.NORMAL)

        Button($r('app.string.disable_en_label'))
          .disabledBtnStyle()
          .buttonStyle(ButtonStyleMode.TEXTUAL)
      }
    }
    .attributeModifier(new ButtonCardStyleModifier())
  }
}