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
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';
import { BindSheetItem } from '../common/BindSheetItem';


@ComponentV2
struct ContentComp {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      Column() {
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .margin({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP,
      bottom: this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_0VP,
        md: PaddingToken.PADDING_16VP,
        lg: PaddingToken.PADDING_16VP
      })
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }
}

@ComponentV2
export struct BindSheetConfig {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();

  @Computed
  get windowHeight() {
    return this.breakpointModel.windowInfo.windowSize.height;
  }

  @Computed
  get curSheetType() {
    return this.breakpointModel.getValue({
      sm: SheetType.BOTTOM,
      md: SheetType.CENTER,
      lg: SheetType.CENTER
    });
  }

  @Builder
  MyBuilder() {
    ContentComp()
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

  /**
   * Extract common card container styles
   */
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

  build() {
    Column() {
      SubTitleView($r('app.string.overlay_label'))
      Column() {
        // Use wrapped component directly
        BindSheetItem({
          title: $r('app.string.modal_label'),
          sheetBuilder: this.MyBuilder,
          sheetOptions: {
            detents: [SheetSize.MEDIUM],
            blurStyle: BlurStyle.Thick,
            showClose: true,
            title: { title: $r('app.string.title_label') },
            preferType: this.curSheetType,
            enableOutsideInteractive: false
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.non_modal_label'),
          sheetBuilder: this.MyBuilder,
          sheetOptions: {
            detents: [SheetSize.MEDIUM],
            blurStyle: BlurStyle.Thick,
            showClose: true,
            title: { title: $r('app.string.title_label') },
            preferType: this.curSheetType,
            enableOutsideInteractive: true,
            shadow: ShadowStyle.OUTER_DEFAULT_SM
          }
        })
      }.cardStyle()

      SubTitleView($r('app.string.modal_height_label'))

      Column() {
        BindSheetItem({
          title: $r('app.string.large_label'),
          sheetBuilder: this.MyBuilder,
          sheetOptions: {
            height: this.breakpointModel.getValue({
              sm: SheetSize.LARGE,
              md: this.windowHeight * CommonConstants.SHEET_HEIGHT_RATIO_MEDIUM,
              lg: this.windowHeight * CommonConstants.SHEET_HEIGHT_RATIO_MEDIUM
            }),
            blurStyle: BlurStyle.Thick,
            showClose: true,
            preferType: this.curSheetType,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.medium_label'),
          sheetBuilder: this.MyBuilder,
          sheetOptions: {
            height: this.breakpointModel.getValue({
              sm: SheetSize.MEDIUM,
              md: this.windowHeight * CommonConstants.SHEET_HEIGHT_RATIO_SMALL,
              lg: this.windowHeight * CommonConstants.SHEET_HEIGHT_RATIO_SMALL
            }),
            blurStyle: BlurStyle.Thick,
            showClose: true,
            preferType: this.curSheetType,
            title: { title: $r('app.string.title_label') }
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.free_label'),
          sheetBuilder: this.MyBuilder,
          sheetOptions: {
            height: SizeToken.SIZE_NUM_600,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            preferType: this.curSheetType,
            title: { title: $r('app.string.title_label') }
          }
        })
      }.cardStyle()

      if (this.breakpointModel.isSmallScreen()) {
        SubTitleView($r('app.string.bottom_panel_label'))
        Column() {
          BindSheetItem({
            title: $r('app.string.portrait_display_label'),
            sheetBuilder: this.MyBuilder,
            sheetOptions: {
              detents: [SheetSize.MEDIUM],
              blurStyle: BlurStyle.Thick,
              showClose: true,
              preferType: this.curSheetType,
              title: { title: $r('app.string.title_label') }
            }
          })

          this.DividerLine()

          // Handle landscape orientation transition with `customAction`
          BindSheetItem({
            title: $r('app.string.landscape_display_label'),
            customAction: () => {
              this.navPathStack.pushPath({ name: CommonConstants.LANDSCAPE_BIND_SHEET_NAME });
            }
          })
        }.cardStyle()
      }

      SubTitleView($r('app.string.bottom_panel_scroll_response_priority_label'))

      Column() {
        BindSheetItem({
          title: $r('app.string.slide_content_and_title_label'),
          sheetBuilder: this.MyScrollBuilder,
          sheetOptions: {
            detents: [SheetSize.LARGE, SizeToken.SIZE_NUM_200],
            blurStyle: BlurStyle.Thick,
            showClose: true,
            title: { title: $r('app.string.title_label') },
            preferType: this.curSheetType,
            enableOutsideInteractive: false
          }
        })
      }.cardStyle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}