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

import { AppStorageV2, UIContext, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from './Logger';

const TAG = 'WindowUtil';

/**
 * Key for window observable info in AppStorageV2, used with getWindowInfoState()
 */
export const WINDOW_INFO_STORAGE_KEY = 'MultiSetting_WindowInfo';

/** Window info (State V2), process-level singleton, registered in AppStorageV2 */
export function getWindowInfoState(): WindowInfo {
  return AppStorageV2.connect(WindowInfo, WINDOW_INFO_STORAGE_KEY, () => new WindowInfo()) ?? new WindowInfo();
}

/**
 * Window utility class.
 */
export class WindowUtil {
  private static instance: WindowUtil | undefined = undefined;

  static getInstance(): WindowUtil {
    if (WindowUtil.instance === undefined) {
      WindowUtil.instance = new WindowUtil();
    }
    return WindowUtil.instance;
  }

  private constructor() {
  }

  private windowStage?: window.WindowStage;
  private uiContext?: UIContext;
  private mainWindow?: window.Window;
  private mainWindowInfo: WindowInfo = getWindowInfoState();

  /**
   * Sync status bar top height and bottom navigation bar height with uiContext based on
   * current AvoidSystem / AvoidNavigationIndicator.
   * */
  private syncWindowInsetsVp(): void {
    const ctx = this.uiContext;
    const info = this.mainWindowInfo;
    if (ctx === undefined) {
      info.statusBarTopVp = 0;
      info.navigationBarBottomVp = 0;
      return;
    }
    const sys = info.avoidSystem;
    if (sys !== undefined) {
      info.statusBarTopVp = ctx.px2vp(sys.topRect.height);
    } else {
      info.statusBarTopVp = 0;
    }
    const nav = info.avoidNavigationIndicator;
    if (nav !== undefined) {
      info.navigationBarBottomVp = ctx.px2vp(nav.bottomRect.height);
    } else {
      info.navigationBarBottomVp = 0;
    }
  }

  // Monitor the change in window status type of the main window.
  public onStatusTypeChange: (statusType: window.WindowStatusType) => void = (statusType: window.WindowStatusType) => {
    this.mainWindowInfo.windowStatusType = statusType;
  };
  // Monitor the breakpoints and size changes of the main window.
  public onWindowSizeChange: (windowSize: window.Size) => void = (windowSize: window.Size) => {
    this.mainWindowInfo.windowSize = windowSize;
    if (this.uiContext === undefined) {
      Logger.error(TAG, 'onWindowSizeChange: uiContext is undefined');
      return;
    }
    try {
      this.mainWindowInfo.widthBp = this.uiContext.getWindowWidthBreakpoint();
      this.mainWindowInfo.heightBp = this.uiContext.getWindowHeightBreakpoint();
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `getWindowBreakpoint failed. Code: ${err.code}, message: ${err.message}`);
    }
  };
  // Monitor the change of avoidance zone in the main window.
  public onAvoidAreaChange: (avoidOptions: window.AvoidAreaOptions) => void =
    (avoidOptions: window.AvoidAreaOptions) => {
      if (avoidOptions.type === window.AvoidAreaType.TYPE_SYSTEM) {
        this.mainWindowInfo.avoidSystem = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_CUTOUT) {
        this.mainWindowInfo.avoidCutout = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_SYSTEM_GESTURE) {
        this.mainWindowInfo.avoidSystemGesture = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_KEYBOARD) {
        this.mainWindowInfo.avoidKeyboard = avoidOptions.area;
      } else if (avoidOptions.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
        this.mainWindowInfo.avoidNavigationIndicator = avoidOptions.area;
      }
      this.syncWindowInsetsVp();
    };

  setWindowStage(windowStage: window.WindowStage): void {
    this.windowStage = windowStage;
    try {
      this.mainWindow = this.windowStage.getMainWindowSync();
      this.setUIContext();
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `getMainWindowSync failed. Code: ${err.code}, message: ${err.message}`);
    }
  }

  setUIContext(): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'setUIContext: mainWindow is undefined');
      return;
    }
    try {
      this.uiContext = this.mainWindow.getUIContext();
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `getUIContext failed. Code: ${err.code}, message: ${err.message}`);
    }
  }

  /**
   * Use the window interface to set up window immersion.
   */
  setFullScreen(isFullScreen: boolean): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'setFullScreen: mainWindow is undefined');
      return;
    }
    this.mainWindow.setWindowLayoutFullScreen(isFullScreen)
      .then(() => {
        Logger.info(TAG, 'Succeeded in setting full-screen mode.');
        this.mainWindowInfo.isFullScreen = isFullScreen;
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Failed to set full-screen mode. Code: ${err.code}, message: ${err.message}`);
      });
  }

  /**
   * Set system bar styles (status bar / navigation bar) for current mainWindow, consistent with official window API.
   * Business pages should call this method to avoid repeated getLastWindow calls.
   */
  setWindowSystemBarProperties(props: window.SystemBarProperties): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'setWindowSystemBarProperties: mainWindow is undefined');
      return;
    }
    try {
      this.mainWindow.setWindowSystemBarProperties(props).catch((err: BusinessError) => {
        Logger.error(TAG, `setWindowSystemBarProperties failed. Code: ${err.code}, message: ${err.message}`);
      });
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `setWindowSystemBarProperties sync error. Code: ${err.code}, message: ${err.message}`);
    }
  }

  setImmersive() {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'setWindowDecorVisible: mainWindow is undefined');
      return;
    }
    try {
      if (canIUse('SystemCapability.Window.SessionManager')) {
        this.mainWindow.setWindowDecorVisible(false);
        this.mainWindow.setWindowDecorHeight(64);
        this.mainWindow.setDecorButtonStyle({
          buttonIconSize: 22,
          spacingBetweenButtons: 16,
          buttonBackgroundSize: 40
        });
      }
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `setWindowDecorVisible sync error. Code: ${err.code}, message: ${err.message}`);
    }
  }

  // Use the window interface to set window orientation.
  setWindowOrientation(orientation: window.Orientation): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'setWindowOrientation: mainWindow is undefined');
      return;
    }
    this.mainWindow.setPreferredOrientation(orientation)
      .then(() => {
        Logger.info(TAG, 'Succeeded in setting window orientation.');
        this.mainWindowInfo.orientation = orientation;
      })
      .catch((err: BusinessError) => {
        Logger.error(TAG, `Failed to set window orientation. Code: ${err.code}, message: ${err.message}`);
      });
  }

  updateWindowInfo(): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'updateWindowInfo: mainWindow is undefined');
      return;
    }
    if (this.uiContext === undefined) {
      Logger.error(TAG, 'updateWindowInfo: uiContext is undefined');
      return;
    }
    try {
      if (canIUse('SystemCapability.Window.SessionManager')) {
        // First time get window status.
        this.mainWindowInfo.windowStatusType = this.mainWindow.getWindowStatus();
        this.mainWindow.on('windowStatusChange', this.onStatusTypeChange);

        // First time get window size.
        let width: number = this.mainWindow.getWindowProperties().windowRect.width;
        let height: number = this.mainWindow.getWindowProperties().windowRect.height;
        let windowSize: window.Size = {
          width: width,
          height: height
        };
        this.mainWindowInfo.windowSize = windowSize;
        // First time get width/height breakpoint.
        this.mainWindowInfo.widthBp = this.uiContext.getWindowWidthBreakpoint();
        this.mainWindowInfo.heightBp = this.uiContext.getWindowHeightBreakpoint();
        // Register for window size change monitoring, update window size and width/height breakpoint.
        this.mainWindow.on('windowSizeChange', this.onWindowSizeChange);

        // First time get avoid area infos.
        this.mainWindowInfo.avoidSystem = this.mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
        this.mainWindowInfo.avoidNavigationIndicator =
          this.mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
        this.mainWindowInfo.avoidCutout = this.mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
        this.mainWindowInfo.avoidSystemGesture =
          this.mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM_GESTURE);
        this.mainWindowInfo.avoidKeyboard = this.mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_KEYBOARD);
        this.mainWindow.on('avoidAreaChange', this.onAvoidAreaChange);
        this.syncWindowInsetsVp();
      }
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `updateWindowInfo failed. Code: ${err.code}, message: ${err.message}`);
    }
  }

  release(): void {
    if (this.mainWindow === undefined) {
      Logger.error(TAG, 'release: mainWindow is undefined');
      return;
    }
    try {
      if (canIUse('SystemCapability.Window.SessionManager')) {
        this.mainWindow.off('windowStatusChange');
        this.mainWindow.off('windowSizeChange');
        this.mainWindow.off('avoidAreaChange');
      }
    } catch (error) {
      let err = error as BusinessError;
      Logger.error(TAG, `WindowUtil release failed. Code: ${err.code}, message: ${err.message}`);
    }
  }
}

/**
 * Window info class.
 */
@ObservedV2
export class WindowInfo {
  // Window status.
  @Trace public windowStatusType: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
  // Is the window an immersive layout.
  @Trace public isFullScreen: boolean = false;
  // Window orientation.
  @Trace public orientation: window.Orientation = window.Orientation.UNSPECIFIED;
  // Window size.
  @Trace public windowSize: window.Size = { width: 0, height: 0 };
  // Width/height breakpoint.
  @Trace public widthBp: WidthBreakpoint = WidthBreakpoint.WIDTH_XS;
  @Trace public heightBp: HeightBreakpoint = HeightBreakpoint.HEIGHT_SM;
  // Avoid area info for top status bar.
  @Trace public avoidSystem?: window.AvoidArea;
  // Avoid area info for bottom navigation bar.
  @Trace public avoidNavigationIndicator?: window.AvoidArea;
  // Avoid area info for cutout zone.
  @Trace public avoidCutout?: window.AvoidArea;
  // Avoid area info for edge back gesture zone.
  @Trace public avoidSystemGesture?: window.AvoidArea;
  // Avoid area info for keyboard zone.
  @Trace public avoidKeyboard?: window.AvoidArea;
  // Status bar top occupied height: calculated from AvoidSystem.topRect
  @Trace public statusBarTopVp: number = 0;
  // Bottom navigation indicator occupied height: calculated from AvoidNavigationIndicator.bottomRect
  @Trace public navigationBarBottomVp: number = 0;
}