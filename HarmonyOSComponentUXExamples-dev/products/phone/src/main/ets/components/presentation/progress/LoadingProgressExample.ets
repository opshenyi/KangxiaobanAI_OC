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
import { LengthMetrics } from '@kit.ArkUI';
import { HdsNavDestination } from '@kit.UIDesignKit';
import { BreakpointModel, ComponentItem, HdsUtil, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@Builder
export function LoadingProgressExampleBuilder() {
  LoadingProgressExample()
}

@ComponentV2
struct LoadingProgressExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  build() {
    HdsNavDestination() {
      Column() {
        LoadingProgress()
          .width(SizeToken.SIZE_NUM_56)
          .height(SizeToken.SIZE_NUM_56)

        Text($r('app.string.downloading_tips_label'))
          .fontSize($r('sys.float.Subtitle_S'))
          .fontColor($r('app.color.loading_progress_font_color'))
          .fontWeight(FontWeight.Regular)
      }
      .justifyContent(FlexAlign.Center)
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .titleBar({
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: {
        title: {
          mainTitle: $r('app.string.loading_progress_label')
        }
      }
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }
}