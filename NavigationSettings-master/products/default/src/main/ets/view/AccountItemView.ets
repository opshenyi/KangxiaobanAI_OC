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
export struct AccountItemView {
  @Param icon: ResourceStr = '';
  @Param title: Resource | string = '';
  @Param subtitle: Resource | string = '';
  @Param onItemClick: () => void = () => {
  };
  @Param isSelected: boolean = false;

  build() {
    Row() {
      Column() {
        Column() {
          if (this.icon) {
            SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
              .fontSize(64)
              .fontColor([$r('app.color.font_tertiary')])
          }
        }
      }
      .width(64)
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(this.title)
          .fontSize(20)
          .fontWeight(500)
          .fontColor($r('app.color.color_text_primary'))

        if (this.subtitle) {
          Text(this.subtitle)
            .fontSize(12)
            .fontColor($r('app.color.color_text_secondary'))
            .margin({ top: 4 })
        }
      }
      .flexGrow(1)
      .padding({ left: 12 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
    }
    .width('100%')
    .height(80)
    .borderRadius(16)
    .padding({ left: 8, right: 8 })
    .onClick(() => {
      this.onItemClick();
    })
    .backgroundColor(this.isSelected ? $r('app.color.color_background_selected') : Color.Transparent)
  }
}