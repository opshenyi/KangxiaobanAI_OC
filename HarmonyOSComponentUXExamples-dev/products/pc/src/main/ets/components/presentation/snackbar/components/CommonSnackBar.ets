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
import {
  CommonConstants,
  CommonUtils,
  ComponentGroup,
  CornerRadiusToken,
  Logger,
  PaddingToken,
  SizeToken,
  SubTitleView
} from 'componentuxexamplesbase';

const TAG = 'CommonSnackBar';

/**
 * PC / Desktop SnackBar Data Source
 */
const SNACKBAR_DATA_PC: ComponentGroup[] = [
  {
    id: 'group_basic_style_snackbar',
    title: $r('app.string.basic_style_label'),
    items: [
      {
        id: 'basic_style_snackbar',
        name: $r('app.string.top_center_snackbar_label'),
        url: ''
      }
    ]
  }
];

@ComponentV2
export struct CommonSnackBar {
  private uiContext: UIContext | null = null;
  private hdsSnackBar: HdsSnackBar | null = null;
  private curTitleColor: ColorMetrics | undefined = undefined;
  private message2: SnackBarMessageOptions = {
    title: $r('app.string.residency_label'),
    titleColor: this.curTitleColor
  };
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
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
      Repeat(SNACKBAR_DATA_PC)
        .each((groupWrap) => {
          SubTitleView(groupWrap.item.title)

          Repeat(groupWrap.item.items).each((itemWrap) => {
            Row() {
              Text(itemWrap.item.name)
                .fontColor($r('sys.color.font_primary'))
                .fontSize($r('sys.float.Subtitle_M'))
                .fontWeight(FontWeight.Medium)

              SymbolGlyph($r('sys.symbol.chevron_right'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([$r('sys.color.icon_fourth')])
            }
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_NUM_48)
            .backgroundColor($r('sys.color.background_primary'))
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
            .padding(PaddingToken.PADDING_12VP)
            .margin({ bottom: itemWrap.index < groupWrap.item.items.length - 1 ? PaddingToken.PADDING_12VP : 0 })
            .onClick(() => {
              this.hdsSnackBar?.show(this.icon, this.message2, this.operation2, this.style2);
            })
          })
            .key((item) => item.id)
        })
        .key((group) => group.id)
    }
    .width(SizeToken.SIZE_PERCENT_100)
  }
}