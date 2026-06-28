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

import { HdsNavDestination } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { Popup, PopupButtonOptions, PopupIconOptions, PopupTextOptions } from '@ohos.arkui.advanced.Popup';
import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken
} from 'componentuxexamplesbase';

@Builder
export function EmbeddedPopupBuilder() {
  EmbeddedPopup()
}

@ComponentV2
struct EmbeddedPopup {
  @Local handlePopup: boolean = true;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();

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

  @Builder
  CommonPopupStyle() {
    Row() {
      Popup({
        maxWidth: '100%',
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
          text: 'A'.repeat(50),
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_secondary'),
          fontWeight: FontWeight.Regular
        } as PopupTextOptions,
        showClose: true,
        onClose: () => {
          if (this.handlePopup) {
            this.handlePopup = false;
          }
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
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.comp_background_tertiary'))
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
    .margin({ top: PaddingToken.PADDING_8VP })
  }

  build() {
    HdsNavDestination() {
      Column() {
        if (this.handlePopup) {
          this.CommonPopupStyle()
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: this.horizontalPadding,
        right: this.horizontalPadding
      })
    }
    .titleBar({
      content: {
        title: {
          mainTitle: $r('app.string.bottom_tab_bar_label')
        },
        menu: {
          value: [{
            content: {
              icon: $r('sys.symbol.dot_grid_2x2'),
              isEnabled: true,
              action: () => {
                CommonUtils.showToast('The dot button has been clicked currently.');
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