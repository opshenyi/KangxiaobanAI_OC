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
import { LengthMetrics, MultiCapsuleSegmentButtonV2, SegmentButtonV2Items } from '@kit.ArkUI';
import { SubTitleView } from '../../../../common/SubTitleView';
import { SpaceToken } from '../../../../designtoken/SpaceToken';

@ComponentV2
export struct MultiSelectSegmentedButton {
  @Param isPC: boolean = false;
  @Local textSelectedIndexes: number[] = [0, 1];
  @Local textItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') }
  ]);
  @Local symbolSelectedIndexes: number[] = [0, 1];
  @Local symbolItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') },
    { symbol: $r('sys.symbol.star_circle_fill') }
  ]);
  @Local hybridSelectedIndexes: number[] = [0, 1];
  @Local hybridItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') },
    { text: $r('app.string.tabs_en_label'), symbol: $r('sys.symbol.star_circle_fill') }
  ]);

  @Computed
  get itemBorderRadius(): LengthMetrics | undefined {
    return this.isPC ? LengthMetrics.vp(6) : undefined;
  }

  build() {
    Column() {
      SubTitleView($r('app.string.multi_select_segmented_button_label'))

      Column({ space: SpaceToken.SPACE_16 }) {
        MultiCapsuleSegmentButtonV2({
          items: this.textItems,
          selectedIndexes: this.textSelectedIndexes!!,
          itemBorderRadius: this.itemBorderRadius
        })

        MultiCapsuleSegmentButtonV2({
          items: this.symbolItems,
          selectedIndexes: this.symbolSelectedIndexes!!,
          itemBorderRadius: this.itemBorderRadius
        })

        MultiCapsuleSegmentButtonV2({
          items: this.hybridItems,
          selectedIndexes: this.hybridSelectedIndexes!!,
          itemBorderRadius: this.itemBorderRadius
        })
      }
    }
  }
}