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
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarOperationType,
  SnackBarStyleOptions
} from '@kit.UIDesignKit';
import { ColorMetrics } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import {
  BreakpointModel,
  CommonConstants,
  CommonUtils,
  ComponentGroup,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';

const TAG = 'CommonSnackBar';

/**
 * Mobile / Foldable Device SnackBar Data Source
 */
const SNACKBAR_DATA: ComponentGroup[] = [
  {
    id: 'group_configuration_type',
    title: $r('app.string.configuration_type_classification_label'),
    items: [
      {
        id: 'scheduled_shutdown',
        name: $r('app.string.scheduled_shutdown_mode_label'),
        url: ''
      },
      {
        id: 'resident_mode',
        name: $r('app.string.resident_mode_label'),
        url: ''
      }
    ]
  },
  {
    id: 'group_landscape_mode',
    title: $r('app.string.phone_in_landscape_mode_maximum_width_label'),
    items: [
      {
        id: 'landscape_mode',
        name: $r('app.string.landscape_mode_label'),
        url: CommonConstants.LANDSCAPE_SNACK_BAR_NAME
      }
    ]
  }
];

@ComponentV2
export struct CommonSnackBar {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private uiContext: UIContext | null = null;
  private hdsSnackBar: HdsSnackBar | null = null;
  private curTitleColor: ColorMetrics | undefined = undefined;
  private message2: SnackBarMessageOptions = {
    title: $r('app.string.residency_label'),
    titleColor: this.curTitleColor
  };
  private message1: SnackBarMessageOptions = {
    title: $r('app.string.scheduled_shutdown_label'),
    titleColor: this.curTitleColor
  };
  private curArrowColor: ColorMetrics[] | undefined = undefined;
  private operation1: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_ARROW,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton1',
    arrowColor: this.curArrowColor,
    onArrowClick: () => {
      CommonUtils.showToast('Arrow clicked.');
    }
  };
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
  };
  private style1: SnackBarStyleOptions = {
    duration: CommonConstants.DURATION_2500
  };
  private operation2: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_CLOSE,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton2',
    onContentClick: () => {
      CommonUtils.showToast('Content clicked.');
    }
  };
  private style2: SnackBarStyleOptions = {
    duration: CommonConstants.DURATION_NEGATIVE_1
  };

  aboutToAppear(): void {
    this.uiContext = this.getUIContext();
    this.hdsSnackBar = new HdsSnackBar(this.uiContext);
    try {
      this.curTitleColor = ColorMetrics.resourceColor($r('sys.color.font_primary'));
      this.curArrowColor = [ColorMetrics.resourceColor($r('sys.color.icon_emphasize'))];
    } catch (err) {
      Logger.error(TAG, 'Failed to instantiate the ColorMetrics class using ResourceColor');
    }
  }

  aboutToDisappear(): void {
    this.hdsSnackBar?.dismiss();
    this.hdsSnackBar = null;
  }

  build() {
    Column() {
      Repeat(SNACKBAR_DATA)
        .each((groupWrap) => {
          SubTitleView(groupWrap.item.title)

          Repeat(groupWrap.item.items).each((itemWrap) => {
            Row() {
              Text(itemWrap.item.name)
                .fontColor($r('sys.color.font_primary'))
                .fontSize($r('sys.float.Subtitle_M'))
                .fontWeight(FontWeight.Medium)

              if (itemWrap.item.id === 'landscape_mode') {
                Row({ space: SpaceToken.SPACE_4 }) {
                  Text($r('app.string.view_example_label'))
                    .fontColor($r('sys.color.background_emphasize'))
                    .fontSize($r('sys.float.Body_M'))
                    .fontWeight(FontWeight.Regular)

                  SymbolGlyph($r('sys.symbol.chevron_right'))
                    .fontSize($r('sys.float.Title_M'))
                    .fontColor([$r('sys.color.icon_fourth')])
                }
              } else {
                SymbolGlyph($r('sys.symbol.chevron_right'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor(['#C4C6CC'])
              }
            }
            .width(SizeToken.SIZE_PERCENT_100)
            .height(this.breakpointModel.isExtraLargeScreen() ? SizeToken.SIZE_NUM_48 : SizeToken.SIZE_NUM_56)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
            .padding(PaddingToken.PADDING_12VP)
            .margin({ bottom: itemWrap.index < groupWrap.item.items.length - 1 ? PaddingToken.PADDING_12VP : 0 })
            .stateStyles({
              normal: {
                .backgroundColor($r('sys.color.comp_background_list_card'))
              },
              pressed: {
                .backgroundColor($r('app.color.list_item_pressed_color'))
              }
            })
            .onClick(() => {
              // Trigger different business logic based on data source ID
              switch (itemWrap.item.id) {
                case 'scheduled_shutdown':
                  this.hdsSnackBar?.show(this.icon, this.message1, this.operation1, this.style1);
                  break;
                case 'resident_mode':
                  this.hdsSnackBar?.show(this.icon, this.message2, this.operation2, this.style2);
                  break;
                case 'landscape_mode':
                  this.navPathStack.pushPath({ name: itemWrap.item.url.toString() });
                  break;
                default:
                  break;
              }
            })
          })
            .key((item) => item.id)
        })
        .key((group) => group.id)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}