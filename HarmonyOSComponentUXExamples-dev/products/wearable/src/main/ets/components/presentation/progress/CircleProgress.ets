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
import { ComponentItem, SizeToken } from 'componentuxexamplesbase';

@Builder
export function CircleProgressBuilder() {
  CircleProgress()
}

@ComponentV2
struct CircleProgress {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  @Local value: number = 0;
  timerId: number = 0;

  aboutToAppear(): void {
    this.timerId = setInterval(() => {
      if (this.value < 100) {
        this.value += 1;
      } else {
        clearInterval(this.timerId)
      }
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.timerId)
  }

  build() {
    NavDestination() {
      Stack() {
        Text(this.param.name)
          .fontSize($r('sys.float.Title_L'))
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width($r('app.float.title_text_width'))
          .height($r('app.float.title_text_height'))
          .margin({ top: SizeToken.SIZE_NUM_20 })
        Column() {
          Text() {
            Span('' + this.value)
              .fontSize(SizeToken.SIZE_NUM_52)
              .fontColor(Color.White)
            Span('%')
              .fontSize(SizeToken.SIZE_NUM_30)
              .fontColor($r('app.color.gray_color'))
          }
          .fontWeight(FontWeight.Bold)

          Text('Receiving....')
            .fontSize(SizeToken.SIZE_NUM_19)
            .fontColor(Color.White)
            .height($r('app.float.title_text_height'))
        }.width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)
        .justifyContent(FlexAlign.Center)


        Progress({ value: this.value, total: SizeToken.SIZE_NUM_100, type: ProgressType.Ring })
          .width(SizeToken.SIZE_PERCENT_100)
          .color(Color.White)
          .backgroundColor($r('app.color.blue_color'))
          .style({ strokeWidth: SizeToken.SIZE_NUM_10, status: ProgressStatus.LOADING })
      }.alignContent(Alignment.Top)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}