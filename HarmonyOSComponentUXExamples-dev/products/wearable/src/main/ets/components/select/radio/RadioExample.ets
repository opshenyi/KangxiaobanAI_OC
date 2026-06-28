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
import { Logger, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

const TAG = 'RadioExample';

@Builder
export function RadioExampleBuilder() {
  RadioExample()
}

@ComponentV2
export struct RadioExample {
  @Local private param: string = ''
  @Local private isChecked: boolean = true
  @Local private isChecked2: boolean = false

  build() {
    NavDestination() {
      Row() {
        Column() {
          Text(this.isChecked === true ? $r('app.string.selected') : $r('app.string.not_selected'))
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
            .width(SizeToken.SIZE_PERCENT_100)
          Radio({ value: 'Radio1', group: 'radioGroup' })
            .checked(this.isChecked)
            .radioStyle({
              checkedBackgroundColor: $r('app.color.blue_color')
            })
            .height(SizeToken.SIZE_NUM_20)
            .width(SizeToken.SIZE_NUM_20)
.onChange((isChecked: boolean) => {
              Logger.info(TAG, 'Radio1 status is ' + isChecked);
              this.isChecked = isChecked
            })
        }.width(SizeToken.SIZE_NUM_60)
        .height(SizeToken.SIZE_NUM_45)

        Column() {
          Text(this.isChecked2 === true ? $r('app.string.selected') : $r('app.string.not_selected'))
            .fontColor(Color.White)
            .fontSize($r('sys.float.Title_L'))
            .width(SizeToken.SIZE_PERCENT_100)
          Radio({ value: 'Radio1', group: 'radioGroup' })
            .checked(this.isChecked2)
            .radioStyle({
              checkedBackgroundColor: $r('app.color.blue_color')
            })
            .height(SizeToken.SIZE_NUM_20)
            .width(SizeToken.SIZE_NUM_20)
.onChange((isChecked: boolean) => {
              Logger.info(TAG, 'Radio1 status is ' + isChecked);
              this.isChecked2 = isChecked
            })
        }.width(SizeToken.SIZE_NUM_60)
        .height(SizeToken.SIZE_NUM_45)
        .margin({ left: SpaceToken.SPACE_60 })
      }
      .justifyContent(FlexAlign.Center)
      .width($r('app.float.item_width'))
      .height($r('app.float.home_item_height'))
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
      .margin({ top: SizeToken.SIZE_NUM_36 })
    }
    .title({ builder: TitleComponent(this.param), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}