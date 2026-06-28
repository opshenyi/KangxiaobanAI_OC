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
import { Chip, ChipSize, LengthMetrics, SymbolGlyphModifier } from '@kit.ArkUI';
import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';
import { util } from '@kit.ArkTS';

const TAG = 'BasicStyleChip';

/**
 * Define Chip configuration item data structure
 */
interface ChipConfigType {
  id?: string;
  text: string;
  hasPrefix: boolean;
  allowClose: boolean;
}

@ObservedV2
export class ChipConfig {
  public readonly id: string;
  @Trace public text: string;
  @Trace public hasPrefix: boolean;
  @Trace public allowClose: boolean;

  constructor(init: ChipConfigType) {
    this.id = init.id ?? util.generateRandomUUID(true);
    this.text = init.text;
    this.hasPrefix = init.hasPrefix;
    this.allowClose = init.allowClose;
  }
}

@ComponentV2
export struct BasicStyleChip {
  // Extract data source, centralize management of 4 variant differences
  @Local chipOptions: ChipConfig[] = [];

  aboutToAppear(): void {
    if (this.chipOptions.length === 0) {
      this.chipOptions = [
        new ChipConfig({
          id: 'chip_basic',
          text: 'Chips',
          hasPrefix: false,
          allowClose: false
        }),
        new ChipConfig({
          id: 'chip_prefix',
          text: 'Chips',
          hasPrefix: true,
          allowClose: false
        }),
        new ChipConfig({
          id: 'chip_close',
          text: 'Chips',
          hasPrefix: false,
          allowClose: true
        }),
        new ChipConfig({
          id: 'chip_full',
          text: 'Chips',
          hasPrefix: true,
          allowClose: true
        })
      ];
    }
  }

  build() {
    Column() {
      SubTitleView($r('app.string.basic_style_label'))

      Column() {
        Flex({
          direction: FlexDirection.Row,
          wrap: FlexWrap.Wrap,
          space: { main: LengthMetrics.vp(SpaceToken.SPACE_8), cross: LengthMetrics.vp(SpaceToken.SPACE_8) }
        }) {
          ForEach(this.chipOptions, (item: ChipConfig) => {
            Chip({
              // Set prefix icon property, symbol type
              prefixSymbol: item.hasPrefix ? { normal: this.getPrefixSymbol() } : undefined,
              // Priority order for suffix display:
              // 1. suffixSymbol (highest)
              // 2. suffixIcon
              // 3. allowClose (lowest, toggles delete icon)
              allowClose: item.allowClose,
              // Set text property
              label: {
                text: item.text,
                fontSize: $r('sys.float.Body_M'),
                fontColor: $r('sys.color.font_primary'),
                // Spacing between text and side icons (padding-left/right)
                labelMargin: { left: PaddingToken.PADDING_4VP, right: PaddingToken.PADDING_4VP }
              },
              // Chip size
              size: ChipSize.SMALL,
              // Chip selectable
              enabled: true,
              backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
              onClicked: () => {
                Logger.info(TAG, `[${item.id}] clicked.`);
              },
              // Default close icon click handler
              onClose: item.allowClose ? () => {
                Logger.info(TAG, `[${item.id}] closed.`);
              } : undefined
            })
          }, (item: ChipConfig) => item.id)
        }
      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
      .padding({
        left: PaddingToken.PADDING_12VP,
        right: PaddingToken.PADDING_12VP,
        top: PaddingToken.PADDING_16VP,
        bottom: PaddingToken.PADDING_16VP
      })
    }
  }

  /**
   * Extract reusable prefix icon decorator
   * @returns Prefix icon object (SymbolGlyphModifier type)
   */
  private getPrefixSymbol(): SymbolGlyphModifier {
    return new SymbolGlyphModifier($r('sys.symbol.star'))
      .fontSize($r('sys.float.Subtitle_M'))
      .fontColor([$r('sys.color.icon_secondary')]);
  }
}