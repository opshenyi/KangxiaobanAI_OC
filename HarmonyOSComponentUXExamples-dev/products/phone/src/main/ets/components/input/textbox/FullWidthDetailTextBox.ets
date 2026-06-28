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
import { LengthMetrics } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { BreakpointModel, CommonConstants, ComponentItem, HdsUtil, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { TextBoxStorage } from './model/TextBoxStorage';
import { HdsNavDestination } from '@kit.UIDesignKit';

const TAG = 'FullWidthDetailTextBox';

@Builder
export function FullWidthDetailTextBoxBuilder(_name: ResourceStr, param: TextBoxStorage) {
  FullWidthDetailTextBox({ storage: param })
}

@ComponentV2
export struct FullWidthDetailTextBox {
  @Require @Param storage: TextBoxStorage;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };
  private controller: TextAreaController = new TextAreaController();

  @Computed
  get horizontalPadding(): number {
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_0VP,
      md: PaddingToken.PADDING_0VP,
      lg: PaddingToken.PADDING_8VP
    }) as number;
  }

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  build() {
    HdsNavDestination() {
      Scroll() {
        Column() {
          TextArea({
            text: this.storage.text!!,
            placeholder: $r('app.string.textarea_placeholder_label_1'),
            controller: this.controller
          })
            .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_PERCENT_100)
            .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              Logger.info(TAG, `The content length of the input field is: ${value.length}`);
            })
        }
        .padding({
          top: PaddingToken.PADDING_18VP,
          left: this.horizontalPadding,
          right: this.horizontalPadding
        })
      }
      .scrollBar(BarState.Off)
      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .backgroundColor($r('sys.color.background_secondary'))
    // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .titleBar({
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: {
        title: {
          mainTitle: $r('app.string.full_width_text_box_label'),
          subTitle: $r('app.string.time_label_1')
        },
        menu: {
          value: [{
            content: {
              icon: $r('sys.symbol.checkmark'),
              isEnabled: true,
              action: () => {
                if (this.controller) {
                  this.controller.stopEditing();
                }
              }
            }
          }]
        }
      }
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}