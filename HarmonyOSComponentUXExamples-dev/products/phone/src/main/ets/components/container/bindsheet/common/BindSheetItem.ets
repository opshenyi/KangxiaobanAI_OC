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
import { CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct BindSheetItem {
  @Param title: ResourceStr = '';
  // Receive `bindSheet` parameter configuration
  @Param sheetOptions: SheetOptions = {};
  // Accept externally provided custom modal view
  @BuilderParam sheetBuilder: (closeSheet: () => void) => void = this.DefaultBuilder;
  // Reserved action for special scenarios (e.g., direct page routing instead of presenting a modal)
  @Param customAction?: () => void = undefined;
  // Self-managed modal state within the component
  @Local isShow: boolean = false;

  @Builder
  DefaultBuilder() {
  }

  // Add a wrapper layer to inject isShow = false capability into sheetBuilder
  @Builder
  SheetWrapper() {
    this.sheetBuilder(() => {
      this.isShow = false;
    })
  }

  build() {
    Row() {
      Text(this.title)
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
    .onClick(() => {
      // Prioritize custom actions (e.g., landscape navigation) if present
      if (this.customAction) {
        this.customAction();
      } else {
        this.isShow = true;
      }
    })
    // Attach `bindSheet` presentation logic locally
    .bindSheet(this.isShow!!, this.SheetWrapper, this.sheetOptions)
    .stateStyles({
      normal: {
        .backgroundColor(Color.Transparent)
      },
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      }
    })
  }
}