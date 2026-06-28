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
import { PromptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { CommonConstants, ComponentItem, Logger, SizeToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function ToastCollectBuilder() {
  ToastCollect()
}

@ComponentV2
struct ToastCollect {
  @Local toastId: number = -1;
  private promptAction: PromptAction | undefined = undefined;
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  message: string = ''

  aboutToDisappear(): void {
    try {
      if (this.toastId !== -1) {
        this.promptAction?.closeToast(this.toastId);
        this.toastId = -1;
      }
    } catch (err) {
      Logger.error('Toast', `Failed to close the toast dialog, error info:${JSON.stringify(err)}`)
    }
    this.promptAction = undefined;
  }

  build() {
    NavDestination() {
    }
    .title({ builder: TitleComponent(this.param.name), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
      if (this.param.id === 'style_base') {
        this.message = 'AAAAAAAA'
      } else {
        this.message = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      }
      this.promptAction = this.getUIContext().getPromptAction();
      this.promptAction.openToast({
        message: this.message,
        duration: CommonConstants.DURATION_3000
      }).then((toastId: number) => {
        this.toastId = toastId;
      }).catch((err: BusinessError) => {
        Logger.error('Toast', `openToast error code is ${err.code}, message is ${err.message}`)
      })
    })
  }
}