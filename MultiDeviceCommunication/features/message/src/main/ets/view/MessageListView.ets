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
import { common } from '@kit.AbilityKit';
import { CommonConstants, RowSelectModifier, WidthBreakpointType } from 'commonmultidevicecommunication';
import { MessageModel } from '../model/MessageModel';
import MessageListViewModel from '../viewmodel/MessageListViewModel'

@ComponentV2
export struct MessageListView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Require @Param messagesViewModel: MessageListViewModel = new MessageListViewModel();
  @Local moduleName: string = '';
  @Consumer() selectedIndex: number[] = [0];
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;

  aboutToAppear(): void {
    this.moduleName = this.context.abilityInfo.moduleName;
  }

  build() {
    List() {
      ForEach(this.messagesViewModel.messages, (item: MessageModel, index: number) => {
        ListItem() {
          MessageView({
            message: item,
            index: index,
            breakpoint: this.breakpoint,
            moduleName: this.moduleName,
          })
            .onClick(() => {
              this.selectedIndex.push(index);
              const targetParam = this.pathStack.getParamByName('MessageDetailView') as MessageModel[];
              if (targetParam[targetParam.length - 1] === item) {
                return;
              }
              this.pathStack.pushPath({
                name: 'MessageDetailView', param: item, onPop: () => {
                  this.selectedIndex.pop();
                }
              });
            })
        }
      }, (item: MessageModel, index: number) => index + JSON.stringify(item))
    }
    .backgroundColor($r('app.color.background_primary'))
    .scrollBar(BarState.Off)
  }
}

@ComponentV2
export struct MessageView {
  @Require @Param message: MessageModel;
  @Require @Param index: number;
  @Consumer() selectedIndex: number[] = [0];
  @Require @Param breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Require @Param moduleName: string;

  build() {
    Row() {
      Row() {
        Image(this.message.icon)
          .height(40)
          .width(40)
          .margin({ left: new WidthBreakpointType(8, 12, 16, 12).getValue(this.breakpoint.widthBreakpoint) })
        Column() {
          Row() {
            Text(this.message.name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .lineHeight(21)
            Blank()
            Row() {
              Text(this.message.time)
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .lineHeight(21)
                .fontColor(Color.Grey)
            }
            .width(33)
          }
          .width('100%')
          .height(22)
          .margin({ top: 14 })

          Text(this.message.msg)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .lineHeight(19)
            .fontColor(Color.Grey)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 2 })
            .width('100%')

          Row()
            .width('100%')
            .height('1px')
            .backgroundColor($r('app.color.divider_color'))
            .margin({ top: 14 })
        }
        .margin({ left: 16, right: new WidthBreakpointType(8, 12, 16, 12).getValue(this.breakpoint.widthBreakpoint) })
        .height('100%')
        .layoutWeight(1)
      }
      .stateStyles({
        pressed: {
          .backgroundColor($r('app.color.comp_emphasize_tertiary'))
          .borderRadius(16)
        },
        normal: {
          .backgroundColor($r('app.color.background_primary'))
          .borderRadius(0)
        }
      })
      .attributeModifier(new RowSelectModifier(CommonConstants.TAB_MESSAGE_INDEX, this.breakpoint.widthBreakpoint,
        this.selectedIndex[this.selectedIndex.length - 1].toString(), this.index.toString()))
      .borderRadius(this.moduleName === CommonConstants.DEVICE_TYPE_PC ? 8 : 16)
    }
    .width('100%')
    .height(72)
  }
}