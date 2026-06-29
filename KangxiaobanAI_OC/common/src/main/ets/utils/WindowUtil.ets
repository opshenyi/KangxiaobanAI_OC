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

import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import Logger from './Logger';
import { BreakpointModel } from '../model/BreakpointModel';
import { ImmersiveType, StorageKey } from '../constants/CommonEnums';
import { SizeToken } from '../designtoken/SizeToken';
import { WindowInfo } from '../model/WindowInfo';

const TAG = 'WindowUtil';

interface AvoidAreaChangeOption {
  type: window.AvoidAreaType;
  area: window.AvoidArea;
}

export class WindowUtil {
  private static winSingleton: WindowUtil;
  private windowStage?: window.WindowStage;
  private mainWindowClass?: window.Window;
  private uiContext?: UIContext;
  private breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  private constructor() {
  }

  static getInstance(): WindowUtil {
    if (!WindowUtil.winSingleton) {
      WindowUtil.winSingleton = new WindowUtil();
    }
    return WindowUtil.winSingleton;
  }

  setWindowStage(windowStage: window.WindowStage): void {
    this.windowStage = windowStage;
    this.windowStage.getMainWindow().then((windowClass) => {
      this.mainWindowClass = windowClass;
      try {
        this.uiContext = windowClass.getUIContext();
        AppStorage.setOrCreate<UIContext>(StorageKey.UI_CONTEXT, this.uiContext);
      } catch (error) {
        Logger.error(TAG, `Failed to obtain UIContext, error: ${JSON.stringify(error)}`);
      }
      this.registerBreakpoint(windowClass);
    }).catch((err: BusinessError) => {
      Logger.error(TAG, `Failed to obtain main window. Code:${err.code}, msg:${err.message}`);
    });
  }

  setMainWindowOrientation(orientation: window.Orientation, onSuccess?: Callback<void>): void {
    if (!this.mainWindowClass) {
      Logger.warn(TAG, 'MainWindow is not initialized yet.');
      return;
    }
    this.mainWindowClass.setPreferredOrientation(orientation)
      .then(() => {
        Logger.info(TAG, `Succeed in setting orientation.`);
        onSuccess?.();
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Failed to set orientation. Code: ${err.code}`,
          JSON.stringify(err) ?? '');
      });
  }

  getMainWindowOrientation(): window.Orientation | undefined {
    if (!this.mainWindowClass) {
      return undefined;
    }
    try {
      return this.mainWindowClass.getPreferredOrientation();
    } catch (error) {
      Logger.error(TAG, `Failed to obtain orientation, error: ${JSON.stringify(error)}`);
      return undefined;
    }
  }

  disableWindowSystemBar(): void {
    if (!this.mainWindowClass) {
      return;
    }
    this.mainWindowClass.setWindowSystemBarEnable([])
      .then(() => {
        Logger.info(TAG, `Succeed in disabling system bar.`);
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Disable system bar failed. Code: ${err.code}`,
          JSON.stringify(err) ?? '');
      });
  }

  enableWindowSystemBar(): void {
    if (!this.mainWindowClass) {
      return;
    }
    this.mainWindowClass.setWindowSystemBarEnable(['status', 'navigation'])
      .then(() => {
        Logger.info(TAG, `Succeed in enabling system bar.`);
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Enable system bar failed. Code: ${err.code}`,
          JSON.stringify(err) ?? '');
      });
  }

  setFullScreen(isLayoutFullScreen: boolean = true): void {
    if (!this.mainWindowClass) {
      return;
    }
    this.mainWindowClass.setWindowLayoutFullScreen(isLayoutFullScreen)
      .then(() => {
        Logger.info(TAG, `Succeed in setting full screen.`);
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Set full screen failed. Code: ${err.code}`,
          JSON.stringify(err) ?? '');
      });
  }

  maximize(): void {
    if (canIUse('SystemCapability.Window.SessionManager') && this.mainWindowClass) {
      try {
        if (this.mainWindowClass.getWindowStatus() === window.WindowStatusType.FLOATING) {
          this.mainWindowClass.maximize()
            .then(() => {
              Logger.info(TAG, `Succeed in maximizing window.`);
            })
            .catch((err: BusinessError) => {
              Logger.error(TAG, `Maximize failed. Code: ${err.code}`,
                JSON.stringify(err) ?? '');
            });
        }
      } catch (error) {
        Logger.error(TAG, `getWindowStatus failed, error info: ${JSON.stringify(error)}`);
      }
    }
  }

  minimize(): void {
    if (canIUse('SystemCapability.Window.SessionManager') && this.mainWindowClass) {
      try {
        if (this.mainWindowClass.getWindowStatus() === window.WindowStatusType.FLOATING) {
          this.mainWindowClass.minimize()
            .then(() => {
              Logger.info(TAG, `Succeed in minimizing window.`);
            })
            .catch((err: BusinessError) => {
              Logger.error(TAG, `Minimize failed. Code: ${err.code}`,
                JSON.stringify(err) ?? '');
            });
        }
      } catch (error) {
        Logger.error(TAG, `getWindowStatus failed, error info: ${JSON.stringify(error)}`);
      }
    }
  }

  recover(): void {
    if (canIUse('SystemCapability.Window.SessionManager') && this.mainWindowClass) {
      try {
        if (this.mainWindowClass.getWindowStatus() === window.WindowStatusType.FULL_SCREEN) {
          this.mainWindowClass.recover()
            .then(() => {
              Logger.info(TAG, `Succeed in recovering window.`);
            })
            .catch((err: BusinessError) => {
              Logger.error(TAG, `Recover failed. Code: ${err.code}`,
                JSON.stringify(err) ?? '');
            });
        }
      } catch (error) {
        Logger.error(TAG, `getWindowStatus failed, error info: ${JSON.stringify(error)}`);
      }
    }
  }

  getMainWindow(): window.Window | undefined {
    return this.mainWindowClass;
  }

  updateWindowWidth(width: number) {
    this.breakpointModel.windowInfo.windowSize.width = width;
  }

  updateWindowHeight(height: number) {
    this.breakpointModel.windowInfo.windowSize.height = height;
  }

  registerBreakpoint(windowClass: window.Window) {
    this.updateBreakpoint();
    windowClass.on('windowSizeChange', this.onWindowSizeChange);
    windowClass.on('avoidAreaChange', this.onAvoidAreaChange);
  }

  private onAvoidAreaChange = (avoidAreaOption: AvoidAreaChangeOption): void => {
    if (avoidAreaOption.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
      const nav = avoidAreaOption.area?.bottomRect;
      if (nav && nav.height > 0) {
        this.breakpointModel.windowInfo.navigationBarBottomVp = this.uiContext ? this.uiContext.px2vp(nav.height) : 0;
      } else {
        this.breakpointModel.windowInfo.navigationBarBottomVp = 0;
      }
    }
    if (avoidAreaOption.type === window.AvoidAreaType.TYPE_SYSTEM) {
      this.breakpointModel.windowInfo.statusBarHeight = avoidAreaOption.area?.topRect.height ?? 0;
    }
  };

  updateBreakpoint() {
    try {
      const properties = this.mainWindowClass?.getWindowProperties();
      if (properties) {
        this.breakpointModel.windowInfo.windowSize.width = properties.windowRect.width;
        this.breakpointModel.windowInfo.windowSize.height = properties.windowRect.height;
      }
    } catch (err) {
      Logger.error(TAG, `Failed to get window properties, error: ${JSON.stringify(err)}`);
    }
    // Get the system default area, usually including the status bar and navigation bar
    try {
      const systemAvoidArea = this.mainWindowClass?.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const navigationIndicatorAvoidArea =
        this.mainWindowClass?.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      this.breakpointModel.windowInfo.statusBarHeight = systemAvoidArea?.topRect.height ?? 0;
      this.breakpointModel.windowInfo.navAvoidAreaHeight = navigationIndicatorAvoidArea?.bottomRect.height ?? 0;
      // Calculate navigationBarBottomVp
      if (this.uiContext) {
        const nav = navigationIndicatorAvoidArea?.bottomRect;
        if (nav && nav.height > 0) {
          this.breakpointModel.windowInfo.navigationBarBottomVp = this.uiContext.px2vp(nav.height);
        } else {
          this.breakpointModel.windowInfo.navigationBarBottomVp = 0;
        }
      }
    } catch (error) {
      Logger.error(TAG, `Failed to get the avoid area, error: ${JSON.stringify(error)}`);
    }
    if (this.uiContext) {
      this.breakpointModel.currentWidthBreakpoint = this.uiContext.getWindowWidthBreakpoint();
      this.breakpointModel.currentHeightBreakpoint = this.uiContext.getWindowHeightBreakpoint();
    }

    if (canIUse('SystemCapability.Window.SessionManager')) {
      try {
        const decorHeight: number = WindowUtil.winSingleton.mainWindowClass?.getWindowDecorHeight() ?? 0;
        this.breakpointModel.windowInfo.decorHeight = decorHeight;
      } catch (error) {
        Logger.error(TAG, `getWindowDecorHeight failed. error message: ${error.message}`);
      }
    }
  }

  unregisterBreakpoint() {
    this.mainWindowClass?.off('windowSizeChange', this.onWindowSizeChange);
    this.mainWindowClass?.off('avoidAreaChange', this.onAvoidAreaChange);
  }

  setImmersiveType(type: ImmersiveType) {
    try {
      if (!this.mainWindowClass) {
        return;
      }
      if (type === ImmersiveType.NORMAL) {
        this.mainWindowClass.setWindowDecorVisible(true);
      } else if (type === ImmersiveType.IMMERSIVE) {
        this.mainWindowClass.setWindowDecorVisible(false);
        this.mainWindowClass.setWindowDecorHeight(SizeToken.SIZE_NUM_56);
        this.mainWindowClass.setDecorButtonStyle({ buttonIconSize: SizeToken.SIZE_NUM_24 });
        this.recover();
      }
      this.breakpointModel.windowInfo.isImmersive = type;
    } catch (error) {
      Logger.error(TAG, `Failed to set immersive type, error: ${JSON.stringify(error)}`);
    }
  }

  unregisterWindowStatusListener(): void {
    try {
      this.mainWindowClass?.off('windowStatusChange', this.onStatusTypeChange);
    } catch (error) {
      Logger.error(TAG, `Failed to unregister windowStatusChange, error: ${JSON.stringify(error)}`);
    }
  }

  registerWindowStatusListener(): void {
    try {
      this.mainWindowClass?.on('windowStatusChange', this.onStatusTypeChange);
    } catch (error) {
      Logger.error(TAG, `Failed to register windowStatusChange, error: ${JSON.stringify(error)}`);
    }
  }

  private onWindowSizeChange: (windowSize: window.Size) => void = (_windowSize: window.Size): void => {
    this.updateBreakpoint();
  };
  private onStatusTypeChange: (statusType: window.WindowStatusType) => void = (statusType: window.WindowStatusType) => {
    this.breakpointModel.windowInfo.windowStatusType = statusType;
    const isImmersive =
      statusType === window.WindowStatusType.MAXIMIZE || statusType === window.WindowStatusType.FLOATING;
    this.setImmersiveType(isImmersive ? ImmersiveType.IMMERSIVE : ImmersiveType.NORMAL);
  };
}