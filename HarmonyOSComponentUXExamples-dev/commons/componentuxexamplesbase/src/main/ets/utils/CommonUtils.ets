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
import { CommonConstants } from '../constants/CommonConstants';
import { WindowUtil } from './WindowUtil';
import { ColorMetrics } from '@kit.ArkUI';
import Logger from './Logger';

export class CommonUtils {
  // Record the timestamp of the last click or popup
  private static lastClickTime: number = 0;

  /**
   * Check whether a click operation can be executed
   * (Keep this method for button debouncing in non-popup scenarios, such as page navigation.)
   */
  public static isClickable(interval: number = CommonConstants.DEFAULT_CLICK_INTERVAL): boolean {
    const currentTime = Date.now();
    if (currentTime - CommonUtils.lastClickTime >= interval) {
      CommonUtils.lastClickTime = currentTime;
      return true;
    }
    return false;
  }

  /**
   * Show a simple toast message with debounce (anti-spam) logic.
   * @param curMsg ResourceStr message to display.
   */
  public static showToast(curMsg: ResourceStr) {
    const currentTime = Date.now();

    // Debounce determination: If the elapsed time since the last operation is less than the default interval,
    // intercept immediately and skip subsequent logic.
    if (currentTime - CommonUtils.lastClickTime < CommonConstants.DEFAULT_CLICK_INTERVAL) {
      Logger.info('Toast ignored due to rapid clicking.');
      return;
    }

    CommonUtils.lastClickTime = currentTime;
    try {
      const mainWindow = WindowUtil.getInstance()?.getMainWindow();
      if (mainWindow) {
        const uiContext = mainWindow.getUIContext();
        uiContext.getPromptAction().showToast({
          message: curMsg,
          duration: CommonConstants.DURATION_2000
        });
      } else {
        Logger.warn('MainWindow is undefined, cannot show toast.');
      }
    } catch (error) {
      Logger.error(`Failed to open toast dialog, error info: ${JSON.stringify(error)}`);
    }
  }

  /**
   * Compares two ResourceStr values for equality.
   *
   * This method handles both raw strings and Resource objects. For Resource objects,
   * it performs a deep comparison based on the resource ID and module information
   * to determine equality, rather than relying on reference identity.
   *
   * @param a - The first ResourceStr to compare.
   * @param b - The second ResourceStr to compare.
   * @returns {boolean} True if the values are considered equal; otherwise, false.
   */
  public static resourceStrEquals(a: ResourceStr, b: ResourceStr): boolean {
    // 1. Check for strict equality (primitive value or reference identity).
    if (a === b) {
      return true;
    }

    // 2. Return false if types do not match (e.g., comparing a string to a Resource).
    if (typeof a !== typeof b) {
      return false;
    }

    if (a === undefined || b === undefined) {
      return a === b;
    }
    // 3. If both are strings, they must be unequal since strict equality was already checked above.
    if (typeof a === 'string') {
      return false;
    }

    // 4. Both are Resource objects; perform a deep comparison.
    let r1 = a as Resource;
    let r2 = b as Resource;

    // Compare core properties. The resource ID is the primary identifier.
    return r1.id === r2.id &&
      r1.bundleName === r2.bundleName &&
      r1.moduleName === r2.moduleName;
  }

  /**
   * Check whther the listItem is pressed.
   * @param event Touch object.
   * @param itemPressed Pressed state.
   * @returns {boolean} True if the item is pressed; otherwise, false.
   */
  public static isListItemPressed(event: TouchEvent, itemPressed: boolean): boolean {
    if (event.type === TouchType.Down) {
      return true;
    }

    if (event.type === TouchType.Up) {
      return false;
    }
    return itemPressed;
  }

  /**
   * Gets the current time formatted as "yyyy-MM-dd HH:mm:ss"
   */
  public static getCurrentFormattedTime(): string {
    const date = new Date();
    const year = date.getFullYear().toString();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const seconds = date.getSeconds().toString().padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  }

  /**
   * Pass in the context and one or multiple ResourceStr objects, return the concatenated string
   */
  static getStrFromResource(context: Context | undefined, ...resources: ResourceStr[]): string {
    // Return empty string if no resources are provided
    if (resources.length === 0) {
      return '';
    }
    let resultStr = '';
    try {
      for (const item of resources) {
        // Filter out invalid null or undefined parameters
        if (item === undefined || item === null) {
          continue;
        }
        if (typeof item === 'string') {
          // If a plain string is passed, concatenate directly
          resultStr += item;
        } else {
          // If a Resource object is passed, resolve via resourceManager
          if (!context) {
            Logger.warn('Context is undefined. Cannot resolve Resource object.');
            // Skip current Resource resolution when context is missing, but continue concatenating other plain strings
            continue;
          }
          resultStr += context.resourceManager.getStringSync(item.id);
        }
      }
    } catch (error) {
      Logger.error(`Failed to obtain string resources, error info: ${JSON.stringify(error)}`);
    }
    return resultStr;
  }

  /**
   * Converts ResourceColor to ColorMetrics
   * @param color The source resource color
   * @param fallbackColor Fallback color when parsing fails (optional)
   * @returns ColorMetrics instance
   */
  static getColorMetrics(color?: ResourceColor,
    fallbackColor: ColorMetrics = CommonConstants.DEFAULT_THEME_COLOR): ColorMetrics {
    // Intercept null values to avoid triggering unnecessary system exceptions
    if (color === undefined || color === null) {
      Logger.warn('getColorMetrics: color is null or undefined, using fallback color.');
      return fallbackColor;
    }
    try {
      return ColorMetrics.resourceColor(color);
    } catch (error) {
      Logger.error(`Failed to instantiate ColorMetrics using ResourceColor. Error info: ${JSON.stringify(error)}`);
      // Return fallback color
      return fallbackColor;
    }
  }
}