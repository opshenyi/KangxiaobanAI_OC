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
import { SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function ToggleExampleBuilder() {
  ToggleExample()
}

@ComponentV2
export struct ToggleExample {
  @Local private param: string = ''
  @Local private isOn: boolean = true

  build() {
    NavDestination() {
      Row() {
        Text(this.isOn === true ? 'On' : 'Off')
          .fontColor(Color.White)
          .fontSize($r('sys.float.Title_L'))
          .width($r('app.float.item_text_width'))
          .margin({ left: SpaceToken.SPACE_44 })
        Toggle({ type: ToggleType.Switch, isOn: this.isOn })
          .selectedColor($r('app.color.blue_color'))
          .switchPointColor(Color.White)
          .onChange((isOn: boolean) => {
            this.isOn = isOn
          })
      }
      .align(Alignment.Center)
      .width($r('app.float.item_width'))
      .height($r('app.float.item_height'))
      .borderRadius($r('app.float.item_border_radius'))
      .backgroundColor($r('app.color.dark_gray_color'))
      .margin({ top: SizeToken.SIZE_NUM_40 })
    }
    .title({ builder: TitleComponent(this.param), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}