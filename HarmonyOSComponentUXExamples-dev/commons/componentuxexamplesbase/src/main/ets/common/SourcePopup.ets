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
import { common } from '@kit.AbilityKit';
import { uniformTypeDescriptor } from '@kit.ArkData';
import { systemShare } from '@kit.ShareKit';
import { AppStorageV2 } from '@ohos.arkui.StateManagement';
import { BreakpointModel } from '../model/BreakpointModel';
import { WebLoading, WebUtil } from '../utils/WebUtil';
import { SizeToken } from '../designtoken/SizeToken';
import { LoadingView } from './LoadingView';
import { NoNetworkView } from './NoNetworkView';
import Logger from '../utils/Logger';
import { StorageKey } from '../constants/CommonEnums';
import { deviceInfo } from '@kit.BasicServicesKit';

const TAG = 'SourcePopup';

export class SheetParams {
  public webUrl: string = '';
  public title: ResourceStr = '';
  public resourceName?: string = '';

  constructor(webUrl: string, title: ResourceStr, resourceName?: string) {
    this.webUrl = webUrl;
    this.title = title;
    this.resourceName = resourceName;
  }
}

@ObservedV2
export class CodeSheetShow {
  @Trace public isCodeSheetShow: boolean = false;
  @Trace public sheetParams: SheetParams = new SheetParams('', '');
  @Trace public mainSheetParams: SheetParams = new SheetParams('', '');
}

@Builder
export function WebSheetBuilder(params: SheetParams) {
  WebSheet({ params: params })
}

function handleShare(uiContext: UIContext, params: SheetParams): void {
  const hostContext: Context | undefined = uiContext.getHostContext();
  if (!hostContext) {
    Logger.error(TAG, 'getHostContext returned undefined');
    return;
  }
  const uiAbilityContext = hostContext as common.UIAbilityContext;
  try {
    let titleStr: string = '';
    if (params.resourceName) {
      titleStr = uiAbilityContext.resourceManager.getStringByNameSync(params.resourceName);
    }
    const shareData: systemShare.SharedData = new systemShare.SharedData({
      utd: uniformTypeDescriptor.UniformDataType.HYPERLINK,
      content: params.webUrl,
      title: titleStr,
      description: '',
    });

    const controller: systemShare.ShareController = new systemShare.ShareController(shareData);
    controller.show(uiAbilityContext, {
      selectionMode: systemShare.SelectionMode.SINGLE,
      previewMode: systemShare.SharePreviewMode.DEFAULT
    }).catch((error: BusinessError) => {
      Logger.error(TAG, `Component code sharing error. Code: ${error.code}, message: ${error.message}`);
    });
  } catch (error) {
    const err: BusinessError = error as BusinessError;
    Logger.error(TAG, `handleShare failed, error: ${err.code}, ${err.message}.`);
  }
}

@Builder
export function TitleBuilder(uiContext: UIContext, params: SheetParams) {
  Row() {
    Text($r('app.string.sample_code_label'))
      .maxLines(SizeToken.SIZE_NUM_1)
      .height(SizeToken.SIZE_NUM_24)
      .fontColor($r('sys.color.font_primary'))
      .fontWeight(FontWeight.Bold)
      .fontSize($r('sys.float.Title_S'))
      .textOverflow({ overflow: TextOverflow.Ellipsis })

    if (canIUse('SystemCapability.Collaboration.SystemShare')) {
      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.share'))
          .fontColor([$r('sys.color.icon_primary')])
          .fontSize($r('sys.float.Title_M'))
          .onClick(() => {
            handleShare(uiContext, params);
          })
      }
      .backgroundColor(deviceInfo.deviceType === deviceInfo.DeviceTypes.TYPE_2IN1 ?
        Color.Transparent : $r('sys.color.comp_background_tertiary'))
      .height(SizeToken.SIZE_NUM_40)
      .aspectRatio(SizeToken.SIZE_NUM_1)
    }
  }
  .justifyContent(FlexAlign.SpaceBetween)
  .width(SizeToken.SIZE_PERCENT_100)
}

@ComponentV2
export struct WebSheet {
  @Param params: SheetParams = new SheetParams('', '');
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local loadFailed: boolean = false;
  @Local webLoading: WebLoading | undefined =
    AppStorageV2.connect<WebLoading>(WebLoading, StorageKey.WEB_LOADING, () => new WebLoading());

  aboutToAppear(): void {
    WebUtil.createWebNode(this.params.webUrl, this.getUIContext(), NestedScrollMode.SELF_ONLY);
    this.checkWebLoaded();
  }

  aboutToDisappear(): void {
    AppStorageV2.remove(StorageKey.WEB_LOADING);
  }

  checkWebLoaded() {
    if (!WebUtil.checkWebLoaded(this.params.webUrl)) {
      this.loadFailed = true;
    } else {
      this.loadFailed = false;
    }
  }

  build() {
    Stack() {
      NodeContainer(WebUtil.getWebNode(this.params.webUrl))
        .width(SizeToken.SIZE_PERCENT_100)
      if (this.webLoading?.isLoading) {
        LoadingView(this.breakpointModel.currentWidthBreakpoint)
      } else if (this.loadFailed) {
        NoNetworkView(this.breakpointModel.currentWidthBreakpoint, this.getUIContext(), () => {
          this.checkWebLoaded();
        })
      }
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
  }
}