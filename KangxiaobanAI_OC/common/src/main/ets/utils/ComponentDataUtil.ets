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

import { util } from '@kit.ArkTS';
import Logger from './Logger';
import { common } from '@kit.AbilityKit';
import { ComponentGroup } from '../model/ComponentGroup';
import { ComponentItem } from '../model/ComponentItem';

const TAG = 'ComponentDataUtil';

/**
 * JSON representation of a component item.
 * Used for parsing component data from JSON configuration files.
 */
export interface ComponentItemJson {
  id: string;
  name: string;
  url: string;
  sourceUrl?: string;
}

/**
 * JSON representation of a component group.
 * Contains a group title and a list of component items.
 */
export interface ComponentGroupJson {
  id: string;
  title: string;
  items: ComponentItemJson[];
}

/**
 * JSON configuration structure for component data.
 * Root object that contains all component groups.
 */
export interface ComponentConfigJson {
  componentData: ComponentGroupJson[];
}

/**
 * JSON structure for code source URL configuration.
 */
export interface CodeSourceUrlJson {
  mainSourceUrl: string;
}

/**
 * ComponentDataUtil class provides static methods for loading
 * and converting component configuration data from JSON files.
 */
export class ComponentDataUtil {
  /**
   * Converts a string reference to a Resource object.
   *
   * Supports the format '$string:key' which will be converted to $r('app.string.key').
   * If the string doesn't start with '$string:', it will be treated as a direct key.
   *
   * @param str - The string to convert, e.g., '$string:navigation_components_label'
   * @returns Resource object for UI display
   */
  private static convertStringToResource(str: string): Resource {
    if (str.startsWith('$string:')) {
      const key = str.replace('$string:', '');
      return $r(`app.string.${key}`);
    }
    return $r(`app.string.${str}`);
  }

  /**
   * Loads code source URL from a JSON file in rawfile resources.
   * 
   * @param context - UIAbilityContext for accessing resource manager
   * @param jsonFileName - Name of the JSON file, e.g., 'code-source-url.json'
   * @returns Main source URL string, or empty string if loading fails
   */
  public static loadCodeSourceUrl(context: common.UIAbilityContext, jsonFileName: string): string {
    try {
      const resMgr = context.resourceManager;
      const fileData = resMgr.getRawFileContentSync(jsonFileName);
      const decoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      const jsonString = decoder.decodeToString(fileData);
      const config: CodeSourceUrlJson = JSON.parse(jsonString) as CodeSourceUrlJson;
      return config.mainSourceUrl ?? '';
    } catch (err) {
      Logger.error(TAG, `Failed to load code source URL from ${jsonFileName}: ${JSON.stringify(err)}`);
      return '';
    }
  }

  /**
   * Loads component configuration data from a JSON file in rawfile resources.
   *
   * This method reads the specified JSON file, parses it, and converts
   * string references to Resource objects. The resulting data can be used
   * directly in UI components.
   *
   * @param context - UIAbilityContext for accessing resource manager
   * @param jsonFileName - Name of the JSON file in rawfile directory, e.g., 'component-data-phone.json'
   * @returns Array of ComponentGroup objects, or empty array if loading fails
   */
  public static loadComponentData(context: common.UIAbilityContext, jsonFileName: string): ComponentGroup[] {
    try {
      const resMgr = context.resourceManager;
      const fileData = resMgr.getRawFileContentSync(jsonFileName);
      const decoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      const jsonString = decoder.decodeToString(fileData);
      const config: ComponentConfigJson = JSON.parse(jsonString) as ComponentConfigJson;

      return config.componentData.map((group: ComponentGroupJson): ComponentGroup => {
        return {
          id: group.id,
          title: ComponentDataUtil.convertStringToResource(group.title),
          items: group.items.map((item: ComponentItemJson): ComponentItem => {
            return {
              id: item.id,
              name: ComponentDataUtil.convertStringToResource(item.name),
              url: item.url,
              sourceUrl: item.sourceUrl ?? '',
              resourceNme: item.name.replace('$string:', '')
            };
          })
        };
      });
    } catch (err) {
      Logger.error(TAG, `Failed to load component data from ${jsonFileName}: ${JSON.stringify(err)}`);
      return [];
    }
  }
}