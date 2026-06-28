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
import Logger from '../../../../utils/Logger';
import { SubTitleViewV2 } from '../../../../common/SubTitleView';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';

const TAG = 'DefaultToggle';

@Builder
export function DefaultToggle() {
  Column() {
    SubTitleViewV2({val: $r('app.string.default_enabled_state_label')})

    Row() {
      Text($r('app.string.toggle_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor($r('sys.color.ohos_id_color_emphasize'))
        .switchPointColor($r('sys.color.ohos_id_color_foreground_contrary'))
        .onChange((isOn: boolean) => {
          Logger.info(TAG, 'Component status:' + isOn);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .justifyContent(FlexAlign.Center)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
  }
  .width(SizeToken.SIZE_PERCENT_100)
}