/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { StartOptions, AbilityConstant, Want, common } from '@kit.AbilityKit';
import { resourceManager } from '@kit.LocalizationKit';
import { sensor } from '@kit.SensorServiceKit';
import { AppStorageV2, display, UIContext, window } from '@kit.ArkUI';
import Logger from './Logger';

const TAG = 'WindowUtil';

export enum ImmersiveType {
  NORMAL,
  IMMERSIVE,
  FULLSCREEN_IMMERSIVE
}

export class WindowUtil {
  private static instance: WindowUtil | undefined = undefined;
  public uiContext?: UIContext;
  public mainWindow?: window.Window;
  public mainWindowInfo: WindowInfo = new WindowInfo();
  private windowInfo: WindowInfo = AppStorageV2.connect<WindowInfo>(WindowInfo, () => new WindowInfo())!;
  public onStatusTypeChange: (statusType: window.WindowStatusType) => void = (statusType: window.WindowStatusType) => {
    this.mainWindowInfo.windowStatusType = statusType;
  }
  public onWindowSizeChange: (windowSize: window.Size) => void = (windowSize: window.Size) => {
    this.mainWindowInfo.windowSize = windowSize;
    this.mainWindowInfo.widthBp = this.uiContext!.getWindowWidthBreakpoint();
    this.mainWindowInfo.heightBp = this.uiContext!.getWindowHeightBreakpoint();
  };
  public onAvoidAreaChange: (avoidOptions: window.AvoidAreaOptions) => void =
    (avoidOptions: window.AvoidAreaOptions) => {
      if (avoidOptions.type === window.AvoidAreaType.TYPE_SYSTEM) {
        this.mainWindowInfo.avoidSystem = avoidOptions.area;
        this.windowInfo.statusBarHeight = avoidOptions.area.topRect.height;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_CUTOUT) {
        this.mainWindowInfo.avoidCutout = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_SYSTEM_GESTURE) {
        this.mainWindowInfo.avoidSystemGesture = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_KEYBOARD) {
        this.mainWindowInfo.avoidKeyboard = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
        this.mainWindowInfo.avoidNavigationIndicator = avoidOptions.area;
        this.windowInfo.navigationBarHeight = avoidOptions.area.bottomRect.height;
      }
    };

  private constructor() {
  }

  public static getInstance(): WindowUtil {
    if (!WindowUtil.instance) {
      WindowUtil.instance = new WindowUtil();
    }
    return WindowUtil.instance;
  }

  public setMainWindow(mainWindow: window.Window) {
    this.mainWindow = mainWindow;
  }

  setImmersiveType(type: ImmersiveType) {
    try {
      if (type === ImmersiveType.NORMAL) {
        this.mainWindow?.setWindowLayoutFullScreen(false)
          .then(() => {
            Logger.info('testLog', `Succeeded in setting immersive mode.`);
          })
          .catch((err: BusinessError) => {
            Logger.error('testLog', `Failed to set immersive mode. Code: ${err.code}, message: ${err.message}`);
          });
        this.setSystemBarEnabled(true);
        // Only used after the function loadContent() or setUIContent().
        this.mainWindow?.setWindowDecorVisible(true);
        this.recover();
      } else if (type === ImmersiveType.IMMERSIVE) {
        this.mainWindow?.setWindowLayoutFullScreen(true)
          .then(() => {
            Logger.info('testLog', `Succeeded in setting immersive mode.`);
          })
          .catch((err: BusinessError) => {
            Logger.error('testLog', `Failed to set immersive mode. Code: ${err.code}, message: ${err.message}`);
          });
        this.setSystemBarEnabled(true);
        this.mainWindow?.setWindowDecorVisible(false);
        this.recover();
      } else if (type === ImmersiveType.FULLSCREEN_IMMERSIVE) {
        this.mainWindow?.setWindowLayoutFullScreen(true)
          .then(() => {
            Logger.info('testLog', `Succeeded in setting immersive mode.`);
          })
          .catch((err: BusinessError) => {
            Logger.error('testLog', `Failed to set immersive mode. Code: ${err.code}, message: ${err.message}`);
          });
        if (this.mainWindow?.getWindowStatus() === window.WindowStatusType.MAXIMIZE ||
          (this.mainWindow?.getWindowStatus() === window.WindowStatusType.FLOATING &&
            this.mainWindow?.getWindowDecorHeight() !== 0)) {
          this.mainWindow.maximize()
            .then(() => {
              Logger.info('testLog', `Succeeded in maximizing the window.`);
            })
            .catch((err: BusinessError) => {
              Logger.error('testLog',
                `Failed to maximize the window. Code: ${err.code}, message: ${err.message}`);
            });
        }
        this.setSystemBarEnabled(false);
        this.mainWindow?.setWindowDecorVisible(false);
      }
      this.mainWindowInfo.isImmersive = type;
    } catch (error) {
      let err = error as BusinessError;
      Logger.error('TestLog', `Failed to set immersive type. Code: ${err.code}, message: ${err.message}`);
    }
  }

  setUIContext() {
    try {
      this.uiContext = this.mainWindow?.getUIContext();
    } catch (error) {
      let err = error as BusinessError;
      Logger.error('TestLog', `Failed to set UI context. Code: ${err.code}, message: ${err.message}`);
    }
  }

  setSystemBarEnabled(isVisible: boolean): void {
    this.mainWindow?.setSpecificSystemBarEnabled('status', isVisible)
      .then(() => {
        Logger.info(TAG, `Succeeded in setting status bar to be invisible.`);
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG,
          `Failed to set status bar to be invisible. Code: ${err.code}, message: ${err.message}`);
      });
    this.mainWindow?.setSpecificSystemBarEnabled('navigationIndicator', isVisible)
      .then(() => {
        Logger.info(TAG, `Succeeded in setting navigation indicator to be invisible.`);
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG,
          `Failed to set navigation indicator to be invisible. Code: ${err.code}, message: ${err.message}`);
      });
  }

  recover(): void {
    try {
      if (this.mainWindow?.getWindowStatus() === window.WindowStatusType.FULL_SCREEN) {
        this.mainWindow?.recover()
          .then(() => {
            Logger.info('testLog', `Succeeded in revocering the window.`);
          })
          .catch((err: BusinessError) => {
            Logger.error('testLog', `Failed to revocer the window. Code: ${err.code}, message: ${err.message}`);
          });
      }
    } catch (error) {
      let err = error as BusinessError;
      Logger.error('TestLog', `Failed to recover. Code: ${err.code}, message: ${err.message}`);
    }
  }

  setWindowOrientation(orientation: window.Orientation): void {
    this.mainWindow?.setPreferredOrientation(orientation)
      .then(() => {
        Logger.info('testLog', `Succeeded in setting window orientation.`);
        // Update window orientation.
        this.mainWindowInfo.orientation = orientation;
      })
      .catch((err: BusinessError) => {
        Logger.error('testLog', `Failed to set window orientation. Code: ${err.code}, message: ${err.message}`);
      });
  }

  updateWindowInfo(): void {
    try {
      // First time get window status.
      this.mainWindowInfo.windowStatusType = this.mainWindow?.getWindowStatus() as window.WindowStatusType;
      this.mainWindow?.on('windowStatusChange', this.onStatusTypeChange);
      // First time get window size.
      let width: number = this.mainWindow?.getWindowProperties().windowRect.width as number;
      let height: number = this.mainWindow?.getWindowProperties().windowRect.height as number;
      let windowSize: window.Size = {
        width: width,
        height: height
      }
      this.mainWindowInfo.windowSize = windowSize;
      // First time get width/height breakpoint.
      this.mainWindowInfo.widthBp = this.uiContext!.getWindowWidthBreakpoint();
      this.mainWindowInfo.heightBp = this.uiContext!.getWindowHeightBreakpoint();
      // Register for window size change monitoring, update window size and width/height breakpoint.
      this.mainWindow?.on('windowSizeChange', this.onWindowSizeChange);

      // First time get avoid area infos.
      this.mainWindowInfo.avoidSystem = this.mainWindow?.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.windowInfo.statusBarHeight = this.mainWindowInfo.avoidSystem?.topRect.height as number;
      this.mainWindowInfo.avoidNavigationIndicator =
        this.mainWindow?.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      this.windowInfo.navigationBarHeight = this.mainWindowInfo.avoidNavigationIndicator?.bottomRect.height as number;
      this.mainWindowInfo.avoidCutout = this.mainWindow?.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
      this.mainWindowInfo.avoidSystemGesture =
        this.mainWindow?.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM_GESTURE);
      this.mainWindowInfo.avoidKeyboard = this.mainWindow?.getWindowAvoidArea(window.AvoidAreaType.TYPE_KEYBOARD);
      this.mainWindow?.on('avoidAreaChange', this.onAvoidAreaChange);
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(`TestLog`, `Failed to update window info. Code: ${err.code}, message: ${err.message}`);
    }
  }

  release(): void {
    try {
      this.mainWindow?.off('windowStatusChange');
      this.mainWindow?.off('windowSizeChange');
      this.mainWindow?.off('avoidAreaChange');
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `Failed to off. Code: ${err.code}, message: ${err.message}`);
    }

  }

  setSplitScreen(bundleName: string, abilityName: string, moduleName: string): void {
    let context = this.uiContext?.getHostContext() as common.UIAbilityContext;
    // Create StartOptions and set them to the main window mode.
    let option: StartOptions = { windowMode: AbilityConstant.WindowMode.WINDOW_MODE_SPLIT_PRIMARY };
    let want: Want = { bundleName: bundleName, abilityName: abilityName, moduleName: moduleName };
    context.startAbility(want, option).catch((err: BusinessError) => {
      Logger.error('TestLog', `Failed to start ability. Code: ${err.code}, message: ${err.message}`);
    });
  }

  cancelSplitScreen(): void {
    let context = this.uiContext?.getHostContext() as common.UIAbilityContext;
    context.terminateSelf().catch((err: BusinessError) => {
      Logger.error('TestLog', `Failed to terminate self. Code: ${err.code}, message: ${err.message}`);
    });
  }

  setWindowLimits(maxWidth: number, maxHeight: number, minWidth: number, minHeight: number): void {
    let windowLimits: window.WindowLimits = {
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      minWidth: minWidth,
      minHeight: minHeight
    }
    this.mainWindow?.setWindowLimits(windowLimits).then((data: window.WindowLimits) => {
      Logger.info('testLog', `Succeeded in changing the window limits. Cause: ${JSON.stringify(data)}`);
    }).catch((err: BusinessError) => {
      Logger.error('testLog',
        `Failed to change the window limits. Cause code: ${err.code}, message: ${err.message}`);
    });
  }

  resize(width: number, height: number): void {
    this.mainWindow?.resize(width, height, (err: BusinessError) => {
      const errCode: number = err.code;
      if (errCode) {
        Logger.error('testLog',
          `Failed to change the window size. Cause code: ${err.code}, message: ${err.message}`);
        return;
      }
      Logger.info('testLog', 'Succeeded in changing the window size.');
    });
  }

  queryOrientationByDisplay(): void {
    try {
      let displayClass: display.Display | null = display.getDefaultDisplaySync();
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `Failed to query display orientation. Code: ${err.code}, message: ${err.message}`);
    }
  }

  queryOrientationByResourceManager(): void {
    let info: resourceManager.Direction | undefined =
      this.uiContext?.getHostContext()?.resourceManager.getConfigurationSync().direction;
    Logger.info(TAG, `The Orientation is ${info}`);
  }

  queryDegree(): void {
    try {
      sensor.on(sensor.SensorId.GRAVITY, (data: sensor.GravityResponse) => {
        let degree: number = this.getCalDegree(data.x, data.y, data.z);
      })
    } catch (error) {
      let err = error as BusinessError;
      Logger.error('TestLog', `Failed to query degree. Code: ${err.code}, message: ${err.message}`);
    }
  }

  getCalDegree(x: number, y: number, z: number): number {
    let degree: number = 0;
    // three is Effective Delta Angle Threshold Coefficient.
    if ((x * x + y * y) * 3 < z * z) {
      return degree;
    }
    degree = 90 - (Number)(Math.round(Math.atan2(y, -x) / Math.PI * 180));
    return degree >= 0 ? degree % 360 : degree % 360 + 360;
  }

  setPCImmersive(decorHeight: number, iconSize: number) {
    try {
      this.mainWindow?.setWindowLayoutFullScreen(true).catch(() => {
        Logger.info(TAG, 'Set window full screen failed.');
      });
      this.mainWindow?.setSpecificSystemBarEnabled('status', true).catch(() => {
        Logger.info(TAG, 'Set specific status bar failed.');
      });
      this.mainWindow?.setSpecificSystemBarEnabled('navigationIndicator', true).catch(() => {
        Logger.info(TAG, 'Set specific navigation bar failed.');
      });
      this.mainWindow?.setWindowDecorVisible(false);
      this.mainWindow?.setWindowDecorHeight(decorHeight);
      this.mainWindow?.setDecorButtonStyle({ buttonIconSize: iconSize })
    } catch (error) {
      Logger.info(TAG, 'Get window failed.');
    }
  }

  setWindowSizeChangeListener(callback: Callback<Size>) {
    this.mainWindow?.on('windowSizeChange', callback);
  }

  offWindowSizeChangeListener() {
    this.mainWindow?.off('windowSizeChange');
  }
}

@ObservedV2
export class WindowInfo {
  // Window status.
  public windowStatusType: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
  // Is the window an immersive layout.
  public isImmersive: ImmersiveType = ImmersiveType.NORMAL;
  // Window orientation.
  public orientation: window.Orientation = window.Orientation.UNSPECIFIED;
  // Window size.
  public windowSize: window.Size = { width: 0, height: 0 };
  // Width/height breakpoint.
  public widthBp: WidthBreakpoint = WidthBreakpoint.WIDTH_XS;
  public heightBp: HeightBreakpoint = HeightBreakpoint.HEIGHT_SM;
  // Avoid area infos.
  public avoidSystem?: window.AvoidArea;
  public avoidNavigationIndicator?: window.AvoidArea;
  public avoidCutout?: window.AvoidArea;
  public avoidSystemGesture?: window.AvoidArea;
  public avoidKeyboard?: window.AvoidArea;
  @Trace public statusBarHeight: number = 0;
  @Trace public navigationBarHeight: number = 0;
}
