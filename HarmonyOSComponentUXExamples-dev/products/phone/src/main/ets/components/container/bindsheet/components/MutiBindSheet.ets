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
import { Logger } from 'componentuxexamplesbase';
import {
  BreakpointModel,
  CommonConstants,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';
import { BindSheetItem } from '../common/BindSheetItem';

const TAG = 'MutiBindSheet';

@ComponentV2
export struct MutiBindSheet {
  private timerId1: number = 0;
  // Internal core state for Panel 1 (same-panel transition)
  @Local title: ResourceStr = $r('app.string.title_label');
  @Local flag: boolean = false;
  @Local translateX: number = 0;
  // Internal state for Panel 2 (multi-panel nesting): controls the second-level nested modal
  @Local isShowSheetTwoNonModalBuilder: boolean = false;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @Computed
  get curSheetType() {
    return this.breakpointModel.getValue({
      sm: SheetType.BOTTOM,
      md: SheetType.CENTER,
      lg: SheetType.CENTER
    });
  }

  aboutToDisappear(): void {
    if (this.timerId1 !== 0) {
      clearTimeout(this.timerId1);
      this.timerId1 = 0;
    }
  }

  // Extract common card styles
  @Styles
  cardStyle() {
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .width(SizeToken.SIZE_PERCENT_100)
  }

  // Extract common divider
  @Builder
  DividerLine() {
    Divider()
      .strokeWidth(SizeToken.SIZE_NUM_1)
      .color($r('sys.color.comp_background_tertiary'))
      .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
  }

  @Builder
  SheetBuilder() {
    Stack() {
      Column() {
        Row() {
          Text(this.title)
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Bold)
        }
        .height(SizeToken.SIZE_NUM_65)
        .width(SizeToken.SIZE_PERCENT_100)
        .padding({ top: PaddingToken.PADDING_5VP })

        Flex({ direction: FlexDirection.Column }) {
          Column() {
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .height('calc(100% - 142vp)')
          .backgroundColor($r('app.color.bindSheet_content_background_color'))

          Button($r('app.string.conversion_same_panel_label'))
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_NUM_40)
            .margin({ top: PaddingToken.PADDING_16VP })
            .buttonStyle(ButtonStyleMode.NORMAL)
            .onClick(() => {
              this.timerId1 = setTimeout(() => {
                this.title = $r('app.string.subtitle_label');
              }, CommonConstants.DURATION_100)
              this.getUIContext()?.animateTo({
                duration: CommonConstants.DURATION_400,
                curve: Curve.EaseOut,
                playMode: PlayMode.Normal,
                onFinish: () => {
                  Logger.info(TAG, 'play end');
                }
              }, () => {
                this.flag = !this.flag;
              });
            });
        }
        .height(SizeToken.SIZE_PERCENT_100)
      }
      .margin({
        left: PaddingToken.PADDING_16VP,
        right: PaddingToken.PADDING_16VP,
        bottom: this.breakpointModel.getValue({
          sm: PaddingToken.PADDING_16VP,
          md: PaddingToken.PADDING_0VP,
          lg: PaddingToken.PADDING_0VP
        })
      })
      .translate({ x: this.flag ? -this.translateX : CommonConstants.INTEGER_0 })

      SheetBuilder1({ title: this.title!!, flag: this.flag!! })
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)
        .translate({ x: this.flag ? CommonConstants.INTEGER_0 : this.translateX })
        .onAreaChange((_oldValue: Area, newValue: Area) => {
          this.translateX = newValue.width as number;
        })
    }
    .height(SizeToken.SIZE_PERCENT_100)
  }

  @Builder
  MyBuilder() {
    SheetBuilder2()
  }

  @Builder
  MyMultipleBuilder() {
    Flex({ direction: FlexDirection.Column }) {
      Column() {
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height('calc(100% - 72vp)')
      .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Button($r('app.string.multiple_panels_label'))
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_40)
        .margin({ top: PaddingToken.PADDING_16VP })
        .buttonStyle(ButtonStyleMode.NORMAL)
        .onClick(() => {
          this.isShowSheetTwoNonModalBuilder = true;
        })
        .bindSheet(this.isShowSheetTwoNonModalBuilder!!, this.MyBuilder(), {
          height: SizeToken.SIZE_NUM_592,
          showClose: true,
          title: { title: $r('app.string.sheet2_label') },
          preferType: this.curSheetType
        })
    }
    .margin({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP,
      bottom: this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_16VP,
        md: PaddingToken.PADDING_0VP,
        lg: PaddingToken.PADDING_0VP
      })
    })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.panel_navigation_label'))

      Column() {
        BindSheetItem({
          title: $r('app.string.conversion_same_panel_label'),
          sheetBuilder: () => {
            this.SheetBuilder()
          },
          sheetOptions: {
            detents: [SheetSize.MEDIUM],
            showClose: true,
            preferType: this.curSheetType
          }
        })

        this.DividerLine()

        BindSheetItem({
          title: $r('app.string.multiple_panels_label'),
          sheetBuilder: () => {
            this.MyMultipleBuilder()
          },
          sheetOptions: {
            height: SizeToken.SIZE_NUM_475,
            showClose: true,
            title: { title: $r('app.string.sheet1_label') },
            preferType: this.curSheetType
          }
        })

      }
      .cardStyle()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

// Jump to the second page on the same panel
@ComponentV2
struct SheetBuilder1 {
  private timerId: number = 0;
  @Param title: ResourceStr = '';
  @Param flag: boolean = false;
  @Event $title: (val: ResourceStr) => void = () => {
  };
  @Event $flag: (val: boolean) => void = () => {
  };

  aboutToDisappear(): void {
    if (this.timerId !== 0) {
      clearTimeout(this.timerId);
      this.timerId = 0;
    }
  }

  build() {
    Column() {
      Row() {
        Column() {
          Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
            .height(SizeToken.SIZE_NUM_24)
            .width(SizeToken.SIZE_NUM_24)
            .fillColor($r('sys.color.font_primary'));
        }
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_40)
        .width(SizeToken.SIZE_NUM_40)
        .height(SizeToken.SIZE_NUM_40)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .margin({ right: PaddingToken.PADDING_8VP })
        .onClick(() => {
           this.timerId = setTimeout(() => {
            this.$title($r('app.string.title_label'));
          }, CommonConstants.DURATION_100);
          this.getUIContext()?.animateTo({
            duration: CommonConstants.DURATION_400,
            curve: Curve.EaseOut,
            playMode: PlayMode.Normal,
            onFinish: () => {
              Logger.info(TAG, 'play end');
            }
          }, () => {
            this.$flag(!this.flag);
          });
        });

        Text(this.title)
          .fontSize($r('sys.float.Title_S'))
          .fontWeight(FontWeight.Bold)
      }
      .height(SizeToken.SIZE_NUM_65)
      .width(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: PaddingToken.PADDING_16VP,
        top: PaddingToken.PADDING_5VP
      })

      SheetBuilder2()
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}

@ComponentV2
struct SheetBuilder2 {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      Row() {
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
      .backgroundColor($r('app.color.bindSheet_content_background_color'))

      Row() {
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(this.breakpointModel.getValue({
        sm: PaddingToken.PADDING_0VP,
        md: PaddingToken.PADDING_16VP,
        lg: PaddingToken.PADDING_16VP
      }))
    }
    .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
    .margin({
      left: PaddingToken.PADDING_16VP,
      right: PaddingToken.PADDING_16VP
    })
  }
}