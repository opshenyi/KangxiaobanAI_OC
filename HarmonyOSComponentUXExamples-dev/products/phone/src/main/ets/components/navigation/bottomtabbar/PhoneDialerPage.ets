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
import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken
} from 'componentuxexamplesbase';

/**
 * Represents the data structure for a single key on the dialpad.
 */
interface KeyItem {
  /**
   * Unique identifier
   */
  id: string;

  /**
   * The primary character or symbol displayed on the key
   * (e.g., numbers '0'-'9', or symbols like '*' and '#').
   */
  main: ResourceStr;

  /**
   * The secondary label or icon associated with the key
   * (e.g., alphabetic characters like 'ABC', or specific system symbols).
   */
  sub: Resource;
}

// Dialer interface data source
const DIALER_DATA: KeyItem[] = [
  { id: 'dial_button_1', main: '1', sub: $r('sys.symbol.recordingtape') },
  { id: 'dial_button_2', main: '2', sub: $r('app.string.abc_label') },
  { id: 'dial_button_3', main: '3', sub: $r('app.string.def_label') },
  { id: 'dial_button_4', main: '4', sub: $r('app.string.ghi_label') },
  { id: 'dial_button_5', main: '5', sub: $r('app.string.jkl_label') },
  { id: 'dial_button_6', main: '6', sub: $r('app.string.mno_label') },
  { id: 'dial_button_7', main: '7', sub: $r('app.string.pqrs_label') },
  { id: 'dial_button_8', main: '8', sub: $r('app.string.tuv_label') },
  { id: 'dial_button_9', main: '9', sub: $r('app.string.wxyz_label') },
  { id: 'dial_button_10', main: $r('sys.symbol.staroflife'), sub: $r('app.string.special_p_label') },
  { id: 'dial_button_11', main: '0', sub: $r('sys.symbol.plus') },
  { id: 'dial_button_12', main: $r('sys.symbol.hash'), sub: $r('app.string.special_w_label') }
];

@Builder
export function PhoneDialerPageBuilder() {
  PhoneDialerPage()
}

@ComponentV2
struct PhoneDialerPage {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  /**
   * Constructs the view for a single key
   * @param item Key configuration data
   */
  @Builder
  keyItemBuilder(item: KeyItem, index: number) {
    Column({ space: SpaceToken.SPACE_2 }) {
      if (typeof item.main === 'string') {
        Text(item.main)
          .fontSize(SizeToken.SIZE_NUM_26)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      } else {
        SymbolGlyph(item.main)
          .fontSize(SizeToken.SIZE_NUM_26)
          .fontColor([$r('sys.color.font_primary')])
          .margin({ bottom: PaddingToken.PADDING_2VP })
      }

      if (index === 0 || index === 10) {
        SymbolGlyph(item.sub)
          .fontSize(index === 0 ? $r('sys.float.Body_M') : $r('sys.float.Caption_M'))
          .fontColor([$r('sys.color.font_tertiary')])
          .fontWeight(index === 0 ? FontWeight.Regular : FontWeight.Medium)
      } else {
        Text(item.sub)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_tertiary'))
      }
    }
    .width(SizeToken.SIZE_NUM_58)
    .height(SizeToken.SIZE_NUM_58)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_29)
    .justifyContent(FlexAlign.Center)
    .stateStyles({
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      },
      normal: {
        .backgroundColor(Color.Transparent)
      }
    })
    .onClick(() => {
      let curButtonText: ResourceStr = '';
      switch (index) {
        case 9:
          curButtonText = '*';
          break;
        case 11:
          curButtonText = '#';
          break;
        default:
          if (typeof item.main === 'string') {
            curButtonText = item.main;
          }
          break;
      }
      CommonUtils.showToast(`Button ${curButtonText} clicked.`);
    })
  }

  /**
   * Constructs the entire dial content
   */
  @Builder
  dialContentBuilder() {
    Grid() {
      ForEach(DIALER_DATA, (item: KeyItem, index: number) => {
        GridItem() {
          this.keyItemBuilder(item, index)
        }
      }, (item: KeyItem) => item.id)
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(SpaceToken.SPACE_12)
    .width(SizeToken.SIZE_PERCENT_80)
    .height(SizeToken.SIZE_NUM_300)
  }

  /**
   * Constructs the bottom green call button
   */
  @Builder
  callButtonBuilder() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      SymbolGlyph($r('sys.symbol.phone_fill'))
        .fontSize(SizeToken.SIZE_NUM_34)
        .fontColor([$r('sys.color.font_on_primary')])
    }
    .width(SizeToken.SIZE_NUM_58)
    .height(SizeToken.SIZE_NUM_58)
    .backgroundColor($r('sys.color.confirm'))
    .onClick(() => {
      CommonUtils.showToast('Initiate call.');
    })
  }

  build() {
    NavDestination() {
      Column({ space: SpaceToken.SPACE_24 }) {
        this.dialContentBuilder()
        this.callButtonBuilder()
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}