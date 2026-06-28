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
  ScrollEffectType,
  TitleBarStyleOptions
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
import { ContactListView } from 'social';
import ContactListViewModel from 'social/src/main/ets/viewmodel/ContactListViewModel';


@ComponentV2
export struct ContactsCommonView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Local contactsViewModel: ContactListViewModel = new ContactListViewModel();
  @Require @Param activeIndex: number;
  @Provider() selectedIndex: string[] = ['0_0'];
  private moduleName: string = '';
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private onWindowSizeChange: (windowSize: window.Size) => void = (_: window.Size) => {
    let width: WidthBreakpoint = this.getUIContext().getWindowWidthBreakpoint();
    if (width === WidthBreakpoint.WIDTH_MD || width === WidthBreakpoint.WIDTH_LG) {
      if (this.activeIndex !== CommonConstants.TAB_CONTACT_INDEX) {
        return;
      }
      NavigationStackUtil.StackModeToSplitMode(this.pathStack,
        { name: 'UserView', param: this.contactsViewModel.contacts['A'][0] });
    }
  };
  private style: TitleBarStyleOptions = {};

  @Monitor('activeIndex')
  onActiveIndex(mon: IMonitor) {
    const value: IMonitorValue<number> | undefined = mon.value();
    if (!value) {
      return;
    }
    if (value.now === CommonConstants.TAB_CONTACT_INDEX) {
      this.selectedIndex = [];
      this.selectedIndex.push('0_0');
      if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
        NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
          { name: 'UserView', param: this.contactsViewModel.contacts['A'][0] });
        return;
      }
      NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
        { name: 'UserView', param: this.contactsViewModel.contacts['A'][0] });
    }
  }

  aboutToAppear(): void {
    this.contactsViewModel.loadContacts();
    if (deviceInfo.distributionOSApiVersion >= 60100) {
      this.style = {
        scrollEffectOpts: {
          scrollEffectType: ScrollEffectType.GRADIENT_BLUR,
        },
        systemMaterialEffect: {
          materialType: hdsMaterial.MaterialType.IMMERSIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
        }
      };
    }
    this.moduleName = this.context.abilityInfo.moduleName;
    if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
      NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
        { name: 'UserView', param: this.contactsViewModel.contacts['A'][0] });
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
        Scroll() {
          Column() {
            Blank().height(56)
            ContactListView({ contactsViewModel: this.contactsViewModel })
          }
        }
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
      .titleBar({
        content: {
          title: {
            mainTitle: $r('app.string.Contacts')
          },
          divider: { showType: DividerShowType.OFF },
          menu: {
            value: this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
              this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? [
              {
                content: {
                  icon: $r('app.media.ic_public_search')
                }
              },
              {
                content: {
                  icon: $r('app.media.ic_public_add_norm')
                }
              },
              {
                content: {
                  icon: $r('app.media.ic_public_more')
                }
              }
            ] : [
              {
                content: {
                  icon: $r('app.media.ic_public_add_norm')
                }
              },
              {
                content: {
                  icon: $r('app.media.ic_public_more')
                }
              }
            ]
          }
        },
        style: this.style
      })
      .hideBackButton(true)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    } else {
      NavDestination() {
        ContactListView({ contactsViewModel: this.contactsViewModel })
      }
      .title(this.TitleBuilder())
      .backgroundColor($r('app.color.background_primary'))
      .onReady(() => {
        NavigationStackUtil.SplitModeDefaultStack(this.pathStack, this.breakpoint.widthBreakpoint,
          { name: 'UserView', param: this.contactsViewModel.contacts['A'][0] });
      })
    }
  }

  @Builder
  TitleBuilder() {
    Row() {
      Text($r('app.string.Contacts'))
        .attributeModifier(new PageTitleModifier(CommonConstants.PAGE_TITLE_TYPE_0))
        .margin({ left: 16 })
      Blank()
      if (this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
        this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD) {
        GlassCircle({ imageSrc: $r('app.media.ic_public_search') })
          .margin({ right: 8 })
      }
      if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
        Image($r('app.media.plus'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 8 })
        Image($r('app.media.ic_public_more'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 16 })
      } else {
        GlassCircle({ imageSrc: $r('app.media.plus') })
          .margin({ right: 8 })
        GlassCircle({ imageSrc: $r('app.media.ic_public_more') })
          .margin({ right: 16 })
      }
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Builder
export function ContactsPageBuilder() {
  ContactsCommonView({ activeIndex: CommonConstants.TAB_CONTACT_INDEX });
}