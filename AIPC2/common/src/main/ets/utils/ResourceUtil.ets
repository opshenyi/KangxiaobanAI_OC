/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { JSON, util } from '@kit.ArkTS';
import { StorageKey } from '../constants/CommonEnums';
import Logger from './Logger';

const TAG: string = '[ResourceUtil]';

export class ResourceUtil {
  /**
   * Get content from the raw file resource "env.json" by key.
   * @param context The base context of an ability or an application.
   * @param key The Json key value.
   * @returns Return the value of the key.
   */
  public static getRawFileStringByKey(context: Context, key: ConfigMapKey): string | object {
    const configStr: string | object | undefined = AppStorage.get(StorageKey.WEB_WHITE_LIST);
    if (configStr) {
      return configStr;
    }

    try {
      if (!context) {
        Logger.error(TAG, 'getRawFileStringByKey context is null');
        return '';
      }
      const result: Uint8Array = context.resourceManager.getRawFileContentSync('env.json');
      const textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      const content: string = textDecoder.decodeToString(result, { stream: false });
      const jsonContent: ConfigMapData = JSON.parse(content) as ConfigMapData;
      if (JSON.has(jsonContent, key)) {
        const linkUrl: string | object = jsonContent.webWhitelist;
        AppStorage.setOrCreate(StorageKey.WEB_WHITE_LIST, linkUrl);
        return linkUrl;
      }
      Logger.error(TAG, `GetRawFileContent failed, cause: no ${key} value is configured.`);
      return '';
    } catch (error) {
      Logger.error(TAG, `GetRawFileContent failed, error code: ${error.code}, message: ${error.message}.`);
      return '';
    }
  }
}

export class ConfigMapData {
  public webWhitelist: object[] = [];
}

export enum ConfigMapKey {
  WHITELIST = 'webWhitelist',
}