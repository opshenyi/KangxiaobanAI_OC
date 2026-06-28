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
import { commonEventManager, deviceInfo } from '@kit.BasicServicesKit';
import { i18n } from '@kit.LocalizationKit';
import uiObserver from '@ohos.arkui.observer';
import {
  CommonConstants,
  GlassCircle,
  Logger,
  MessageBubbleModifier,
  PageTitleModifier,
  WidthBreakpointType
} from 'commonmultidevicecommunication';
import { MessageModel } from '../model/MessageModel';

const TAG = 'MessageDetailView';

@ComponentV2
export struct MessageDetailView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Local messageModel: MessageModel = {
    name: $r('app.string.Message'),
    msg: $r('app.string.Message'),
    time: '',
    icon: $r('app.media.icon')
  };
  @Local moduleName: string = '';
  @Local systemLanguage: string = i18n.System.getSystemLanguage();
  @Local hdsTitleBar: HdsNavigationTitleBarOptions = {}
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private subscriber: commonEventManager.CommonEventSubscriber | undefined;
  private subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
    events: ['usual.event.LOCALE_CHANGED']
  };

  aboutToAppear(): void {
    this.moduleName = this.context.abilityInfo.moduleName;
    this.systemLanguage = i18n.System.getSystemLanguage();
    commonEventManager.createSubscriber(this.subscribeInfo)
      .then((commonEventSubscriber: commonEventManager.CommonEventSubscriber) => {
        this.subscriber = commonEventSubscriber;
        commonEventManager.subscribe(this.subscriber, (err: BusinessError) => {
          if (err) {
            Logger.error('MessageDetailView', `Subscribe failed`);
            return;
          }
          this.systemLanguage = i18n.System.getSystemLanguage();
        })
      });
  }

  aboutToDisappear(): void {
    commonEventManager.unsubscribe(this.subscriber, (err: BusinessError) => {
      if (err) {
        Logger.error(TAG, `Unsubscribe failed`);
      }
    });
  }

  build() {
    if (deviceInfo.distributionOSApiVersion >= CommonConstants.API_VERSION_23 &&
      this.moduleName !== CommonConstants.DEVICE_TYPE_PC) {
      HdsNavDestination() {
        Column() {
          Scroll() {
            Column() {
              Blank().height(56)
              Column() {
                Row() {
                  Image(this.messageModel.icon)
                    .width(40)
                    .height(40)
                    .onClick(() => {
                      this.jumpUserView(this.messageModel.name)
                    })
                  Column() {
                    Row() {
                      Image(this.systemLanguage === 'zh-Hans' ? $r('app.media.ic_tea') : $r('app.media.ic_tea_en'))
                        .width(16)
                        .height(16)
                        .margin({ left: 12 })
                      Text($r('app.string.tea'))
                        .fontSize(12)
                        .lineHeight(16)
                        .fontWeight(FontWeight.Regular)
                        .fontColor($r('app.color.font_primary'))
                        .margin({ left: 6 })
                    }
                    .margin({ top: 12 })
                    .width('100%')

                    Row() {
                      Text() {
                        Span(this.messageModel.name)
                        Span($r('app.string.drink_tea'))
                      }
                      .fontSize(14)
                      .lineHeight(19)
                      .fontWeight(FontWeight.Regular)
                      .fontColor($r('app.color.font_primary'))
                      .margin({ left: 12, top: 4 })
                    }
                    .width('100%')

                    Image($r('app.media.picture_applet_link'))
                      .width(186)
                      .height(138)
                      .margin({ top: 8 })

                    Row() {
                      Text($r('app.string.mini_program'))
                        .fontSize(10)
                        .lineHeight(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor($r('app.color.message_detail_program'))
                        .margin({ left: 12, top: 8 })
                    }
                    .width('100%')
                  }
                  .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_1))
                }
                .alignItems(VerticalAlign.Top)
                .margin({ top: 24 })
                .width('100%')
                .height(231)

                Row() {
                  Image(this.messageModel.icon)
                    .width(40)
                    .height(40)
                    .onClick(() => {
                      this.jumpUserView(this.messageModel.name);
                    })
                  Column() {
                    Row() {
                      Text($r('app.string.Speed'))
                        .fontSize(14)
                        .lineHeight(19)
                        .fontWeight(FontWeight.Regular)
                        .fontColor($r('app.color.font_primary'))
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .width('100%')
                    }
                    .width(224)
                  }
                  .justifyContent(FlexAlign.Center)
                  .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_2))
                }
                .height(58)
                .width('100%')
                .margin({ top: 24 })
                .alignItems(VerticalAlign.Top)

                Text(this.messageModel.time)
                  .fontSize(10)
                  .lineHeight(14)
                  .fontWeight(FontWeight.Regular)
                  .fontColor($r('app.color.font_primary'))
                  .margin({ top: 12 })

                Row() {
                  Image($r('app.media.avatar8'))
                    .width(40)
                    .height(40)
                    .onClick(() => {
                      this.jumpUserView($r('app.string.alice'))
                    })
                  Column() {
                    Text($r('app.string.happy'))
                      .fontSize(14)
                      .lineHeight(19)
                      .fontWeight(FontWeight.Regular)
                      .fontColor($r('app.color.font_on_primary'))
                  }
                  .justifyContent(FlexAlign.Center)
                  .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_3))
                }
                .reverse(true)
                .height(40)
                .width('100%')
                .margin({ top: 12 })
              }
              .width('100%')
              .padding(
                {
                  left: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint),
                  right: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint)
                })
            }
          }
          .align(Alignment.Top)
          .edgeEffect(EdgeEffect.Spring)
          .scrollBar(BarState.Off)
          .layoutWeight(1)
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

          this.TextInputBuilder()
        }
        .width('100%')
        .height('100%')
      }
      .titleBar(this.hdsTitleBar)
      .backgroundColor($r('app.color.background_secondary'))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .onReady((context: NavDestinationContext) => {
        this.messageModel = context.pathInfo.param as MessageModel;
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
                mainTitle: this.messageModel.name
              },
              divider: { showType: DividerShowType.OFF },
              menu: {
                value: [
                  {
                    content: {
                      icon: $r('app.media.ic_public_more')
                    }
                  }
                ]
              }
            }
          }
        }
      })
      .onBackPressed(() => {
        return this.onBack();
      })
    } else {
      NavDestination() {
        Column() {
          Scroll() {
            this.MessageBuilder(this.messageModel)
          }
          .align(Alignment.Top)
          .edgeEffect(EdgeEffect.Spring)
          .scrollBar(BarState.Off)
          .layoutWeight(1)

          this.TextInputBuilder()
        }
        .width('100%')
        .height('100%')
      }
      .title(this.TitleBuilder())
      .hideBackButton(true)
      .menus(this.MenuBuilder())
      .backgroundColor($r('app.color.background_secondary'))
      .onReady((context: NavDestinationContext) => {
        this.messageModel = context.pathInfo.param as MessageModel;
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
      Text(this.messageModel.name)
        .attributeModifier(new PageTitleModifier(CommonConstants.PAGE_TITLE_TYPE_1))
        .margin({ left: 16 })
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
  MenuBuilder() {
    if (this.moduleName === CommonConstants.DEVICE_TYPE_PC) {
      Image($r('app.media.ic_public_more'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .margin({ right: 140, top: 16 })
    } else {
      GlassCircle({ imageSrc: $r('app.media.ic_public_more') })
        .margin({ right: 16, top: 8 })
    }
  }

  @Builder
  MessageBuilder(messageModel: MessageModel) {
    Column() {
      Row() {
        Image(messageModel.icon)
          .width(40)
          .height(40)
          .onClick(() => {
            this.jumpUserView(messageModel.name)
          })
        Column() {
          Row() {
            Image(this.systemLanguage === 'zh-Hans' ? $r('app.media.ic_tea') : $r('app.media.ic_tea_en'))
              .width(16)
              .height(16)
              .margin({ left: 12 })
            Text($r('app.string.tea'))
              .fontSize(12)
              .lineHeight(16)
              .fontWeight(FontWeight.Regular)
              .fontColor($r('app.color.font_primary'))
              .margin({ left: 6 })
          }
          .margin({ top: 12 })
          .width('100%')

          Row() {
            Text() {
              Span(messageModel.name)
              Span($r('app.string.drink_tea'))
            }
            .fontSize(14)
            .lineHeight(19)
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.font_primary'))
            .margin({ left: 12, top: 4 })
          }
          .width('100%')

          Image($r('app.media.picture_applet_link'))
            .width(186)
            .height(138)
            .margin({ top: 8 })

          Row() {
            Text($r('app.string.mini_program'))
              .fontSize(10)
              .lineHeight(12)
              .fontWeight(FontWeight.Regular)
              .fontColor($r('app.color.message_detail_program'))
              .margin({ left: 12, top: 8 })
          }
          .width('100%')
        }
        .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_1))
      }
      .alignItems(VerticalAlign.Top)
      .margin({ top: 24 })
      .width('100%')
      .height(231)

      Row() {
        Image(messageModel.icon)
          .width(40)
          .height(40)
          .onClick(() => {
            this.jumpUserView(messageModel.name)
          })
        Column() {
          Row() {
            Text($r('app.string.Speed'))
              .fontSize(14)
              .lineHeight(19)
              .fontWeight(FontWeight.Regular)
              .fontColor($r('app.color.font_primary'))
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .width('100%')
          }
          .width(224)
        }
        .justifyContent(FlexAlign.Center)
        .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_2))
      }
      .height(58)
      .width('100%')
      .margin({ top: 24 })
      .alignItems(VerticalAlign.Top)

      Text(messageModel.time)
        .fontSize(10)
        .lineHeight(14)
        .fontWeight(FontWeight.Regular)
        .fontColor($r('app.color.font_primary'))
        .margin({ top: 12 })

      Row() {
        Image($r('app.media.avatar8'))
          .width(40)
          .height(40)
          .onClick(() => {
            this.jumpUserView($r('app.string.alice'))
          })
        Column() {
          Text($r('app.string.happy'))
            .fontSize(14)
            .lineHeight(19)
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.font_on_primary'))
        }
        .justifyContent(FlexAlign.Center)
        .attributeModifier(new MessageBubbleModifier(CommonConstants.MESSAGE_BUBBLE_STYLE_3))
      }
      .reverse(true)
      .height(40)
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(
      {
        left: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint),
        right: new WidthBreakpointType(16, 16, 32, 24).getValue(this.breakpoint.widthBreakpoint)
      })
  }

  @Builder
  TextInputBuilder() {
    Row() {
      Image($r('app.media.ic_public_emoji'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.message_detail_bot_img'))
      Row()
        .borderRadius(this.moduleName === CommonConstants.DEVICE_TYPE_PC ? 8 : 18)
        .backgroundColor($r('app.color.message_detail_bubble'))
        .height(34)
        .layoutWeight(1)
        .margin({ left: 16, right: 16 })
      Image($r('app.media.ic_public_add_norm'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.message_detail_bot_img'))
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
  }

  jumpUserView(name: Resource) {
    this.pathStack.pushPath({ name: 'UserView', param: name });
  }
}

@Builder
export function MessageDetailBuilder() {
  MessageDetailView();
}