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

import {
  DividerShowType,
  hdsMaterial,
  HdsNavDestination,
  HdsNavigationTitleBarOptions,
  ScrollEffectType
} from '@kit.UIDesignKit';
import { common } from '@kit.AbilityKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { CommonConstants, PageTitleModifier } from 'commonmultidevicecommunication';
import { SocialListView } from 'social';

@ComponentV2
export struct SocialCommonView {
  @Require @Param activeIndex: number;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Local moduleName: string = '';
  private hdsTitleBar: HdsNavigationTitleBarOptions = {}
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;

  @Monitor('activeIndex')
  onActiveIndex(mon: IMonitor) {
    const value: IMonitorValue<number> | undefined = mon.value();
    if (!value) {
      return;
    }
    if (value.now === CommonConstants.TAB_SOCIAL_INDEX) {
      if (this.pathStack.size() > 0) {
        this.pathStack.clear();
      }
    }
  }

  aboutToAppear(): void {
    this.moduleName = this.context.abilityInfo.moduleName;
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      this.hdsTitleBar = {
        style: {
          scrollEffectOpts: {
            scrollEffectType: ScrollEffectType.GRADIENT_BLUR,
          },
          systemMaterialEffect: {
            materialType: hdsMaterial.MaterialType.IMMERSIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          }
        },
        content: {
          title: {
            mainTitle: $r('app.string.SocialCircle')
          },
          divider: { showType: DividerShowType.OFF }
        }
      };
    }
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= CommonConstants.API_VERSION_23 &&
      this.moduleName !== CommonConstants.DEVICE_TYPE_PC) {
      HdsNavDestination() {
        Scroll() {
          Column() {
            Blank().height(56);
            SocialListView()
          }
        }
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .titleBar(this.hdsTitleBar)
      .hideBackButton(true)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    } else {
      NavDestination() {
        Column() {
          SocialListView()
        }
      }
      .backgroundColor($r('app.color.background_primary'))
      .title(this.TitleBuilder())
      .onReady(() => {
        if (this.pathStack.size() > 0) {
          this.pathStack.clear();
        }
      })
    }
  }

  @Builder
  TitleBuilder() {
    Row() {
      Text($r('app.string.SocialCircle'))
        .attributeModifier(new PageTitleModifier(CommonConstants.PAGE_TITLE_TYPE_0))
        .margin({ left: 16 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Builder
export function SocialPageBuilder() {
  SocialCommonView({ activeIndex: CommonConstants.TAB_SOCIAL_INDEX });
}