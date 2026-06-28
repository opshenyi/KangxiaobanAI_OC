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

import { CornerRadiusToken, Logger, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { SymbolGlyphModifier } from '@kit.ArkUI';

const TAG = 'SelectExample';

@Builder
export function SelectExampleBuilder() {
  SelectExample();
}

@ComponentV2
struct SelectExample {
  // Use independent local state for the two dropdowns to avoid cross-interference
  @Local normalSelectValue: ResourceStr = 'Select';
  @Local smallSelectValue: ResourceStr = 'Select';
  // Create a Symbol icon for the menu item
  private startIconModifier: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_circle_fill')).fontSize($r('sys.float.Title_M'));
  // Extract common data source for reuse
  private readonly selectOptions: SelectOption[] = [
    { value: 'Option A', symbolIcon: this.startIconModifier },
    { value: 'Option B', symbolIcon: this.startIconModifier },
    { value: 'Option C', symbolIcon: this.startIconModifier },
    { value: 'Option D', symbolIcon: this.startIconModifier },
  ];

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.size_label'))
          Row({ space: PaddingToken.PADDING_16VP }) {
            // Standard size selector
            Select(this.selectOptions)
              .value(this.normalSelectValue)
              .controlSize(ControlSize.NORMAL)
              .avoidance(AvoidanceMode.COVER_TARGET)
              .onSelect((index: number, value: string) => {
                this.normalSelectValue = value;
                Logger.info(TAG, `Normal select index: ${index}, value: ${value}`);
              })

            // Small size selector
            Select(this.selectOptions)
              .value(this.smallSelectValue)
              .controlSize(ControlSize.SMALL)
              .avoidance(AvoidanceMode.COVER_TARGET)
              .onSelect((index: number, value: string) => {
                this.smallSelectValue = value;
                Logger.info(TAG, `Small select index: ${index}, value: ${value}`);
              })
          }
          .width(SizeToken.SIZE_PERCENT_100)
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
          .backgroundColor($r('app.color.item_background_color'))
          .borderWidth(SizeToken.SIZE_NUM_1)
          .borderColor($r('app.color.item_border_color'))
          .padding(PaddingToken.PADDING_16VP)
        }
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.select_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}