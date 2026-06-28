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
import { CommonUtils, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { CommonButtonModifier } from '../common/CommonStyles';

@Builder
export function BindSheetEmptyPageBuilder() {
  BindSheetEmptyPage()
}

@ComponentV2
struct BindSheetEmptyPage {
  private ctx: Context | undefined = undefined;
  // Save the callback function passed from routing
  private closeSheetCallback?: () => void;

  aboutToAppear(): void {
    this.ctx = this.getUIContext().getHostContext();
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Button({ stateEffect: true }) {
            SymbolGlyph($r('sys.symbol.xmark'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_primary')])
          }
          .backgroundColor(Color.Transparent)
          .width(SizeToken.SIZE_NUM_40)
          .height(SizeToken.SIZE_NUM_40)
          .onClick(() => {
            // Invoke the callback from parent to dismiss the modal on tap
            if (this.closeSheetCallback) {
              this.closeSheetCallback();
            }
          })
        }
        .justifyContent(FlexAlign.End)
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_56)

        Row() {
          Button($r('app.string.action_button_label'))
            .attributeModifier(new CommonButtonModifier())
            .width(SizeToken.SIZE_NUM_120)
            .height(SizeToken.SIZE_NUM_40)
            .onClick(() => {
              CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
                $r('app.string.action_button_label'))}`);
            })
        }
        .justifyContent(FlexAlign.End)
        .width(SizeToken.SIZE_PERCENT_100)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        top: PaddingToken.PADDING_8VP,
        right: PaddingToken.PADDING_24VP,
        bottom: PaddingToken.PADDING_24VP
      })
    }
    .backgroundColor($r('sys.color.background_primary'))
    // Retrieve params passed from outer scope
    .onReady((context: NavDestinationContext) => {
      const params = context.pathInfo.param as Record<string, Object>;
      if (params && params['closeSheet']) {
        this.closeSheetCallback = params['closeSheet'] as () => void;
      }
    })
  }
}