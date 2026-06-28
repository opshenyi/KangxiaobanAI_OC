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
import { Logger, SpaceToken, SubTitleView } from 'componentuxexamplesbase';
import { SelectCardStyleModifier } from '../common/CommonStyles';

const TAG = 'DifferentSizeSelect';

@ComponentV2
export struct DifferentSizeSelect {
  // Use independent local state for the two dropdowns to avoid cross-interference
  @Local normalSelectValue: ResourceStr = 'Select';
  @Local smallSelectValue: ResourceStr = 'Select';
  // Extract common data source for reuse
  private readonly selectOptions: SelectOption[] = [
    { value: 'Option A', icon: $r('sys.media.ohos_app_icon') },
    { value: 'Option B', icon: $r('sys.media.ohos_app_icon') },
    { value: 'Option C', icon: $r('sys.media.ohos_app_icon') },
    { value: 'Option D', icon: $r('sys.media.ohos_app_icon') }
  ];

  build() {
    Column() {
      SubTitleView($r('app.string.size_label'))

      Column() {
        Flex({
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.Start,
          space: { main: LengthMetrics.vp(SpaceToken.SPACE_12) }
        }) {
          // Standard size selector
          Select(this.selectOptions)
            .value(this.normalSelectValue)
            .controlSize(ControlSize.NORMAL)
            .avoidance(AvoidanceMode.COVER_TARGET)
            .dividerStyle({
              strokeWidth: LengthMetrics.vp(0),
              color: Color.Transparent
            })
            .onSelect((_index: number, value: string) => {
              this.normalSelectValue = value;
              Logger.info(TAG, `Normal select changed to: ${value}`);
            })

          // Small size selector
          Select(this.selectOptions)
            .value(this.smallSelectValue)
            .controlSize(ControlSize.SMALL)
            .avoidance(AvoidanceMode.COVER_TARGET)
            .dividerStyle({
              strokeWidth: LengthMetrics.vp(0),
              color: Color.Transparent
            })
            .onSelect((_index: number, value: string) => {
              this.smallSelectValue = value;
              Logger.info(TAG, `Small select changed to: ${value}`);
            })
        }
      }
      .attributeModifier(new SelectCardStyleModifier())
    }
  }
}