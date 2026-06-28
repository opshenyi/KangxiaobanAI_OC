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
export struct WlanSecurityCard {
  @Param isEnabled: boolean = true;
  @Event onToggle: (value: boolean) => void = () => {
  };

  build() {
    Column() {
      Row() {
        Text($r('app.string.string_wlan_security'))
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
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor($r('app.color.color_background_card'))
      .borderRadius(16)

      Text($r('app.string.string_wlan_security_desc'))
        .fontSize(14)
        .fontColor($r('app.color.color_text_tertiary'))
        .margin({ top: 12, left: 16, right: 16 })
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .margin({ top: 16 })
  }
}