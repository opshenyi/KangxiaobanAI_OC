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

import { LengthMetrics, PromptAction } from '@kit.ArkUI';
import { HdsNavDestination } from '@kit.UIDesignKit';
import { Logger } from 'componentuxexamplesbase';
import {
  ComponentGroup,
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  PaddingToken,
  SizeToken,
  SubTitleView as GroupHeader
} from 'componentuxexamplesbase';

const TAG = 'ToastExample';
/**
 * Master data source for toast view component list
 */
const TOAST_DATA_PC: ComponentGroup[] = [
  {
    id: 'group_basic_style_toast',
    title: $r('app.string.basic_style_label'),
    items: [
      { id: 'single_line_toast', name: $r('app.string.single_line_toast_label'), url: '' },
      { id: 'multiple_line_toast', name: $r('app.string.multiple_line_toast_label'), url: '' }
    ]
  }
];

@Builder
export function ToastExampleBuilder() {
  ToastExample()
}

@ComponentV2
struct ToastExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local toastId: number = -1;
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };
  private promptAction: PromptAction | undefined = undefined;

  aboutToAppear(): void {
    this.promptAction = this.getUIContext().getPromptAction();
  }

  aboutToDisappear(): void {
    try {
      if (this.toastId !== -1) {
        this.promptAction?.closeToast(this.toastId);
        this.toastId = -1;
      }
    } catch (err) {
      Logger.error(TAG,
        `Failed to close the toast dialog, error info:${JSON.stringify(err)}`)
    }
  }

  build() {
    HdsNavDestination() {
      List() {
        Repeat(TOAST_DATA_PC)
          .each((groupWrap) => {
            ListItemGroup({
              header: GroupHeader(groupWrap.item.title, undefined, $r('app.color.default_background_color'))
            }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Row() {
                      Text(itemWrap.item.name)
                        .fontColor($r('sys.color.font_primary'))
                        .fontSize($r('sys.float.Subtitle_M'))
                        .fontWeight(FontWeight.Medium)

                      SymbolGlyph($r('sys.symbol.chevron_right'))
                        .fontSize($r('sys.float.Title_M'))
                        .fontColor([$r('sys.color.icon_fourth')])
                    }
                    .backgroundColor($r('sys.color.background_primary'))
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                    .width(SizeToken.SIZE_PERCENT_100)
                    .height(SizeToken.SIZE_NUM_48)
                    .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
                    .justifyContent(FlexAlign.SpaceBetween)
                    .onClick(() => {
                      if (itemWrap.item.id === 'single_line_toast') {
                        this.promptAction?.openToast({
                          message: 'A'.repeat(13)
                        }).then((toastId: number) => {
                          this.toastId = toastId;
                        }).catch((err: BusinessError) => {
                          Logger.error(TAG,
                            `Failed to open the toast dialog, error info:${JSON.stringify(err)}`);
                        })
                      } else {
                        this.promptAction?.openToast({
                          message: 'A'.repeat(100)
                        }).then((toastId: number) => {
                          this.toastId = toastId;
                        }).catch((err: BusinessError) => {
                          Logger.error(TAG,
                            `Failed to open the toast dialog, error info:${JSON.stringify(err)}`);
                        })
                      }
                    })
                  }
                })
                .key((item) => item.id)
            }
            .divider({
              strokeWidth: SizeToken.SIZE_NUM_12,
              color: $r('sys.color.background_secondary'),
            })
          })
          .key((group) => group.id)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .clipContent(ContentClipMode.SAFE_AREA)
      .padding({
        left: PaddingToken.PADDING_24VP,
        right: PaddingToken.PADDING_24VP
      })
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_24VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_24VP)
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.toast_label'), this.pageParam)
    })
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}