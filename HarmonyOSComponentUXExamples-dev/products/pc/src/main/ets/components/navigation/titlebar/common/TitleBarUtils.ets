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
import { HdsTitleBarContentStyle, PaddingOptions, ScrollEffectType, TitleBarStyleOptions } from '@kit.UIDesignKit';
import { PaddingToken } from 'componentuxexamplesbase';

/**
 * Enterprise-grade utility class for standardizing TitleBar configurations
 * across the application. Complies with strict ArkTS constraints (no-spread).
 */
export class TitleBarUtils {
  // Centralized logging domain for the TitleBar module
  public static readonly LOG_DOMAIN: number = 0x0000;
  // Shared standard padding configuration
  public static readonly COMMON_PADDING: PaddingOptions = {
    start: LengthMetrics.vp(PaddingToken.PADDING_16VP),
    end: LengthMetrics.vp(PaddingToken.PADDING_16VP)
  };

  /**
   * Generates the standard scroll and blur effect style configuration.
   * @param isTransparentMode - If true, configures transparent menus and back icons (used in Emphasized pages).
   * @returns Style configuration object for titleBar.
   */
  static getCommonStyleOpts(isTransparentMode: boolean = false): TitleBarStyleOptions {
    // Explicitly build the base content style to avoid ArkTS 'arkts-no-spread' error
    let originalContentStyle: HdsTitleBarContentStyle = {
      titleStyle: {
        mainTitleColor: $r('sys.color.font_primary'),
        subTitleColor: $r('sys.color.font_secondary')
      }
    };

    // Conditionally append properties using standard assignment
    if (isTransparentMode) {
      originalContentStyle.menuStyle = {
        backgroundColor: Color.Transparent,
        iconColor: $r('sys.color.icon_primary')
      };
      originalContentStyle.backIconStyle = {
        backgroundColor: Color.Transparent,
        iconColor: $r('sys.color.icon_primary')
      };
    }

    // Return the fully assembled ArkTS-compliant structure
    return {
      // Title bar dynamic blur style configuration
      scrollEffectOpts: {
        enableScrollEffect: true,
        scrollEffectType: ScrollEffectType.COMMON_BLUR,
        blurEffectiveStartOffset: LengthMetrics.vp(PaddingToken.PADDING_0VP),
        blurEffectiveEndOffset: LengthMetrics.vp(PaddingToken.PADDING_20VP)
      },
      // Initial style configuration for the content area before scrolling
      originalStyle: {
        backgroundStyle: {
          backgroundColor: $r('sys.color.comp_background_list_card')
        },
        contentStyle: originalContentStyle
      },
      // Style configuration for when the content area scrolls beyond blurEffectiveEndOffset
      scrollEffectStyle: {
        backgroundStyle: {
          backgroundColor: $r('sys.color.ohos_id_color_background_transparent')
        },
        contentStyle: {
          titleStyle: {
            mainTitleColor: $r('sys.color.font_primary'),
            subTitleColor: $r('sys.color.font_secondary')
          },
          menuStyle: {
            backgroundColor: isTransparentMode ? Color.Transparent : $r('sys.color.comp_background_tertiary'),
            iconColor: $r('sys.color.icon_primary')
          },
          backIconStyle: {
            backgroundColor: isTransparentMode ? Color.Transparent : $r('sys.color.comp_background_tertiary'),
            iconColor: $r('sys.color.icon_primary')
          }
        }
      }
    };
  }
}