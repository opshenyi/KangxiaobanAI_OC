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

import { CommonConstants, Logger, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { CommonItem } from '../../../common/CommonItem';
import { ListGroupTitle } from '../../../common/ListGroupTitle';
import { TVConstants } from '../../../../constants/TVConstants';

const TAG = 'DifPositionToast';

@Builder
export function DifPositionToast(uiContext: UIContext) {
  Column() {
    ListGroupTitle($r('app.string.popup_position_label'))
    Column({ space: SpaceToken.SPACE_16 }) {
      CommonItem({ val: $r('app.string.bottom_hint_label') })
        .onClick(() => {
          uiContext.getPromptAction().openToast({
            message: $r('app.string.toast_message_short'),
            duration: CommonConstants.DURATION_3000,
            alignment: Alignment.Bottom,
            offset: {
              dx: 0,
              dy: uiContext.vp2px(TVConstants.TOAST_OFFSET_BOTTOM)
            },
          }).then((toastId: number) => {
            Logger.info(TAG, `DifPositionToast bottom hint toastId is: ${toastId}`);
          }).catch((err: BusinessError) => {
            Logger.error(TAG, `openToast error code is ${err.code}, message is ${err.message}`);
          })
        })
      CommonItem({ val: $r('app.string.top_hint_label') })
        .onClick(() => {
          uiContext.getPromptAction().openToast({
            message: $r('app.string.toast_message_short'),
            duration: CommonConstants.DURATION_3000,
            alignment: Alignment.Top,
            offset: {
              dx: 0,
              dy: uiContext.vp2px(TVConstants.TOAST_OFFSET_TOP)
            },
          }).then((toastId: number) => {
            Logger.info(TAG, `DifPositionToast top hint toastId is: ${toastId}`);
          }).catch((err: BusinessError) => {
            Logger.error(TAG, `openToast error code is ${err.code}, message is ${err.message}`);
          })
        })

    }
  }
  .width(SizeToken.SIZE_PERCENT_100)
}