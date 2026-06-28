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
import { uiObserver, window } from '@kit.ArkUI';
import {
  DividerShowType,
  hdsMaterial,
  HdsNavDestination,
  HdsNavigationTitleBarOptions,
  ScrollEffectType
} from '@kit.UIDesignKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import {
  CommonConstants,
  GlassCircle,
  NavigationStackUtil,
  PageTitleModifier,
  WindowUtil
} from 'commonmultidevicecommunication';
import { MessageListView } from 'message';
import { MessageModel } from 'message/src/main/ets/model/MessageModel';
import MessageListViewModel from 'message/src/main/ets/viewmodel/MessageListViewModel';

@ComponentV2
export struct MessagesCommonView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Require @Param activeIndex: number;
  @Provider() selectedIndex: number[] = [0];
  private hdsTitleBar: HdsNavigationTitleBarOptions = {}
  private moduleName: string = '';
  private scroller: Scroller = new Scroller();
  private messageListViewModel: MessageListViewModel = new MessageListViewModel();
  private firstMessage: MessageModel = {
    name: $r('app.string.Message'),
    msg: $r('app.string.Message'),
    time: '',
    icon: $r('app.media.icon')
  };
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private onWindowSizeChange: (windowSize: window.Size) => void = (_: window.Size) => {
    let width: WidthBreakpoint = this.getUIContext().getWindowWidthBreakpoint();
    if (width === WidthBreakpoint.WIDTH_MD || width === WidthBreakpoint.WIDTH_LG ) {
      if (this.activeIndex !== CommonConstants.TAB_MESSAGE_INDEX) {
        return;
      }
      NavigationStackUtil.StackModeToSplitMode(this.pathStack,
        { name: 'MessageDetailView', param: this.firstMessage });
    }
  };

  @Monitor('activeIndex')
  onActiveIndex(mon: IMonitor) {
    const value: IMonitorValue<number> | undefined = mon.value();
    if (!value) {
      return;
    }
    if (value.now as number === CommonConstants.TAB_MESSAGE_INDEX) {
      this.selectedIndex = [];
      this.selectedIndex.push(0);
      if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
        NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
          { name: 'MessageDetailView', param: this.firstMessage });
        return;
      }
      NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
        { name: 'MessageDetailView', param: this.firstMessage });
    }
  }

  aboutToAppear(): void {
    this.messageListViewModel.loadMessages();
    let messages = this.messageListViewModel.messages;
    if (messages.length > 0) {
      this.firstMessage = messages[0];
    }
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
            mainTitle: $r('app.string.Message')
          },
          divider: { showType: DividerShowType.OFF },
          menu: {
            value: [
              {
                content: {
                  icon: $r('app.media.ic_public_search')
                }
              },
              {
                content: {
                  icon: $r('app.media.ic_public_add_norm')
                }
              }
            ]
          }
        }
      };
    }
    this.moduleName = this.context.abilityInfo.moduleName;
    if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
      NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
        { name: 'MessageDetailView', param: this.firstMessage });
      return;
    }
    WindowUtil.getInstance().setWindowSizeChangeListener(this.onWindowSizeChange);
  }

  aboutToDisappear(): void {
    WindowUtil.getInstance().offWindowSizeChangeListener();
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= CommonConstants.API_VERSION_23 &&
      this.moduleName !== CommonConstants.DEVICE_TYPE_PC) {
      HdsNavDestination() {
        Scroll(this.scroller) {
          Column() {
            Blank().height(56)
            MessageListView({ messagesViewModel: this.messageListViewModel })
          }
        }
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .titleBar(this.hdsTitleBar)
      .hideBackButton(true)
      .onReady(() => {
        NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
          { name: 'MessageDetailView', param: this.firstMessage });
      })
    } else {
      NavDestination() {
        MessageListView({ messagesViewModel: this.messageListViewModel })
      }
      .title(this.TitleBuilder())
      .backgroundColor($r('app.color.background_primary'))
      .onReady(() => {
        NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
          { name: 'MessageDetailView', param: this.firstMessage });
      })
    }
  }

  @Builder
  TitleBuilder() {
    Row() {
      Text($r('app.string.Message'))
        .attributeModifier(new PageTitleModifier(CommonConstants.PAGE_TITLE_TYPE_0))
        .margin({ left: 16 })
      Blank()
      if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
        Image($r('app.media.ic_public_search'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 8 })
        Image($r('app.media.ic_public_add_norm'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 16 })
      } else {
        GlassCircle({ imageSrc: $r('app.media.ic_public_search') })
          .margin({ right: 8 })
        GlassCircle({ imageSrc: $r('app.media.ic_public_add_norm') })
          .margin({ right: 16 })
      }
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Builder
export function MessagesPageBuilder() {
  MessagesCommonView({ activeIndex: CommonConstants.TAB_MESSAGE_INDEX });
}