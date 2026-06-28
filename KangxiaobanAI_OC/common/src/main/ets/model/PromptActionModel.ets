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

import { BusinessError } from '@kit.BasicServicesKit';
import { ComponentContent, PromptAction, TargetInfo } from '@kit.ArkUI';
import Logger from '../utils/Logger';

const TAG = 'PromptActionModel';

export class PromptActionModel {
  private promptAction: PromptAction | null = null;
  private contentNode: ComponentContent<Object> | null = null;
  private options: PopupCommonOptions | null = null;
  private target: TargetInfo | null = null;
  private isPartialUpdate: boolean = false;

  public setPromptAction(promptAction: PromptAction) {
    this.promptAction = promptAction;
  }

  public setContentNode(node: ComponentContent<Object>) {
    this.contentNode = node;
  }

  public setTarget(target: TargetInfo) {
    this.target = target;
  }

  public setOptions(options: PopupCommonOptions) {
    this.options = options;
  }

  public setIsPartialUpdate(isPartialUpdate: boolean) {
    this.isPartialUpdate = isPartialUpdate;
  }

  public openPopup() {
    if (this.promptAction !== null) {
      this.promptAction.openPopup(this.contentNode, this.target, this.options)
        .then(() => {
          Logger.info(TAG, 'openPopup success');
        })
        .catch((err: BusinessError) => {
          Logger.error(TAG, 'openPopup error: ' + err.code + ' ' + err.message);
        });
    }
  }

  public closePopup() {
    if (this.promptAction !== null) {
      this.promptAction.closePopup(this.contentNode)
        .then(() => {
          Logger.info(TAG, 'closePopup success');
        })
        .catch((err: BusinessError) => {
          Logger.error(TAG, 'closePopup error: ' + err.code + ' ' + err.message);
        });
    }
  }

  public updatePopup(options: PopupCommonOptions) {
    if (this.promptAction !== null) {
      this.promptAction.updatePopup(this.contentNode, options, this.isPartialUpdate)
        .then(() => {
          Logger.info(TAG, 'updatePopup success');
        })
        .catch((err: BusinessError) => {
          Logger.error(TAG, 'updatePopup error: ' + err.code + ' ' + err.message);
        });
    }
  }
}