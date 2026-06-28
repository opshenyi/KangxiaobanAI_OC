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
import { ColorMetrics } from '@kit.ArkUI';

export interface ImageInfo {
  imgSrc: Resource;
  imgDescription: ResourceStr;
  littleIcon?: Resource;
}

export class CommonConstants {
  // router name
  public static readonly LOADING_PROGRESS_EXAMPLE_NAME: string = 'LoadingProgressExample';
  public static readonly LANDSCAPE_SNACK_BAR_NAME: string = 'LandscapeSnackBarExample';
  public static readonly LANDSCAPE_BIND_SHEET_NAME: string = 'LandscapeBindSheetExample';
  public static readonly FULL_WIDTH_DETAIL_TEXT_BOX_NAME: string = 'FullWidthDetailTextBox';
  public static readonly EMPTY_PAGE_NAME: string = 'EmptyPage';
  public static readonly PHONE_DIALER_PAGE_NAME: string = 'PhoneDialerPage';
  public static readonly BADGE_TAB_BAR_NAME: string = 'BadgeTabBar';
  public static readonly BIND_SHEET_EMPTY_PAGE_NAME: string = 'BindSheetEmptyPage';
  /**
   * The index value 2 of the Tab
   */
  public static readonly TAB_INDEX_TWO: number = 2;
  /**
   * Image data array.
   */
  public static readonly IMAGE_ARRAY: Resource[] = [
    $r('app.media.img_1'),
    $r('app.media.img_2'),
    $r('app.media.img_3'),
    $r('app.media.img_4'),
    $r('app.media.img_5'),
    $r('app.media.img_6'),
    $r('app.media.img_7'),
    $r('app.media.img_8'),
    $r('app.media.img_9'),
    $r('app.media.img_10'),
    $r('app.media.img_11'),
    $r('app.media.img_12'),
    $r('app.media.img_13'),
    $r('app.media.img_14'),
    $r('app.media.img_15'),
    $r('app.media.img_16'),
    $r('app.media.img_17'),
    $r('app.media.img_18'),
    $r('app.media.img_19'),
    $r('app.media.img_20')
  ];
  public static readonly IMAGE_DETAIL_DATA: ImageInfo[] = [
    {
      imgSrc: $r('app.media.img_1'),
      imgDescription: $r('app.string.music_description_1_label'),
    },
    {
      imgSrc: $r('app.media.img_2'),
      imgDescription: $r('app.string.music_description_2_label'),
      littleIcon: $r('sys.symbol.video_fill')
    },
    {
      imgSrc: $r('app.media.img_3'),
      imgDescription: $r('app.string.music_description_3_label'),
      littleIcon: $r('sys.symbol.heart_fill')
    },
    {
      imgSrc: $r('app.media.img_4'),
      imgDescription: $r('app.string.music_description_4_label')
    },
    {
      imgSrc: $r('app.media.img_5'),
      imgDescription: $r('app.string.music_description_5_label')
    },
    {
      imgSrc: $r('app.media.img_6'),
      imgDescription: $r('app.string.music_description_6_label'),
      littleIcon: $r('sys.symbol.heart_fill')
    },
    {
      imgSrc: $r('app.media.img_7'),
      imgDescription: $r('app.string.music_description_7_label')
    },
    {
      imgSrc: $r('app.media.img_8'),
      imgDescription: $r('app.string.music_description_8_label'),
      littleIcon: $r('sys.symbol.video_fill')
    },
    {
      imgSrc: $r('app.media.img_9'),
      imgDescription: $r('app.string.music_description_9_label'),
      littleIcon: $r('sys.symbol.heart_fill')
    },
    {
      imgSrc: $r('app.media.img_10'),
      imgDescription: $r('app.string.music_description_10_label')
    },
    {
      imgSrc: $r('app.media.img_11'),
      imgDescription: $r('app.string.music_description_1_label')
    },
    {
      imgSrc: $r('app.media.img_12'),
      imgDescription: $r('app.string.music_description_2_label'),
      littleIcon: $r('sys.symbol.heart_fill')
    }
  ];
  /**
   * Image grid margin.
   */
  public static readonly VIDEO_GRID_MARGIN: number[] = [32, 48, 64];
  /**
   * Lg sidebar width.
   */
  public static readonly LG_SIDEBAR_WIDTH: number = 96;
  /**
   * Image grid item space.
   */
  public static readonly VIDEO_GRID_ITEM_SPACE: number = 12;
  /**
   * Video dialog aspect ratio.
   */
  public static readonly VIDEO_DIALOG_ASPECT_RATIO: number = 1.74;
  /**
   * Video grid description height.
   */
  public static readonly VIDEO_GRID_DESCRIPTION_HEIGHT: number = 120;
  /**
   * Height unit.
   */
  public static readonly HEIGHT_UNIT: string = 'vp';
  /**
   * Device types.
   */
  public static readonly DEVICE_TYPE: string = '2in1';
  /**
   * Margin of window floating.
   */
  public static readonly WINDOW_FLOATING_MARGIN: number = 5.2;
  /**
   * Video grid column list.
   */
  public static readonly VIDEO_GRID_COLUMNS: string[] =
    ['1fr', '1fr 1fr', '1fr 1fr 1fr', '1fr 1fr 1fr 1fr', '1fr 1fr 1fr 1fr 1fr',
      '1fr 1fr 1fr 1fr 1fr 1fr 1fr'];
  /**
   * Define the debounce interval time (unit: milliseconds).
   * For example, multiple pop-ups are not allowed within 2000ms.
   */
  public static readonly DEFAULT_CLICK_INTERVAL: number = 2000;
  public static readonly LAYOUT_WEIGHT_1: number = 1;
  // duration time
  public static readonly DURATION_NEGATIVE_1: number = -1;
  public static readonly DURATION_0: number = 0;
  public static readonly DURATION_100: number = 100;
  public static readonly DURATION_150: number = 150;
  public static readonly DURATION_200: number = 200;
  public static readonly DURATION_250: number = 250;
  public static readonly DURATION_300: number = 300;
  public static readonly DURATION_350: number = 350;
  public static readonly DURATION_400: number = 400;
  public static readonly DURATION_500: number = 500;
  public static readonly DURATION_2000: number = 2000;
  public static readonly DURATION_2500: number = 2500;
  public static readonly DURATION_3000: number = 3000;
  // sheet height ratio
  public static readonly SHEET_HEIGHT_RATIO_SMALL: number = 0.2;
  public static readonly SHEET_HEIGHT_RATIO_MEDIUM: number = 0.3;
  // Non-negative integer
  public static readonly INTEGER_0: number = 0;
  public static readonly INTEGER_1: number = 1;
  public static readonly INTEGER_2: number = 2;
  public static readonly INTEGER_3: number = 3;
  public static readonly INTEGER_4: number = 4;
  public static readonly INTEGER_5: number = 5;
  public static readonly INTEGER_7: number = 7;
  public static readonly INTEGER_8: number = 8;
  public static readonly INTEGER_10: number = 10;
  public static readonly INTEGER_30: number = 30;
  public static readonly INTEGER_36: number = 36;
  public static readonly INTEGER_50: number = 50;
  public static readonly INTEGER_99: number = 99;
  public static readonly INTEGER_100: number = 100;
  public static readonly INTEGER_135: number = 135;
  public static readonly INTEGER_180: number = 180;
  public static readonly INTEGER_225: number = 225;
  public static readonly INTEGER_1000: number = 1000;
  // Float value
  public static readonly FLOAT_0_POINT_5: number = 0.5;
  public static readonly FLOAT_0_POINT_8: number = 0.8;
  public static readonly FLOAT_1: number = 1.0;
  // Counter-related value
  public static readonly COUNTER_MAX_VALUE: number = 1000;
  public static readonly COUNTER_MIN_VALUE: number = 0;
  public static readonly COUNTER_STEP_VALUE_1: number = 1;
  public static readonly COUNTER_STEP_VALUE_2: number = 2;
  public static readonly COUNTER_INITIAL_VALUE: number = 999;
  public static readonly COUNTER_DATA_YEAR: number = 2016;
  public static readonly COUNTER_DATA_MONTH: number = 1;
  public static readonly COUNTER_DATA_DAY: number = 1;
  // Threshold related to the text field
  public static readonly TEXT_MAX_LINES_1: number = 1;
  public static readonly TEXT_MAX_LINES_2: number = 2;
  public static readonly TEXT_MAX_LINES_3: number = 3;
  public static readonly TEXT_MAX_LENGTH_10: number = 10;
  public static readonly TEXT_MAX_LENGTH_13: number = 13;
  public static readonly TEXT_MAX_LENGTH_20: number = 20;
  public static readonly TEXT_MAX_LENGTH_100: number = 100;
  public static readonly TEXT_THRESHOLD_PERCENTAGE: number = 1;
  // Index of the default selected tab
  public static readonly DEFAULT_SELECTED_TAB_INDEX_1: number = 1;
  public static readonly DEFAULT_SELECTED_TAB_INDEX_2: number = 2;
  // Offset value
  public static readonly Y_AXIS_NEGATIVE_OFFSET_8: number = -8;
  public static readonly Y_AXIS_OFFSET_40: number = 40;
  // The number of columns in the current grid layout
  public static readonly COLUMNS_TEMPLATE_1: string = '1fr';
  public static readonly COLUMNS_TEMPLATE_2: string = '1fr 1fr';
  public static readonly COLUMNS_TEMPLATE_3: string = '1fr 1fr 1fr';
  public static readonly COLUMNS_TEMPLATE_4: string = '1fr 1fr 1fr 1fr';
  public static readonly COLUMNS_TEMPLATE_5: string = '1fr 1fr 1fr 1fr 1fr';
  // Empty string
  public static readonly EMPTY_STRING: string = '';
  // Default color
  public static readonly DEFAULT_THEME_COLOR: ColorMetrics = ColorMetrics.rgba(10, 89, 247);
}