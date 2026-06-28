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
import { CommonConstants } from '../../constants/CommonConstants';

export class MessageBubbleModifier implements AttributeModifier<ColumnAttribute> {
  private type: number = 0;

  constructor(type: number) {
    this.type = type;
  }

  applyNormalAttribute(instance: ColumnAttribute): void {
    instance
      .height('100%')
      .margin({ left: 8 })
      .backgroundColor($r('app.color.message_detail_bubble'))
      .border({
        radius: {
          topLeft: 2,
          topRight: 24,
          bottomLeft: 24,
          bottomRight: 24
        }
      })
    if (this.type === CommonConstants.MESSAGE_BUBBLE_STYLE_1) {
      instance
        .width(214)
      return;
    }
    if (this.type === CommonConstants.MESSAGE_BUBBLE_STYLE_2) {
      instance
        .width(248)
      return;
    }
    if (this.type === CommonConstants.MESSAGE_BUBBLE_STYLE_3) {
      instance
        .width(164)
        .backgroundColor($r('app.color.background_emphasize'))
        .margin({ left: 0, right: 8 })
        .border({
          radius: {
            topLeft: 24,
            topRight: 2,
            bottomLeft: 24,
            bottomRight: 24
          }
        })
    }
  }
}