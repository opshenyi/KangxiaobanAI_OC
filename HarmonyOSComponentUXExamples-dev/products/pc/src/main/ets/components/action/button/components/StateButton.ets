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

import { LengthMetrics } from '@kit.ArkUI';
import { SizeToken, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { ButtonCardStyleModifier } from '../common/CommonStyles';

@ComponentV2
export struct StateButton {
  @Local toggleVal: number[] = [0, 1];
  // Introduces a state variable to track the currently selected index
  @Local selectedIndex: number = 0;

  build() {
    Column() {
      SubTitleView($r('app.string.state_button_label'))

      Column() {
        Flex({
          space: { main: LengthMetrics.vp(SpaceToken.SPACE_12), cross: LengthMetrics.vp(SpaceToken.SPACE_16) },
          justifyContent: FlexAlign.Start
        }) {
          ForEach(this.toggleVal, (item: number, index: number) => {
            Toggle({ type: ToggleType.Button, isOn: this.selectedIndex === index }) {
              Text($r('app.string.state_button_label'))
                .fontSize($r('sys.float.Body_M'))
                .fontColor($r('sys.color.font_primary'))
                .fontWeight(FontWeight.Regular)
            }
            .width(SizeToken.SIZE_NUM_72)
            .height(SizeToken.SIZE_NUM_28)
            .id(`toggle${item}`)
            // Listens for state changes to implement mutual exclusion logic
            .onChange((isOn: boolean) => {
              if (isOn) {
                // When clicked and toggled on, update the selectedIndex
                this.selectedIndex = index;
              }
            })
          }, (item: number, index: number) => `${item}_${index}`)
        }
      }
      .attributeModifier(new ButtonCardStyleModifier())
    }
  }
}