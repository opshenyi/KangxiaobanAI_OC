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
import { ArcList, ArcListItem, ComponentContent, LengthMetrics } from '@kit.ArkUI';
import { ComponentItem, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { HeaderComponent } from '../../common/HeaderComponent';

@Builder
export function ListCollectBuilder() {
  ListCollect()
}

@ComponentV2
struct ListCollect {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  context: UIContext = this.getUIContext();

  @Builder
  SingleLineListItem() {
    ArcListItem() {
      Row() {
        Text(this.param.name)
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
          .width($r('app.float.item_text_width'))
          .margin({ left: SpaceToken.SPACE_44 })
          .focusable(true)
          .focusOnTouch(true)
          .defaultFocus(true)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height($r('app.float.item_height'))
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.watch_fill'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_M'))
          .fontColor([Color.White])
          .backgroundColor($r('app.color.blue_color'))
          .margin({ left: SpaceToken.SPACE_4, right: SpaceToken.SPACE_4 })
          .borderRadius($r('app.float.item_arrow_size'))
        Text(this.param.name)
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
          .width(SizeToken.SIZE_NUM_97)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height($r('app.float.item_height'))
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.line_2_horizontal'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([Color.White])
        Text(this.param.name)
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
          .width($r('app.float.item_text_width'))
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([Color.White])
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height($r('app.float.item_height'))
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }
  }

  @Builder
  DoubleLineListItem() {
    ArcListItem() {
      Column() {
        Text(this.param.name)
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
        Text($r('app.string.title_bar_subtext'))
          .fontColor($r('app.color.gray_color'))
          .fontSize($r('sys.float.Title_M'))
          .focusable(true)
          .focusOnTouch(true)
          .defaultFocus(true)
      }
      .justifyContent(FlexAlign.Center)
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_60)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.watch_fill'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_M'))
          .fontColor([Color.White])
          .backgroundColor($r('app.color.blue_color'))
          .margin({ left: SpaceToken.SPACE_4, right: SpaceToken.SPACE_4 })
          .borderRadius($r('app.float.item_arrow_size'))
        Column() {
          Text(this.param.name)
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
          Text($r('app.string.title_bar_subtext'))
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_M'))
        }
        .width(SizeToken.SIZE_NUM_97)
        .align(Alignment.Center)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_60)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.line_2_horizontal'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([Color.White])
        Column() {
          Text(this.param.name)
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
          Text($r('app.string.title_bar_subtext'))
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_M'))
        }
        .align(Alignment.Center)
        .width($r('app.float.item_text_width'))

        SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([$r('app.color.blue_color'), Color.White])
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_60)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }
  }

  @Builder
  ThreeLineListItem() {
    ArcListItem() {
      Column() {
        Text(this.param.name)
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
        Text($r('app.string.title_bar_subtext'))
          .fontColor($r('app.color.gray_color'))
          .fontSize($r('sys.float.Title_M'))
        Text('上午 10:08')
          .fontColor($r('app.color.gray_color'))
          .fontSize($r('sys.float.Title_S'))
          .focusable(true)
          .focusOnTouch(true)
          .defaultFocus(true)
      }
      .justifyContent(FlexAlign.Center)
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_76)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.watch_fill'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_M'))
          .fontColor([Color.White])
          .backgroundColor($r('app.color.blue_color'))
          .margin({ left: SpaceToken.SPACE_4, right: SpaceToken.SPACE_4 })
          .borderRadius($r('app.float.item_arrow_size'))
        Column() {
          Text(this.param.name)
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
          Text($r('app.string.title_bar_subtext'))
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_M'))
          Text('上午 10:08')
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_S'))
        }
        .width(SizeToken.SIZE_NUM_97)
        .align(Alignment.Center)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_76)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }

    ArcListItem() {
      Row() {
        SymbolGlyph($r('sys.symbol.line_2_horizontal'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([Color.White])
        Column() {
          Text(this.param.name)
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
          Text($r('app.string.title_bar_subtext'))
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_M'))
          Text('上午 10:08')
            .fontColor($r('app.color.gray_color'))
            .fontSize($r('sys.float.Title_S'))
        }
        .align(Alignment.Center)
        .width($r('app.float.item_text_width'))

        SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
          .width($r('app.float.item_arrow_size'))
          .height($r('app.float.item_arrow_size'))
          .fontSize($r('sys.float.Display_S'))
          .fontColor([$r('app.color.blue_color'), Color.White])
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height(SizeToken.SIZE_NUM_76)
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
    }
  }

  build() {
    NavDestination() {
      ArcList({ header: new ComponentContent(this.context, wrapBuilder(HeaderComponent), this.param.name) }) {
        if (this.param.id === 'single_line_list') {
          this.SingleLineListItem()
        }
        if (this.param.id === 'double_line_list') {
          this.DoubleLineListItem()
        }
        if (this.param.id === 'three_line_list') {
          this.ThreeLineListItem()
        }
      }.space(LengthMetrics.px(PaddingToken.PADDING_4VP))
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}