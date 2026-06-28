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
import { CapsuleSegmentButtonV2, ColorMetrics, SegmentButtonV2Items } from '@kit.ArkUI';
import Logger from '../../../../utils/Logger';
import { LengthMetrics } from '@ohos.arkui.node';
import { SubTitleView } from '../../../../common/SubTitleView';
import { SpaceToken } from '../../../../designtoken/SpaceToken';

// Define constants for logging to improve maintainability
const TAG = 'SingleSelectSegmentedButton';

@ComponentV2
export struct SingleSelectSegmentedButton {
  @Param isPC: boolean = false;
  // Selected Indexes
  @Local textSelectedIndex: number = 1;
  @Local symbolSelectedIndex: number = 1;
  @Local hybridSelectedIndex: number = 1;
  // Color configuration
  @Local itemSelectedFontColor?: ColorMetrics = undefined;
  @Local itemSelectedBackgroundColor?: ColorMetrics = undefined;
  @Local itemSelectedSymbolFontColor?: ColorMetrics = undefined;
  // Data Sources
  @Local textItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') }
  ]);
  @Local symbolItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') }
  ]);
  @Local hybridItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') }
  ]);

  @Computed
  get buttonBorderRadius(): LengthMetrics | undefined {
    return this.isPC ? LengthMetrics.vp(8) : undefined;
  }

  @Computed
  get itemBorderRadius(): LengthMetrics | undefined {
    return this.isPC ? LengthMetrics.vp(6) : undefined;
  }

  aboutToAppear(): void {
    this.itemSelectedFontColor = this.loadColor($r('sys.color.font_primary'), 'itemSelectedFontColor');
    this.itemSelectedBackgroundColor =
      this.loadColor($r('sys.color.segment_button_v2_tab_selected_item_background'), 'itemSelectedBackgroundColor');
    this.itemSelectedSymbolFontColor = this.loadColor($r('sys.color.font_primary'), 'itemSelectedSymbolFontColor');
  }

  build() {
    Column() {
      SubTitleView($r('app.string.single_select_segmented_button_label'))

      Column({ space: SpaceToken.SPACE_16 }) {
        CapsuleSegmentButtonV2({
          items: this.textItems,
          selectedIndex: this.textSelectedIndex!!,
          itemSelectedFontColor: this.itemSelectedFontColor,
          itemSelectedBackgroundColor: this.itemSelectedBackgroundColor,
          buttonBorderRadius: this.buttonBorderRadius,
          itemBorderRadius: this.itemBorderRadius,
        })

        CapsuleSegmentButtonV2({
          items: this.symbolItems,
          selectedIndex: this.symbolSelectedIndex!!,
          itemSelectedSymbolFontColor: this.itemSelectedSymbolFontColor,
          itemSelectedBackgroundColor: this.itemSelectedBackgroundColor,
          buttonBorderRadius: this.buttonBorderRadius,
          itemBorderRadius: this.itemBorderRadius,
        })

        CapsuleSegmentButtonV2({
          items: this.hybridItems,
          selectedIndex: this.hybridSelectedIndex!!,
          itemSelectedFontColor: this.itemSelectedFontColor,
          itemSelectedSymbolFontColor: this.itemSelectedSymbolFontColor,
          itemSelectedBackgroundColor: this.itemSelectedBackgroundColor,
          buttonBorderRadius: this.buttonBorderRadius,
          itemBorderRadius: this.itemBorderRadius,
        })
      }
    }
  }

  /**
   * Extract the common utility method for loading ColorMetrics
   */
  private loadColor(resource: Resource, propName: string): ColorMetrics | undefined {
    try {
      return ColorMetrics.resourceColor(resource);
    } catch (error) {
      Logger.error(TAG, `Failed to instantiate '${propName}', error info: ${JSON.stringify(error)}`);
      return undefined;
    }
  }
}