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
import { CommonUtils, SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

@Extend(Button)
function commonBtnStyle(role: ButtonRole = ButtonRole.NORMAL) {
  .width(SizeToken.SIZE_NUM_120)
  .height(SizeToken.SIZE_NUM_40)
  .role(role)
}

@Builder
function LoadingContent(color: Resource) {
  Row({ space: SpaceToken.SPACE_1_POINT_5 }) {
    LoadingProgress()
      .width(SizeToken.SIZE_NUM_24)
      .height(SizeToken.SIZE_NUM_24)
      .color(color)

    Text('Loading')
      .fontSize($r('sys.float.Body_L'))
      .fontWeight(FontWeight.Medium)
      .fontColor(color)
  }
}

@Builder
export function LoadingButton() {
  Column() {
    SubTitleView($r('app.string.loading_status_label'))

    Column() {
      Flex({
        space: { main: LengthMetrics.vp(SpaceToken.SPACE_12), cross: LengthMetrics.vp(SpaceToken.SPACE_16) },
        justifyContent: FlexAlign.Start
      }) {
        Button({ stateEffect: true }) {
          LoadingContent($r('sys.color.font_on_primary'))
        }
        .commonBtnStyle()
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .onClick(() => CommonUtils.showToast($r('app.string.loading_type_emphasized_button_toast_label')))

        Button({ stateEffect: true }) {
          LoadingContent($r('sys.color.font_emphasize'))
        }
        .commonBtnStyle()
        .buttonStyle(ButtonStyleMode.NORMAL)
        .onClick(() => CommonUtils.showToast($r('app.string.loading_type_normal_button_toast_label')))

        Button({ stateEffect: true }) {
          LoadingContent($r('sys.color.warning'))
        }
        .commonBtnStyle(ButtonRole.ERROR)
        .buttonStyle(ButtonStyleMode.NORMAL)
        .onClick(() => CommonUtils.showToast($r('app.string.loading_type_warning_button_toast_label')))

        Button({ stateEffect: true }) {
          LoadingContent($r('sys.color.font_emphasize'))
        }
        .commonBtnStyle()
        .buttonStyle(ButtonStyleMode.TEXTUAL)
        .onClick(() => CommonUtils.showToast($r('app.string.loading_type_textual_button_toast_label')))
      }
    }
    .attributeModifier(new ButtonCardStyleModifier())
  }
}