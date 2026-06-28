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
import { deviceInfo } from '@kit.BasicServicesKit';
import {
  hdsMaterial,
  ScrollEffectType,
  SystemMaterialParams,
  TitleBarContentOptions,
  TitleBarStyleOptions
} from '@kit.UIDesignKit';
import { AppStorageV2, UIContext } from '@kit.ArkUI';
import { CodeSheetShow, SheetParams } from '../common/SourcePopup';
import Logger from './Logger';
import { ComponentItem } from '../model/ComponentItem';
import { StorageKey } from '../constants/CommonEnums';

const TAG = 'HdsUtil';

export class HdsUtil {
  public static isSupportNewMaterialApi(): boolean {
    return deviceInfo.distributionOSApiVersion >= 60100;
  }

  public static getHdsStyle(): TitleBarStyleOptions {
    if (!canIUse('SystemCapability.UIDesign.HDSComponent.Core') || !HdsUtil.isSupportNewMaterialApi()) {
      return {};
    }
    try {
      let materialParams: SystemMaterialParams = {};
      let materialTypes: hdsMaterial.MaterialType[] = hdsMaterial.getSystemMaterialTypes();
      if (materialTypes.length > 0) {
        materialParams = {
          materialType: hdsMaterial.MaterialType.ADAPTIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE,
        }
      }
      return {
        systemMaterialEffect: materialParams,
        scrollEffectOpts: {
          enableScrollEffect: false,
          scrollEffectType: ScrollEffectType.GRADIENT_BLUR
        }
      }
    } catch (err) {
      let message = (err as BusinessError).message;
      let code = (err as BusinessError).code;
      Logger.error(TAG, `getHdsStyle failed, code: ${code}, message: ${message}`);
    }
    return {}
  }

  public static getHdsContent(_uiContext: UIContext, title: ResourceStr,
    pageParam: ComponentItem, menuIcon: Resource | undefined = $r('sys.symbol.code_1')): TitleBarContentOptions {
    if (!canIUse('SystemCapability.UIDesign.HDSComponent.Core')) {
      return {};
    }

    return {
      title: {
        mainTitle: title
      },
      menu: {
        value: [{
          content: {
            icon: menuIcon,
            label: menuIcon.id === $r('sys.symbol.code').id ? $r('app.string.project_source_label') :
              $r('app.string.components_source_label'),
            isEnabled: true,
            action: () => {
              if (!pageParam.sourceUrl) {
                Logger.error(TAG, 'sourceUrl is undefined');
                return;
              }
              let codeSheetShow: CodeSheetShow | undefined =
                AppStorageV2.connect<CodeSheetShow>(CodeSheetShow, StorageKey.CODE_SHEET_SHOW,
                  () => new CodeSheetShow());
              if (codeSheetShow !== undefined) {
                codeSheetShow.isCodeSheetShow = true;
                // If it is the source code sharing icon on the homepage
                if (menuIcon.id === $r('sys.symbol.code').id) {
                  codeSheetShow.sheetParams = codeSheetShow.mainSheetParams;
                } else {
                  codeSheetShow.sheetParams =
                    new SheetParams(pageParam.sourceUrl, pageParam.name, pageParam.resourceNme);
                }
              }
            }
          }
        }]
      }
    }
  }
}
