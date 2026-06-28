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

import { CommonConstants, CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct DotIndicatorDemo {
  private swiperController: SwiperController = new SwiperController();
  @Local dataArr: number[] = [];

  aboutToAppear(): void {
    for (let i = CommonConstants.INTEGER_1; i <= CommonConstants.INTEGER_5; i++) {
      this.dataArr.push(i);
    }
  }

  @Builder
  SwiperElement() {
    Stack()
      .width(SizeToken.SIZE_PERCENT_100)
      .layoutWeight(SizeToken.SIZE_NUM_1)
      .height($r('app.float.dot_swiper_item_height'))
      .backgroundColor($r('app.color.item_background_color'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
  }

  build() {
    Column() {
      Swiper(this.swiperController) {
        Repeat<number>(this.dataArr)
          .each(() => {
            Row({ space: PaddingToken.PADDING_16VP }) {
              this.SwiperElement()
              this.SwiperElement()
              this.SwiperElement()
            }
            .margin({ bottom: SizeToken.SIZE_NUM_38 })
          })
      }
      // Set the index value of the child component currently displayed in the container
      .index(CommonConstants.INTEGER_2)
      // Set the spacing between subcomponents
      .itemSpace(PaddingToken.PADDING_16VP)
      // Set digital navigation point style
      .indicator(Indicator.dot())
      // Set to enable scrolling loop
      .loop(true)
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .clip(true)
  }
}