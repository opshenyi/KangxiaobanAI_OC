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
import { ComponentItem, Logger, SizeToken } from 'componentuxexamplesbase';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  LengthMetrics,
  LengthUnit,
} from '@kit.ArkUI';


@Builder
export function CustomArcButtonBuilder() {
  CustomArcButton()
}

@ComponentV2
export struct CustomArcButton {
  @Local topOptions: ArcButtonOptions = new ArcButtonOptions({});
  @Local bottomOptions: ArcButtonOptions = new ArcButtonOptions({});
  @Local buttonStyle: number = 0;
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };

  build() {
    NavDestination() {
      Stack() {
        Column() {
          ArcButton({ options: this.topOptions })
          Blank()
          ArcButton({ options: this.bottomOptions })
        }.width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)
      }
      .alignContent(Alignment.Center)
      .backgroundColor(Color.Black)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
      switch (this.param.id) {
        case 'normal_button':
          this.buttonStyle = ArcButtonStyleMode.EMPHASIZED_LIGHT;
          break;
        case 'emphasized_button':
          this.buttonStyle = ArcButtonStyleMode.NORMAL_LIGHT;
          break;
        case 'error_button':
          this.buttonStyle = ArcButtonStyleMode.EMPHASIZED_DARK;
          break;
      }

      this.topOptions = new ArcButtonOptions({
        label: $r('app.string.arc_button'),
        status: ArcButtonStatus.NORMAL,
        position: ArcButtonPosition.TOP_EDGE,
        styleMode: this.buttonStyle,
        fontSize: new LengthMetrics(SizeToken.SIZE_NUM_19, LengthUnit.FP),
        shadowEnabled: true
      })

      this.bottomOptions = new ArcButtonOptions({
        label: $r('app.string.arc_button'),
        styleMode: this.buttonStyle,
        fontSize: new LengthMetrics(SizeToken.SIZE_NUM_19, LengthUnit.FP),
        shadowEnabled: true,
        onClick: () => {
          Logger.info('click from ArcButton.')
        }
      })
    })
  }
}