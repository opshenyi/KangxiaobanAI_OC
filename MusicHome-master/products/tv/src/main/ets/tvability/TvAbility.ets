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
 * TV UIAbility: sets app runtime context, loads TV Index, and initializes MediaService after content load.
 */
export default class TvAbility extends UIAbility {
  /**
   * Persists ability context and logs creation.
   * @param want Launch want.
   * @param launchParam Launch parameters.
   */
  onCreate(): void {
    getAppRuntime().context = this.context;
    Logger.info('TvAbility: Ability onCreate');
  }

  /** Logs ability destruction. */
  onDestroy(): void {
    Logger.info('TvAbility: Ability onDestroy');
  }

  /**
   * Loads pages/Index and constructs MediaService when load succeeds.
   * @param windowStage Window stage for this ability.
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    Logger.info('TvAbility: Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        Logger.error(`Failed to load the content. Cause: ${JSON.stringify(err)}`);
        return;
      }
      Logger.info('Succeeded in loading the content.');
      MediaService.getInstance();
    });
  }

  /** Logs window stage destroy. */
  onWindowStageDestroy(): void {
    Logger.info('TvAbility: Ability onWindowStageDestroy');
  }

  /** Logs foreground transition. */
  onForeground(): void {
    Logger.info('TvAbility: Ability onForeground');
  }

  /** Logs background transition. */
  onBackground(): void {
    Logger.info('TvAbility: Ability onBackground');
  }
}
