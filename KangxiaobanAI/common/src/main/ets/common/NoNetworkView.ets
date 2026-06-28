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

import type { common, Want } from '@kit.AbilityKit';
import { CommonConstants } from '../constants/CommonConstants';
import { SizeToken } from '../designtoken/SizeToken';
import { BreakpointType } from '../model/BreakpointType';
import Logger from '../utils/Logger';
import { ProcessUtil } from '../utils/ProcessUtil';

const TAG: string = '[NoNetworkView]';

@Builder
export function NoNetworkView(breakpoint: WidthBreakpoint, uiContext: UIContext, handleReload?: () => void) {
  GridRow({ columns: { sm: SizeToken.SIZE_NUM_4, md: SizeToken.SIZE_NUM_8, lg: SizeToken.SIZE_NUM_12 } }) {
    GridCol({
      span: { sm: SizeToken.SIZE_NUM_4, md: SizeToken.SIZE_NUM_6, lg: SizeToken.SIZE_NUM_6 },
      offset: { sm: CommonConstants.INTEGER_0, md: CommonConstants.INTEGER_1, lg: CommonConstants.INTEGER_3 },
    }) {
      Column() {
        Row()
          .height(SizeToken.SIZE_NUM_72)
        Column() {
          Image($r('app.media.ic_failure'))
            .draggable(false)
            .width(new BreakpointType({
              sm: 120,
              md: 160,
              lg: 180,
            }).getValue(breakpoint))
            .aspectRatio(1)
          Text($r('app.string.network_error'))
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_M'))
            .margin({ top: $r('sys.float.padding_level4') })
        }

        Button($r('app.string.network_setting'),
          { buttonStyle: ButtonStyleMode.NORMAL, controlSize: ControlSize.NORMAL })
          .width(SizeToken.SIZE_PERCENT_100)
          .onClick(() => {
            const context: Context | undefined = uiContext.getHostContext();
            if (!context) {
              Logger.error(TAG, `Jump to settings failed. Cause context is undefined`);
              return;
            }
            const want: Want = {
              bundleName: 'com.huawei.hmos.settings',
              abilityName: 'com.huawei.hmos.settings.MainAbility',
              uri: 'wifi_entry',
            };
            ProcessUtil.startAbility(context as common.UIAbilityContext, want);
          })
          .margin({ bottom: SizeToken.SIZE_NUM_72 })
      }
      .onClick(() => handleReload?.())
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding($r('sys.float.padding_level8'))
      .backgroundColor($r('sys.color.background_secondary'))
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}