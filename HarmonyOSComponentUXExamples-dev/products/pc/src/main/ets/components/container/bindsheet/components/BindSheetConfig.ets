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
  CommonConstants,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken
} from 'componentuxexamplesbase';
import { CommonButtonModifier } from '../common/CommonStyles';
import { BindSheetItem } from '../common/BindSheetItem';

interface NavPathInfoInterface {
  closeSheet?: () => void;
}

@ComponentV2
export struct BindSheetConfig {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private ctx: Context | undefined = undefined;
  private buttonModifier = new CommonButtonModifier();

  @Computed
  private get windowHeight() {
    return this.getUIContext().px2vp(this.breakpointModel.windowInfo.windowSize.height);
  }

  aboutToAppear(): void {
    this.ctx = this.getUIContext().getHostContext();
  }

  @Builder
  MyBuilder() {
    Column() {
      Column() {
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .margin({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_24VP
    })
  }

  @Builder
  MyScrollBuilder() {
    List() {
      ListItem() {
        Text($r('app.string.empty_string_label'))
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_700)
      .margin({ bottom: PaddingToken.PADDING_28VP })
      .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .alignListItem(ListItemAlign.Center)
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP
    })
  }

  // Extract common card container styles
  @Styles
  cardStyle() {
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .width(SizeToken.SIZE_PERCENT_100)
  }

  @Builder
  DividerLine() {
    Divider()
      .strokeWidth(SizeToken.SIZE_NUM_1)
      .color($r('sys.color.comp_background_tertiary'))
      .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
  }

  @Builder
  CategoryTitleBuilder(val: ResourceStr) {
    Row() {
      Text(val)
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))
        .lineHeight(SizeToken.SIZE_NUM_22)
        .fontWeight(FontWeight.Medium)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_48)
    .padding({
      top: PaddingToken.PADDING_18VP,
      bottom: PaddingToken.PADDING_8VP
    })
  }

  @Builder
  GroupTitleBuilder(val: ResourceStr) {
    Row() {
      Text(val)
        .fontSize($r('sys.float.Subtitle_S'))
        .fontColor($r('sys.color.font_secondary'))
        .lineHeight(SizeToken.SIZE_NUM_20)
        .fontWeight(FontWeight.Medium)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_40)
    .padding({
      left: PaddingToken.PADDING_12VP,
      top: PaddingToken.PADDING_12VP,
      bottom: PaddingToken.PADDING_8VP
    })
  }

  /**
   * Single button case when window is at default width
   */
  @Builder
  SingleButtonSheetBuilder() {
    Column({ space: SpaceToken.SPACE_16 }) {
      // Placeholder content area
      Column()
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .width(SizeToken.SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))

      // Bottom button area / Bottom action bar
      Button($r('app.string.action_button_label'))
        .attributeModifier(this.buttonModifier)
        .width(SizeToken.SIZE_PERCENT_100)
        .onClick(() => {
          CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
            $r('app.string.action_button_label'))}`);
        })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_24VP
    })
  }

  /**
   * When window width exceeds 480vp and default button width is 120vp
   */
  @Builder
  SingleButtonSheetBuilder2() {
    Column({ space: SpaceToken.SPACE_16 }) {
      // Placeholder content area
      Column()
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .width(SizeToken.SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Row() {
        Button($r('app.string.action_button_label'))
          .attributeModifier(this.buttonModifier)
          .width(SizeToken.SIZE_NUM_120)
          .onClick(() => {
            CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
              $r('app.string.action_button_label'))}`);
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.End)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_24VP
    })
  }

  /**
   * When window width exceeds 480vp and default button width is 120vp
   */
  @Builder
  SingleButtonSheetBuilder3() {
    Column({ space: SpaceToken.SPACE_16 }) {
      // Placeholder content area
      Column()
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .width(SizeToken.SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Row() {
        Button($r('app.string.action_button_label'))
          .attributeModifier(this.buttonModifier)
          .width(SizeToken.SIZE_NUM_432)
          .onClick(() => {
            CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
              $r('app.string.action_button_label'))}`);
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP,
      bottom: PaddingToken.PADDING_24VP
    })
  }

  // Two buttons (side-by-side, equal width)
  @Builder
  DoubleButtonSheetBuilder(val1: ResourceStr | undefined = $r('app.string.action_button_label'),
    val2: ResourceStr | undefined = $r('app.string.action_button_label')) {
    Column({ space: SpaceToken.SPACE_16 }) {
      Column()
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .width(SizeToken.SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Row({ space: SpaceToken.SPACE_16 }) {
        Button(val1)
          .attributeModifier(this.buttonModifier)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
              val1)}`);
          })

        Button(val2)
          .attributeModifier(this.buttonModifier)
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
          .onClick(() => {
            CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
              val2)}`);
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .margin({ bottom: PaddingToken.PADDING_24VP })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP
    })
  }

  // Three/Multiple buttons arranged vertically
  @Builder
  MultipleButtonSheetBuilder() {
    Column({ space: SpaceToken.SPACE_16 }) {
      Column()
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
        .width(SizeToken.SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Column({ space: SpaceToken.SPACE_8 }) {
        ForEach([0, 1, 2], () => {
          Button($r('app.string.action_button_label'))
            .attributeModifier(this.buttonModifier)
            .width(SizeToken.SIZE_PERCENT_100)
            .onClick(() => {
              CommonUtils.showToast(`${CommonUtils.getStrFromResource(this.ctx, $r('app.string.tap_tips_label'),
                $r('app.string.action_button_label'))}`);
            })
        }, (item: number, index: number) => `${item}_${index}`)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .margin({ bottom: PaddingToken.PADDING_24VP })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
    .padding({
      left: PaddingToken.PADDING_24VP,
      right: PaddingToken.PADDING_24VP
    })
  }

  @Builder
  BindSheetTitleBuilder(val: ResourceStr) {
    Row({ space: SpaceToken.SPACE_8 }) {
      Button({ stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.chevron_left'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_primary')])
      }
      .backgroundColor(Color.Transparent)
      .width(SizeToken.SIZE_NUM_40)
      .height(SizeToken.SIZE_NUM_40)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)

      Text(val)
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Bold)
    }
    .height(SizeToken.SIZE_NUM_56)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SplitViewLayoutBuilder(barWidth: Length, closeSheet?: () => void) {
    SplitViewLayoutView({
      barWidth: barWidth,
      // Pass through to internal view
      closeSheet: closeSheet,
      navTitle: () => {
        this.NavTitleBuilder()
      }
    })
  }

  @Builder
  NavTitleBuilder() {
    Row() {
      Text($r('app.string.title_en_label'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Bold)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .alignItems(VerticalAlign.Center)
    .padding({ left: PaddingToken.PADDING_24VP })
    .margin({ top: PaddingToken.PADDING_8VP })
  }

  build() {
    Column() {
      this.CategoryTitleBuilder($r('app.string.visual_styling_label'))
      this.GroupTitleBuilder($r('app.string.window_height_styling_label'))
      Column() {
        // Use wrapped component directly
        BindSheetItem({
          title: $r('app.string.window_height_min_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            // Minimum height for `bindSheet` modal is 320vp
            height: SizeToken.SIZE_NUM_320,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.window_height_default_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.window_height_max_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            // `bindSheet` max height is 90% of the screen's shorter side
            height: this.windowHeight * 0.9,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })
      }.cardStyle()

      this.GroupTitleBuilder($r('app.string.window_width_styling_label'))
      Column() {
        BindSheetItem({
          title: $r('app.string.window_width_small_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            width: SizeToken.SIZE_NUM_480,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.window_width_middle_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            width: SizeToken.SIZE_NUM_640,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.window_width_large_styling_en_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            width: SizeToken.SIZE_NUM_800,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })
      }.cardStyle()

      this.CategoryTitleBuilder($r('app.string.title_area_specification_label'))
      this.GroupTitleBuilder($r('app.string.visual_specification_label'))
      Column() {
        BindSheetItem({
          title: $r('app.string.single_line_title_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.double_line_title_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: {
              title: $r('app.string.title_label'),
              subtitle: $r('app.string.subtitle_en_label')
            }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.secondary_page_title_label'),
          sheetBuilder: () => {
            this.MyBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: () => {
              this.BindSheetTitleBuilder($r('app.string.title_label'))
            }
          }
        })
      }.cardStyle()

      this.CategoryTitleBuilder($r('app.string.button_area_specification_label'))
      this.GroupTitleBuilder($r('app.string.default_window_width_label'))
      Column() {
        BindSheetItem({
          title: $r('app.string.single_button_label'),
          sheetBuilder: () => {
            this.SingleButtonSheetBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.double_button_label'),
          sheetBuilder: () => {
            this.DoubleButtonSheetBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.multiple_button_label'),
          sheetBuilder: () => {
            this.MultipleButtonSheetBuilder()
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.cancel_button_label'),
          sheetBuilder: () => {
            this.DoubleButtonSheetBuilder($r('app.string.cancel_button_label'), $r('app.string.action_button_label'))
          },
          sheetOptions: {
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })
      }.cardStyle()

      this.GroupTitleBuilder($r('app.string.window_width_greater_than_480vp_label'))
      Column() {
        BindSheetItem({
          title: $r('app.string.button_default_width_120vp_label'),
          sheetBuilder: () => {
            this.SingleButtonSheetBuilder2()
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_320,
            width: SizeToken.SIZE_NUM_560,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.button_max_width_432vp_label'),
          sheetBuilder: () => {
            this.SingleButtonSheetBuilder3()
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_320,
            width: SizeToken.SIZE_NUM_560,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: { title: $r('app.string.title_label') }
          }
        })
      }.cardStyle()

      this.CategoryTitleBuilder($r('app.string.split_column_scene_label'))
      this.GroupTitleBuilder($r('app.string.half_modal_width_greater_than_640vp_label'))
      Column() {
        BindSheetItem({
          title: $r('app.string.default_ratio_4_to_6_label'),
          // Receives the internally injected 'close' callback and passes it to Builder
          sheetBuilder: (close: () => void) => {
            this.SplitViewLayoutBuilder(SizeToken.SIZE_PERCENT_40, close)
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_560,
            width: SizeToken.SIZE_NUM_640,
            blurStyle: BlurStyle.COMPONENT_ULTRA_THIN,
            showClose: false,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: undefined
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.special_scene_ratio_5_to_5_label'),
          sheetBuilder: (close: () => void) => {
            this.SplitViewLayoutBuilder(SizeToken.SIZE_PERCENT_50, close)
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_560,
            width: SizeToken.SIZE_NUM_640,
            blurStyle: BlurStyle.COMPONENT_ULTRA_THIN,
            showClose: false,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: undefined
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.special_scene_ratio_6_to_4_label'),
          sheetBuilder: (close: () => void) => {
            this.SplitViewLayoutBuilder(SizeToken.SIZE_PERCENT_60, close)
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_560,
            width: SizeToken.SIZE_NUM_640,
            blurStyle: BlurStyle.COMPONENT_ULTRA_THIN,
            showClose: false,
            enableOutsideInteractive: false,
            preferType: SheetType.CENTER,
            title: undefined
          }
        })
      }.cardStyle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

@ComponentV2
struct SplitViewLayoutView {
  @Param barWidth: Length = SizeToken.SIZE_PERCENT_40;
  // Receive close function from parent
  @Param closeSheet?: () => void = undefined;
  @BuilderParam navTitle: VoidCallback = this.DefaultBuilder;
  private navStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    // Pass the close function to NavDestination (BindSheetEmptyPage) via param
    this.navStack.pushPath({
      name: CommonConstants.BIND_SHEET_EMPTY_PAGE_NAME,
      param: { closeSheet: this.closeSheet } as NavPathInfoInterface
    });
  }

  aboutToDisappear(): void {
    if (this.navStack.size() > 0) {
      this.navStack.clear();
    }
  }

  @Builder
  DefaultBuilder() {
  }

  build() {
    Navigation(this.navStack) {
    }
    .navBarWidth(this.barWidth)
    .mode(NavigationMode.Split)
    .backgroundColor($r('sys.color.background_secondary'))
    .title(this.navTitle)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
  }
}