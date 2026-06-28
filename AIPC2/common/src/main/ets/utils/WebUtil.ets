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
import { BuilderNode, FrameNode, NodeController, UIContext, window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { uri } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import { AppStorageV2 } from '@ohos.arkui.StateManagement';
import { SizeToken } from '../designtoken/SizeToken';
import { NetworkUtil } from './NetworkUtil';
import { ComponentDataUtil } from './ComponentDataUtil';
import { common, Want } from '@kit.AbilityKit';
import Logger from './Logger';
import { ProcessUtil } from './ProcessUtil';
import { ConfigMapKey, ResourceUtil } from './ResourceUtil';
import { StorageKey } from '../constants/CommonEnums';

const TAG: string = '[WebUtil]';

const webNodeMap: Map<string, WebNodeController> = new Map();
const webControllerMap: Map<string, WebviewController | undefined> = new Map();
// Check whether web node is required again
const nodeRequiredMap: Map<string, boolean> = new Map();
const webLoadedMap: Map<string, boolean> = new Map();

interface WebBuilderParam {
  webUrl: string;
  webController: WebviewController;
  nestedScroll: NestedScrollOptions;
  onlyWhiteMode?: boolean;
  verticalScrollBarAccess?: boolean;
}

@ObservedV2
export class WebLoading {
  @Trace public isLoading: boolean = false;
}

@Builder
function webBuilder(param: WebBuilderParam) {
  Web({ src: param.webUrl, controller: param.webController })
    .zoomAccess(false)
    .fileAccess(false)
    .imageAccess(true)
    .mixedMode(MixedMode.None)
    .verticalScrollBarAccess(param.verticalScrollBarAccess)
    .horizontalScrollBarAccess(false)
    .cacheMode(CacheMode.Default)
    .domStorageAccess(true)
    .javaScriptAccess(true)
    .geolocationAccess(false)
    .backgroundColor(Color.Transparent)
    .nestedScroll(param.nestedScroll)
    .darkMode(param.onlyWhiteMode ? WebDarkMode.Off : WebDarkMode.Auto)
    .forceDarkAccess(true)
    .allowDrop(null)
    .onPageBegin(() => {
      try {
        param.webController.onActive();
        Logger.debug(TAG, `onPageBegin with url: ${param.webUrl}`);
      } catch (error) {
        Logger.error(TAG, `onPageBegin with url: ${param.webUrl} failed. error ${error.message}`);
      }
    })
    .onPageEnd(() => {
      let webLoading: WebLoading | undefined =
        AppStorageV2.connect<WebLoading>(WebLoading, StorageKey.WEB_LOADING, () => new WebLoading());
      if (webLoading !== undefined) {
        webLoading.isLoading = false;
      }
      Logger.debug(TAG, `onPageEnd with url: ${param.webUrl}`);
    })
    .onLoadIntercept((event: OnLoadInterceptEvent) => {
      return WebUtil.handleLoadIntercept(event);
    })
    .onSslErrorEventReceive((event) => {
      Logger.error(TAG, `SSL checked failed, error: ${event.error.toString()}`);
      event.handler.handleCancel();
    })
    .onControllerAttached(() => {
      try {
        param.webController.onActive();
        const userAgent = `${param.webController.getUserAgent()} Mobile (Phone; OpenHarmony)`;
        param.webController.setCustomUserAgent(userAgent);
      } catch (error) {
        const err: BusinessError = error as BusinessError;
        Logger.error(TAG, `Web User-Agent setting error: ${err.code}, ${err.message}.`);
      }
    })
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_PERCENT_100)
}

export class WebUtil {
  public static uiContext: UIContext;

  public static initialize(windowStage: window.WindowStage) {
    try {
      WebUtil.uiContext = windowStage.getMainWindowSync().getUIContext();
      webNodeMap.clear();
      webControllerMap.clear();
      nodeRequiredMap.clear();
      webNodeMap.clear();
      webview.WebviewController.initializeWebEngine();
      let context: common.UIAbilityContext = WebUtil.uiContext.getHostContext() as common.UIAbilityContext;
      let mainSourceUrl: string = ComponentDataUtil.loadCodeSourceUrl(context, 'code-source-url.json');
      WebUtil.createWebNode(mainSourceUrl, WebUtil.uiContext);
    } catch (err) {
      Logger.error(TAG, `WebUtil initialize failed. Cause: ${err.code} ${err.message}`);
    }
  }

  public static removeNode(url: string) {
    if (nodeRequiredMap.has(url)) {
      Logger.debug(TAG, `Web Node is Required again, should not dispose: ${url}`);
      nodeRequiredMap.delete(url);
      return;
    }
    const webNode = WebUtil.getWebNode(url);
    webNode?.disposeNode();
    webLoadedMap.delete(url);
    webNodeMap.delete(url);
    webControllerMap.delete(url);
    AppStorage.delete(StorageKey.WEB_WHITE_LIST);
    Logger.debug(TAG, `removeNode with url: ${url}`);
  }

  public static checkWebLoaded(url: string): boolean {
    try {
      const loaded: boolean = !!webLoadedMap.get(url);
      if (!loaded && NetworkUtil.hasDefaultNet()) {
        const webController = WebUtil.getWebController(url);
        let webLoading: WebLoading | undefined =
          AppStorageV2.connect<WebLoading>(WebLoading, StorageKey.WEB_LOADING, () => new WebLoading());
        if (webLoading !== undefined) {
          webLoading.isLoading = true;
        }
        webLoadedMap.set(url, true);
        webController?.refresh();
        return true;
      }
      return loaded;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      Logger.error(TAG, `Failed to CheckWebLoaded, ${err.code}, ${err.message}`);
      return false;
    }
  }

  public static handleLoadIntercept(event: OnLoadInterceptEvent): boolean {
    const tempUrl = event.data.getRequestUrl();
    if (!event.data.isMainFrame()) {
      return true;
    }
    if (WebUtil.checkUrl(tempUrl)) {
      return false;
    }
    let want: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: tempUrl,
      parameters: {
        'ohos.ability.params.showDefaultPicker': true
      }
    };
    const uiContext = AppStorage.get<UIContext>(StorageKey.UI_CONTEXT);
    const context = uiContext?.getHostContext();
    if (!context) {
      Logger.error(TAG, `HandleLoadIntercept failed, cause context is undefined.`);
      return true;
    }
    ProcessUtil.startAbility(context as common.UIAbilityContext, want);
    return true;
  }

  public static checkUrl(url: string): boolean {
    const tempUri: uri.URI = new uri.URI(url);
    const res: uri.URI = tempUri.normalize();
    Logger.debug(TAG, `Web request url : ${res.toString()}`);
    const context = WebUtil.uiContext.getHostContext();
    if (!context) {
      Logger.error(TAG, `CheckUrl failed cause context is undefined.`);
      return false;
    }
    const whitelist: TrustUri[] = ResourceUtil.getRawFileStringByKey(context, ConfigMapKey.WHITELIST) as TrustUri[];

    const currentTrustUri = whitelist.find((item) => {
      const trustScheme: Boolean = item.scheme === res.scheme;
      if (!item.host) {
        return trustScheme;
      }
      const trustHost = (res.host || '').endsWith(item.host);
      if (!item.path) {
        return trustScheme && trustHost;
      }
      const trustPath = (res.path || '').startsWith(item.path);
      return trustScheme && trustHost && trustPath;
    });
    if (currentTrustUri) {
      return true;
    }
    return false;
  }


  public static createWebNode(webUrl: string, uiContext?: UIContext, nestedScrollMode?: NestedScrollMode,
    onlyWhiteMode?: boolean, verticalScrollBarAccess?: boolean) {
    if (webNodeMap.has(webUrl)) {
      nodeRequiredMap.set(webUrl, true);
      Logger.debug(TAG, `Has web node with url: ${webUrl}, should not create web node.`);
      return;
    }
    if (!WebUtil.uiContext && uiContext) {
      WebUtil.uiContext = uiContext;
    }
    Logger.debug(TAG, `initWebNode with url: ${webUrl}`);
    const webNode = new WebNodeController();
    const webController = new webview.WebviewController();
    const webBuilderParam: WebBuilderParam = {
      webUrl: webUrl,
      webController: webController,
      nestedScroll:
      {
        scrollForward: NestedScrollMode.SELF_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST,
      },
      onlyWhiteMode,
      verticalScrollBarAccess: verticalScrollBarAccess || false,
    };
    if (nestedScrollMode !== undefined) {
      webBuilderParam.nestedScroll = {
        scrollForward: nestedScrollMode,
        scrollBackward: nestedScrollMode,
      };
    }
    webNode.initWebNode(WebUtil.uiContext, webBuilderParam);
    webLoadedMap.set(webUrl, NetworkUtil.hasDefaultNet());
    webControllerMap.set(webUrl, webController);
    webNodeMap.set(webUrl, webNode);
  }

  public static getWebNode(webUrl: string): WebNodeController | undefined {
    return webNodeMap.get(webUrl);
  }

  public static getWebController(webUrl: string): webview.WebviewController | undefined {
    return webControllerMap.get(webUrl);
  }
}

export class WebNodeController extends NodeController {
  private rootNode: BuilderNode<WebBuilderParam[]> | null = null;
  private isRemove: boolean = false;

  makeNode(): FrameNode | null {
    if (this.isRemove) {
      return null;
    }
    return this.rootNode?.getFrameNode() ?? null;
  }

  disposeNode() {
    if (this.rootNode) {
      this.rootNode.dispose();
      this.rootNode = null;
    }
  }

  remove() {
    this.isRemove = true;
    this.rebuild();
    this.isRemove = false;
  }

  initWebNode(uiContext: UIContext, webBuilderParam: WebBuilderParam) {
    if (!this.rootNode) {
      this.rootNode = new BuilderNode(uiContext);
      this.rootNode.dispose();
      this.rootNode.build(wrapBuilder<WebBuilderParam[]>(webBuilder), webBuilderParam);
    }
  }

  updateWebNode(webBuilderParam: WebBuilderParam) {
    if (this.rootNode) {
      try {
        this.rootNode.update(webBuilderParam);
      } catch (error) {
        const err: BusinessError = error as BusinessError;
        Logger.error(TAG, `Failed to update web node, ${err.code}, ${err.message}`);
      }
    }
  }
}

interface TrustUri {
  scheme: string;
  host?: string;
  path?: string;
  port?: string;
}