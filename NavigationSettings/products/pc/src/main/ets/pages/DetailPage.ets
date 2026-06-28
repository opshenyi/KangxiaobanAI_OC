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

@ComponentV2
export struct DetailPage {
  @Local title: string = '';
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Text(this.title)
          .fontSize(18)
          .fontWeight(700)
          .margin({ top: 100 })
      }
      .width('100%')
      .height('100%')
    }
    .hideBackButton(true)
    .backgroundColor($r('app.color.color_background_page'))
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.title = context.pathInfo.param as string;
    })
    .title(this.title)
  }
}

@Builder
export function DetailPageBuilder() {
  DetailPage()
}