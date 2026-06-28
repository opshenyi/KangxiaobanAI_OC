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

import { CornerRadiusToken, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';

const TAG = 'DefaultToggle';

@Builder
export function DefaultToggle() {
  Row() {
    Text($r('app.string.toggle_label'))
      .fontColor($r('sys.color.font_primary'))
      .fontSize($r('app.float.list_item_text_size'))
      .fontWeight(FontWeight.Medium)

    Toggle({ type: ToggleType.Switch, isOn: true })
      .selectedColor($r('sys.color.ohos_id_color_emphasize'))
      .switchPointColor($r('sys.color.ohos_id_color_foreground_contrary'))
      .width(SizeToken.SIZE_NUM_48)
      .height(SizeToken.SIZE_NUM_26)
      .onChange((isOn: boolean) => {
        Logger.info(TAG, 'Component status:' + isOn);
      })
  }
  .backgroundColor($r('app.color.item_background_color'))
  .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  .hoverEffect(HoverEffect.Highlight)
  .borderWidth(SizeToken.SIZE_NUM_1)
  .borderColor($r('app.color.item_border_color'))
  .justifyContent(FlexAlign.SpaceBetween)
  .width(SizeToken.SIZE_PERCENT_100)
  .height($r('app.float.item_height_M'))
  .padding({
    left: PaddingToken.PADDING_16VP,
    right: PaddingToken.PADDING_16VP
  })
}