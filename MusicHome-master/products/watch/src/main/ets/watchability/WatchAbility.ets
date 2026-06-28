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
import { getAppRuntime, Logger } from 'musicbasic';
import { MediaService } from 'player';

/**
 * Watch UIAbility: wires app runtime context, loads Index page, and initializes media on window stage.
 */
export default class WatchAbility extends UIAbility {
  /**
   * Stores ability context on app runtime and logs creation.
   * @param want Launch want info.
   * @param launchParam System launch parameters.
   */
  onCreate(): void {
    getAppRuntime().context = this.context;
    Logger.info('WatchAbility: Ability onCreate');
  }

  /** Logs ability destruction. */
  onDestroy(): void {
    Logger.info('WatchAbility: Ability onDestroy');
  }

  /**
   * Loads main watch UI, captures UIContext on main window, and creates MediaService.
   * @param windowStage Window stage for this ability.
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    Logger.info('WatchAbility: Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        Logger.error(`${err.code} + ${err.message}`);
        return;
      }
      getAppRuntime().uiContext = windowStage.getMainWindowSync().getUIContext();
      Logger.info('Succeeded in loading the content.');
      MediaService.getInstance();
    });
  }

  /** Logs when the window stage is torn down. */
  onWindowStageDestroy(): void {
    Logger.info('WatchAbility: Ability onWindowStageDestroy');
  }

  /** Logs transition to foreground. */
  onForeground(): void {
    Logger.info('WatchAbility: Ability onForeground');
  }

  /** Logs transition to background. */
  onBackground(): void {
    Logger.info('WatchAbility: Ability onBackground');
  }
}
