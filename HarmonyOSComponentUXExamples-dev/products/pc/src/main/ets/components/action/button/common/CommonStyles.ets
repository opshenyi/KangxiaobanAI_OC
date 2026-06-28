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
import { CornerRadiusToken, PaddingToken } from 'componentuxexamplesbase';

/**
 * Parent container card style for the Button component
 */
export class ButtonCardStyleModifier implements AttributeModifier<ColumnAttribute> {
  applyNormalAttribute(instance: ColumnAttribute): void {
    instance.backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .padding({
        left: PaddingToken.PADDING_12VP,
        right: PaddingToken.PADDING_12VP,
        top: PaddingToken.PADDING_16VP,
        bottom: PaddingToken.PADDING_16VP
      })
  }
}