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

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { getAppRuntime, Logger, WindowUtil } from 'musicbasic';
import { MediaService } from 'player';

/** Main UIAbility for the default phone product: wires app runtime, window util, and media singleton. */
export default class EntryAbility extends UIAbility {
  /** Persists UIAbility context on app runtime for global access. */
  onCreate() {
    getAppRuntime().context = this.context;
    Logger.info('EntryAbility: Ability onCreate');
  }

  /** Ability lifecycle teardown hook. */
  onDestroy() {
    Logger.info('EntryAbility: Ability onDestroy');
  }

  /** Loads main page, captures UIContext, initializes window helper and MediaService singleton. */
  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    Logger.info('EntryAbility: Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      try {
        getAppRuntime().uiContext = windowStage.getMainWindowSync().getUIContext();
      } catch (error) {
        Logger.error(`getMainWindowSync error ${JSON.stringify(error)}`);
      }
      if (err.code) {
        Logger.error(`Failed to load the content. Cause: ${JSON.stringify(err) ?? ''}`);
        return;
      }
      Logger.info('Succeeded in loading the content.');
      MediaService.getInstance();
      try {
        const windowUtil = WindowUtil.getInstance();
        windowUtil.setWindowStage(windowStage);
        windowUtil.setUIContext();
        windowUtil.updateWindowInfo();
      } catch (err) {
        let error = err as BusinessError;
        Logger.error(`WindowUtil init error ${error.code} ${error.message}`);
      }
    });
  }

  /** Called when the main window stage is destroyed. */
  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    Logger.info('EntryAbility: Ability onWindowStageDestroy');
  }

  /** App brought to foreground. */
  onForeground() {
    // Ability has brought to foreground
    Logger.info('EntryAbility: Ability onForeground');
  }

  /** App moved to background; notifies media layer for background-task policy. */
  onBackground() {
    // Ability has back to background
    Logger.info('EntryAbility: Ability onBackground');
    MediaService.getInstance().onApplicationBackground();
  }
  /** Reserved for warm-start / new Want delivery (no-op for this sample). */
  onNewWant(): void {

  }
}
