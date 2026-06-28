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
export function DialogExampleBuilder() {
  DialogExample()
}

const capsuleItems: ComponentItem[] = [
  { id: 'capsule_text', name: $r('app.string.text_only'), url: '' },
  { id: 'capsule_title_text', name: $r('app.string.title_and_text'), url: '' },
  { id: 'capsule_icon_text', name: $r('app.string.icon_and_text'), url: '' }
]

const circleItems: ComponentItem[] = [
  { id: 'circle_text', name: $r('app.string.text_only'), url: '' },
  { id: 'circle_title_text', name: $r('app.string.title_and_text'), url: '' },
  { id: 'circle_icon_text', name: $r('app.string.icon_and_text'), url: '' }
]

@CustomDialog
struct CapsuleTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        Text($r('app.string.dialog_text_1'))
          .fontSize($r('sys.float.Title_M'))
          .width(181)
          .margin({ top: SizeToken.SIZE_NUM_40, bottom: SizeToken.SIZE_NUM_12 })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .backgroundColor($r('app.color.dark_blue_color'))
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .margin({ top: SizeToken.SIZE_NUM_6 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .backgroundColor($r('app.color.dark_blue_color'))
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .margin({ top: SizeToken.SIZE_NUM_6, bottom: SizeToken.SIZE_NUM_36 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .scrollBar(BarState.Off)
    .backgroundColor(Color.Black)
  }
}

@CustomDialog
struct CapsuleTitleTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        Text($r('app.string.title_and_text'))
          .fontSize($r('sys.float.Title_M'))
          .width(181)
          .fontWeight(FontWeight.Bold)
          .margin({ top: SizeToken.SIZE_NUM_10 })
        Text($r('app.string.dialog_text_2'))
          .fontSize($r('sys.float.Title_M'))
          .width(181)
          .margin({ top: SizeToken.SIZE_NUM_16, bottom: SizeToken.SIZE_NUM_12 })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .backgroundColor($r('app.color.dark_blue_color'))
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .margin({ top: SizeToken.SIZE_NUM_6 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .backgroundColor($r('app.color.dark_blue_color'))
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .margin({ top: SizeToken.SIZE_NUM_6, bottom: SizeToken.SIZE_NUM_36 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
      }
    }
    .scrollBar(BarState.Off)
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor(Color.Black)
  }
}

@CustomDialog
struct CapsuleIconTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        Stack() {
          SymbolGlyph($r('sys.symbol.square_grid_2x2'))
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_27)
            .width(SizeToken.SIZE_NUM_27)
            .height(SizeToken.SIZE_NUM_27)
        }
        .linearGradient({
          direction: GradientDirection.Top,
          colors: [[0x0A59F7, 0.5], [0x008CFF, 1]]
        })
        .width(SizeToken.SIZE_NUM_46)
        .height(SizeToken.SIZE_NUM_46)
        .borderRadius(SizeToken.SIZE_NUM_46)
        .margin({ top: SizeToken.SIZE_NUM_6 })

        Text($r('app.string.appname_text'))
          .fontSize($r('sys.float.Title_S'))
          .width(181)
          .fontColor($r('app.color.gray_color'))
          .margin({ top: SizeToken.SIZE_NUM_6 })
        Text($r('app.string.message_text'))
          .fontSize($r('sys.float.Title_M'))
          .width(181)
          .margin({ top: SizeToken.SIZE_NUM_16, bottom: SizeToken.SIZE_NUM_4 })
        Text($r('app.string.time_text'))
          .fontSize($r('sys.float.Body_S'))
          .width(181)
          .fontColor($r('app.color.gray_color'))
          .margin({ bottom: SizeToken.SIZE_NUM_12 })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .backgroundColor($r('app.color.dark_gray_color'))
          .margin({ top: SizeToken.SIZE_NUM_6 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button($r('app.string.capsule_button'))
          .height(SizeToken.SIZE_NUM_40)
          .width(SizeToken.SIZE_NUM_116)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .type(ButtonType.Capsule)
          .fontSize($r('sys.float.Body_M'))
          .backgroundColor($r('app.color.dark_gray_color'))
          .margin({ top: SizeToken.SIZE_NUM_6 })
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
        Button() {
          SymbolGlyph($r('sys.symbol.trash_fill'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
        }
        .buttonStyle(ButtonStyleMode.NORMAL)
        .backgroundColor($r('app.color.dark_gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_16, bottom: SizeToken.SIZE_NUM_6 })
        .type(ButtonType.Circle)
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
      }
    }
    .scrollBar(BarState.Off)
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor(Color.Black)
  }
}

@CustomDialog
struct CircleTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text($r('app.string.dialog_text_1'))
        .fontSize($r('sys.float.Title_M'))
        .width(181)
      Row() {
        Button() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.NORMAL)
        .type(ButtonType.Circle)
        .backgroundColor($r('app.color.dark_blue_color'))
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })

        Blank()
        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .type(ButtonType.Circle)
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
      }
      .width(153)
      .margin({ top: SizeToken.SIZE_NUM_43, bottom: SizeToken.SIZE_NUM_20 })
    }
    .justifyContent(FlexAlign.End)
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor(Color.Black)
  }
}

@CustomDialog
struct CircleTitleTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text($r('app.string.title'))
        .fontSize($r('sys.float.Title_M'))
        .fontWeight(FontWeight.Bold)
        .width(130)
        .margin({ bottom: SizeToken.SIZE_NUM_12 })
      Text($r('app.string.dialog_text_1'))
        .fontSize($r('sys.float.Title_M'))
        .width(181)
      Row() {
        Button() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.NORMAL)
        .type(ButtonType.Circle)
        .backgroundColor($r('app.color.dark_blue_color'))
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })

        Blank()
        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .type(ButtonType.Circle)
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
      }
      .width(153)
      .margin({ top: SizeToken.SIZE_NUM_43, bottom: SizeToken.SIZE_NUM_20 })
    }
    .justifyContent(FlexAlign.End)
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor(Color.Black)
  }
}

@CustomDialog
struct CircleIconTextDialog {
  controller?: CustomDialogController;
  scroller: Scroller = new Scroller();
  colorGradient: LinearGradient =
    new LinearGradient([{ color: '#1F71FF', offset: 0 }, { color: '#5ED7FF', offset: 1 }])

  build() {
    Column() {
      Stack() {
        SymbolGlyph($r('sys.symbol.square_grid_2x2'))
          .fontColor([Color.White])
          .fontSize(SizeToken.SIZE_NUM_27)
          .width(SizeToken.SIZE_NUM_27)
          .height(SizeToken.SIZE_NUM_27)
      }
      .linearGradient({
        direction: GradientDirection.Top,
        colors: [[0x0A59F7, 0.5], [0x008CFF, 1]]
      })
      .width(SizeToken.SIZE_NUM_52)
      .height(SizeToken.SIZE_NUM_52)
      .borderRadius(SizeToken.SIZE_NUM_52)
      .margin({ bottom: SizeToken.SIZE_NUM_12 })

      Text($r('app.string.dialog_text_1'))
        .fontSize($r('sys.float.Title_M'))
        .width(181)
      Row() {
        Button() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([$r('app.color.light_blue_color')])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.NORMAL)
        .type(ButtonType.Circle)
        .backgroundColor($r('app.color.dark_blue_color'))
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })

        Blank()
        Button() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .height(SizeToken.SIZE_NUM_52)
            .width(SizeToken.SIZE_NUM_52)
            .fontColor([Color.White])
            .fontSize(SizeToken.SIZE_NUM_28)
            .fontWeight(FontWeight.Bold)
        }
        .buttonStyle(ButtonStyleMode.EMPHASIZED)
        .type(ButtonType.Circle)
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
      }
      .width(153)
      .margin({ top: SizeToken.SIZE_NUM_43, bottom: SizeToken.SIZE_NUM_20 })
    }
    .justifyContent(FlexAlign.End)
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .backgroundColor(Color.Black)
  }
}


@ComponentV2
export struct DialogExample {
  @Local private param: string = ''
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  context: UIContext = this.getUIContext();
  capsuleTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CapsuleTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  });
  capsuleTitleTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CapsuleTitleTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  });
  capsuleIconTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CapsuleIconTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  })
  circleTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CircleTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  })
  circleTitleTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CircleTitleTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  })
  circleIconTextDialog: CustomDialogController | null = new CustomDialogController({
    builder: CircleIconTextDialog(),
    width: 233,
    height: 233,
    backgroundColor: Color.Black
  })

  aboutToDisappear() {
    this.capsuleTextDialog = null;
  }

  @Builder
  ItemComponent(item: ComponentItem) {
    Row() {
      Text(item.name)
        .fontColor(Color.White)
        .fontSize($r('sys.float.Title_L'))
        .width($r('app.float.item_text_width'))
        .margin({ left: SpaceToken.SPACE_44 })
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
    .onClick(() => {
      switch (item.id) {
        case 'capsule_text':
          if (this.capsuleTextDialog !== null) {
            this.capsuleTextDialog.open();
          }
          break;
        case 'capsule_title_text':
          if (this.capsuleTitleTextDialog !== null) {
            this.capsuleTitleTextDialog.open();
          }
          break;
        case 'capsule_icon_text':
          if (this.capsuleIconTextDialog !== null) {
            this.capsuleIconTextDialog.open();
          }
          break;
        case 'circle_text':
          if (this.circleTextDialog !== null) {
            this.circleTextDialog.open();
          }
          break;
        case 'circle_title_text':
          if (this.circleTitleTextDialog !== null) {
            this.circleTitleTextDialog.open();
          }
          break;
        case 'circle_icon_text':
          if (this.circleIconTextDialog !== null) {
            this.circleIconTextDialog.open();
          }
          break;

      }
    })
  }

  build() {
    NavDestination() {
      ArcList({ header: new ComponentContent(this.context, wrapBuilder(HeaderComponent), this.param) }) {
        ArcListItem() {
          Text($r('app.string.capsule_button_dialog'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor($r('app.color.gray_color'))
            .width(SizeToken.SIZE_PERCENT_100)
        }

        Repeat(capsuleItems)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          Text($r('app.string.circle_button_dialog'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor($r('app.color.gray_color'))
            .width(SizeToken.SIZE_PERCENT_100)
            .margin({ top: SizeToken.SIZE_NUM_20 })
        }

        Repeat(circleItems)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })

      }.space(LengthMetrics.px(PaddingToken.PADDING_6VP))
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}