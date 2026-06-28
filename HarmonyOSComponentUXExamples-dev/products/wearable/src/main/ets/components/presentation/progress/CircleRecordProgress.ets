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
export function CircleRecordProgressBuilder() {
  CircleRecordProgress()
}

@ComponentV2
struct CircleRecordProgress {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };

  build() {
    NavDestination() {
      Column() {
        Row() {
          Stack() {
            Progress({ value: SizeToken.SIZE_NUM_80, total: SizeToken.SIZE_NUM_100, type: ProgressType.Ring })
              .width(SizeToken.SIZE_NUM_50)
              .color($r('app.color.blue_color'))
              .backgroundColor($r('app.color.dark_blue_color'))
              .style({ strokeWidth: SizeToken.SIZE_NUM_4, status: ProgressStatus.PROGRESSING })
            SymbolGlyph($r('sys.symbol.swim_strokes'))
              .fontColor([$r('app.color.blue_color')])
              .fontSize(SizeToken.SIZE_NUM_30)
          }
          .width(SizeToken.SIZE_NUM_50)
          .height(SizeToken.SIZE_NUM_50)
          .margin({ left: SizeToken.SIZE_NUM_8, right: SizeToken.SIZE_NUM_4 })


          Column() {
            Text() {
              Span('1000')
              Span('m')
            }
            .fontSize(SizeToken.SIZE_NUM_20)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)

            Text('10/12')
              .fontSize(SizeToken.SIZE_NUM_16)
              .fontColor($r('app.color.gray_color'))
              .height($r('app.float.title_text_height'))
          }
          .width('210px')
          .height(SizeToken.SIZE_PERCENT_100)
          .justifyContent(FlexAlign.Center)

        }
        .width($r('app.float.home_item_width'))
        .height($r('app.float.home_item_height'))
        .margin({ top: SizeToken.SIZE_NUM_48 })
        .justifyContent(FlexAlign.Start)
        .backgroundColor($r('app.color.dark_gray_color'))
        .borderRadius(SizeToken.SIZE_NUM_72)

      }
    }
    .hideBackButton(true)
    .title({ builder: TitleComponent(this.param.name), height: SizeToken.SIZE_NUM_45 })
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}