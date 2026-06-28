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
export struct ListItemView {
  @Param itemId: string = '';
  @Param title: Resource | string = '';
  @Param icon: ResourceStr = '';
  @Param value: Resource | string = '';
  @Param onItemClick: (itemId: string) => void = (_itemId: string) => {
  };
  @Param isSelected: boolean = false;
  @Param hasChevron: boolean = true;

  build() {
    Row() {
      if (this.icon) {
        Image(this.icon)
          .width(32)
          .height(32)
          .margin({ right: 12 })
      }

      Row() {
        Text(this.title)
          .fontSize(16)
          .flexGrow(1)
          .fontColor($r('app.color.color_text_primary'))
          .fontWeight(this.isSelected ? 600 : 500)
      }
      .flexGrow(1)
      .justifyContent(FlexAlign.Start)

      Blank()
      if (this.value) {
        Text(this.value)
          .fontSize(14)
          .fontColor($r('app.color.color_text_secondary'))
          .margin({ right: 8 })
      }
      if (this.hasChevron) {
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize(24)
          .fontColor([$r('app.color.color_icon_tertiary')])
      }
    }
    .width('100%')
    .height(48)
    .onClick(() => {
      this.onItemClick(this.itemId);
    })
    .backgroundColor(this.isSelected ? $r('app.color.color_background_selected') : Color.Transparent)
    .borderRadius(16)
    .padding({ left: 8, right: 8 })
  }
}