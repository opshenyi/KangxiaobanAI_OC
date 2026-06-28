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
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function LinearProgressBuilder() {
  LinearProgress()
}

@ComponentV2
struct LinearProgress {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };

  build() {
    NavDestination() {
      Column() {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text($r('app.string.fast_walk_label'))
            .fontSize('26px')
            .fontColor($r('app.color.gray_color'))
          Text($r('app.string.twenty_minute_label'))
            .fontSize('26px')
            .fontColor($r('app.color.gray_color'))
        }
        .width(SizeToken.SIZE_PERCENT_100)

        Progress({ value: SizeToken.SIZE_NUM_72, total: SizeToken.SIZE_NUM_100, type: ProgressType.Capsule })
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_6)
          .color($r('app.color.green_color'))
          .backgroundColor($r('app.color.dark_gray_color'))
          .margin({ top: SizeToken.SIZE_NUM_4, bottom: SizeToken.SIZE_NUM_12 })

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text($r('app.string.slow_walk_label'))
            .fontSize('26px')
            .fontColor($r('app.color.gray_color'))
          Text($r('app.string.twenty_minute_label'))
            .fontSize('26px')
            .fontColor($r('app.color.gray_color'))
        }
        .width(SizeToken.SIZE_PERCENT_100)

        Progress({ value: SizeToken.SIZE_NUM_72, total: SizeToken.SIZE_NUM_100, type: ProgressType.Capsule })
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_6)
          .color($r('app.color.blue_color'))
          .backgroundColor($r('app.color.dark_gray_color'))
          .margin({ top: SizeToken.SIZE_NUM_4 })
      }
      .margin({ top: SizeToken.SIZE_NUM_28 })
      .width(SizeToken.SIZE_NUM_181)
      .height(SizeToken.SIZE_NUM_58)
    }
    .title({ builder: TitleComponent(this.param.name), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}