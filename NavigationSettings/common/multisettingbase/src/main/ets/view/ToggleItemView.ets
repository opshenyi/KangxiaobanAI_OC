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
export struct ToggleItemView {
  @Param title: Resource | string = '';
  @Param isEnabled: boolean = false;
  @Event onToggle: (value: boolean) => void = () => {
  };

  build() {
    Row() {
      Text(this.title)
        .fontSize(16)
        .fontWeight(500)
        .fontColor($r('app.color.color_text_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isEnabled })
        .selectedColor($r('app.color.color_brand'))
        .onChange((isOn: boolean) => {
          this.onToggle(isOn);
        })
    }
    .width('100%')
    .height(48)
    .padding({ left: 8, right: 8 })
  }
}