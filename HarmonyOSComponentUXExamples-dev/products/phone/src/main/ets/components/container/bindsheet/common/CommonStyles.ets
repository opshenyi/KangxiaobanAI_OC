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

import { CornerRadiusToken } from 'componentuxexamplesbase';

/**
 * Common button styles for `bindSheet`
 */
export class CommonButtonModifier implements AttributeModifier<ButtonAttribute> {
  applyNormalAttribute(instance: ButtonAttribute): void {
    instance.type(ButtonType.Normal)
      .stateEffect(true)
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .fontColor($r('sys.color.font_emphasize'))
      .fontSize($r('sys.float.Body_L'))
      .fontWeight(FontWeight.Medium)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
  }
}