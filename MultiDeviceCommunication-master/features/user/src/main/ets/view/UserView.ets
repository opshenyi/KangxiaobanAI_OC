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
import { uiObserver } from '@kit.ArkUI';
import { hdsMaterial } from '@kit.UIDesignKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import {
  DividerShowType,
  HdsNavDestination,
  HdsNavigationTitleBarOptions,
  ScrollEffectType
} from '@hms.hds.hdsBaseComponent';
import { CommonConstants, GlassCircle, UserModel, WidthBreakpointType } from 'commonmultidevicecommunication';
import { UserListViewModel } from '../viewmodel/UserListViewModel';
import { UserColumnModifier } from './UserColumnModifier';

@ComponentV2
export struct UserView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Local usersViewModel: UserListViewModel = new UserListViewModel();
  @Local userModel: UserModel = {
    name: $r('app.string.Me'),
    icon: $r('app.media.icon'),
    phoneNum: '',
    lastUpdate: []
  };
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private moduleName: string = '';
  private hdsTitleBar: HdsNavigationTitleBarOptions = {};

  aboutToAppear(): void {
    this.usersViewModel.loadUsers();
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
            Blank()
              .height(56)
            this.User()
          }
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .height('100%')
        .align(Alignment.Top)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .titleBar(this.hdsTitleBar)
      .backgroundColor($r('app.color.user_background'))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .onReady((context: NavDestinationContext) => {
        this.getUserData(context);
      })
      .onBackPressed(() => {
        return this.onBack();
      })
    } else {
      NavDestination() {
        Scroll() {
          this.User()
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .height('100%')
        .align(Alignment.Top)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
      .backgroundColor($r('app.color.user_background'))
      .hideBackButton(true)
      .title(this.TitleBuilder())
      .onReady((context: NavDestinationContext) => {
        this.getUserData(context);
      })
      .onBackPressed(() => {
        return this.onBack();
      })
    }
  }

  onBack(): boolean {
    if (this.pathStack.size() > 1) {
      this.pathStack.pop('back');
      return true;
    }
    return false;
  }

  @Builder
  TitleBuilder() {
    Row() {
      if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
        SymbolGlyph($r('sys.symbol.arrow_left'))
          .fontSize(24)
          .margin({ left: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint) })
          .onClick(() => {
            this.handleBack();
          })
      } else {
        GlassCircle({
          imageSrc: $r('app.media.ic_public_back')
        })
          .margin({ left: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint) })
          .onClick(() => {
            this.handleBack();
          })
      }
    }
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  handleBack() {
    let pathStackSize = this.pathStack.size();
    if (this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_XS ||
      this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM && pathStackSize > 0) {
      this.pathStack.pop();
      return;
    }
    if (pathStackSize > 1) {
      this.pathStack.pop();
    }
  }

  @Builder
  User() {
    Stack({ alignContent: Alignment.Top }) {
      Image(this.userModel.icon)
        .width(116)
        .height(116)
        .margin({ top: 28 })
        .zIndex(2)
        .border({
          width: 5,
          color: Color.White,
          radius: 100
        })

      Column() {
        Text(this.userModel.name)
          .fontSize(24)
          .lineHeight(32)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.font_primary')
          )
          .margin({ top: 82 })
        Row() {
          Text(this.userModel.phoneNum)
            .fontSize(16)
            .lineHeight(21)
            .fontColor($r('app.color.font_primary'))
          Blank()
          Row() {
            Image($r('app.media.ic_public_phone'))
              .width(24)
              .height(24)
              .margin({ right: 24 })
              .fillColor($r('app.color.social_icon'))
            Image($r('app.media.ic_public_video'))
              .width(24)
              .height(24)
              .margin({ right: 24 })
              .fillColor($r('app.color.social_icon'))
            Image($r('app.media.ic_public_comments'))
              .width(24)
              .height(24)
              .fillColor($r('app.color.social_icon'))
          }
        }
        .margin({ top: 49 })
        .width('100%')
        .height(21)

        Row() {
          Divider()
            .height('1px')
            .backgroundColor($r('app.color.divider_color'))
        }
        .width('100%')
        .padding({ top: 18 })

        Row() {
          Text($r('app.string.news'))
            .fontSize(16)
            .lineHeight(21)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.Black)
        }
        .width('100%')
        .padding({ top: 12 })

        Row() {
          Grid() {
            ForEach(this.userModel.lastUpdate, (item: Resource) => {
              GridItem() {
                Image(item)
                  .objectFit(ImageFit.Cover)
              }
            }, (item: number, index: number) => JSON.stringify(item) + index)
          }
          .layoutDirection(GridDirection.Row)
          .rowsTemplate('1fr 1fr')
          .columnsTemplate('1fr 1fr 1fr')
          .rowsGap(5)
          .columnsGap(5)
          .width('100%')
          .aspectRatio(1.5)
        }
        .width('100%')
        .padding({ top: 8 })
      }
      .attributeModifier(new UserColumnModifier(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
        this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD))
      .padding({
        left: new WidthBreakpointType(16, 24, 32, 24).getValue(this.breakpoint.widthBreakpoint),
        right: new WidthBreakpointType(16, 24, 32, 24).getValue(this.breakpoint.widthBreakpoint)
      })
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }

  getUserData(context: NavDestinationContext) {
    const name: Resource | string = context.pathInfo.param as Resource | string;
    if (this.usersViewModel.users.length <= 0) {
      return;
    }
    if (typeof name === 'string') {
      this.userModel = this.usersViewModel.users.filter(user => (user.name as string) === (name as string))[0];
    } else {
      this.userModel =
        this.usersViewModel.users.filter(user => (user.name as Resource).id === (name as Resource).id)[0];
    }
  }
}

@Builder
export function UserBuilder() {
  UserView();
}