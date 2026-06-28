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

import { ComponentContent, LengthMetrics, PromptAction } from '@kit.ArkUI';
import { HdsNavDestination } from '@kit.UIDesignKit';
import { Popup, PopupButtonOptions, PopupIconOptions, PopupTextOptions } from '@ohos.arkui.advanced.Popup';
import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  PromptActionModel,
  SizeToken
} from 'componentuxexamplesbase';

@Builder
export function DirectionalPopupBuilder() {
  DirectionalPopup()
}

class Params {
  public text: string = '';
  public promptActionModel: PromptActionModel = new PromptActionModel();

  constructor(text: string, promptActionModel: PromptActionModel) {
    this.text = text;
    this.promptActionModel = promptActionModel;
  }
}

@Builder
function CommonPopupStyle(params: Params) {
  Row() {
    Popup({
      maxWidth: SizeToken.SIZE_NUM_312,
      icon: {
        image: $r('app.media.startIcon'),
        width: SizeToken.SIZE_NUM_32,
        height: SizeToken.SIZE_NUM_32,
        borderRadius: CornerRadiusToken.CORNER_RADIUS_8
      } as PopupIconOptions,
      title: {
        text: $r('app.string.title_en_label'),
        fontSize: $r('sys.float.Subtitle_M'),
        fontColor: $r('sys.color.font_primary'),
        fontWeight: FontWeight.Medium
      } as PopupTextOptions,
      message: {
        text: params.text,
        fontSize: $r('sys.float.Body_M'),
        fontColor: $r('sys.color.font_secondary'),
        fontWeight: FontWeight.Regular
      } as PopupTextOptions,
      showClose: true,
      onClose: () => {
        params.promptActionModel.closePopup();
      },
      buttons: [{
        text: $r('app.string.confirm_en_label'),
        action: () => {
          CommonUtils.showToast('confirm button click.');
        },
        fontSize: $r('sys.float.Body_M'),
        fontColor: $r('sys.color.font_emphasize')
      },
        {
          text: $r('app.string.cancel_en_label'),
          action: () => {
            CommonUtils.showToast('cancel button click.');
          },
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_emphasize')
        }] as [PopupButtonOptions?, PopupButtonOptions?]
    })
  }
}

@ComponentV2
struct DirectionalPopup {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local message: string = 'A'.repeat(50);
  private promptAction: PromptAction = this.getUIContext().getPromptAction();
  private promptActionModel: PromptActionModel = new PromptActionModel();
  private readonly targetId: string = 'id_directional_popup';
  // Note: Since the `CommonPopupStyle` custom component nests a @Builder component,
  // the nestingBuilderSupported parameter must be set to true when creating the ComponentContent.
  private contentNode: ComponentContent<Object> =
    new ComponentContent(this.getUIContext(), wrapBuilder(CommonPopupStyle),
      new Params(this.message, this.promptActionModel), { nestingBuilderSupported: true });
  private options: PopupCommonOptions = { enableArrow: true };

  // Extract common horizontal margin logic via `@Computed`
  @Computed
  get horizontalPadding(): number {
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }) as number;
  }

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.horizontalPadding);
  }

  build() {
    HdsNavDestination() {
    }
    .titleBar({
      content: {
        title: {
          mainTitle: $r('app.string.directional_label')
        },
        menu: {
          value: [{
            content: {
              icon: $r('sys.symbol.dot_grid_2x2'),
              isEnabled: true,
              componentId: this.targetId,
              action: () => {
                this.promptActionModel.setPromptAction(this.promptAction);
                this.promptActionModel.setContentNode(this.contentNode);
                this.promptActionModel.setOptions(this.options);
                this.promptActionModel.setIsPartialUpdate(false);
                this.promptActionModel.setTarget({ id: this.targetId });
                this.promptActionModel.openPopup();
              }
            }
          }]
        }
      },
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle()
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}