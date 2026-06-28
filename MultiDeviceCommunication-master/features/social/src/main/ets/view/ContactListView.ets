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
import { AppStorageV2, uiObserver } from '@kit.ArkUI';
import {
  CommonConstants,
  DeviceInfo,
  Logger,
  RowSelectModifier,
  WidthBreakpointType
} from 'commonmultidevicecommunication';
import { ContactModel } from '../model/ContactModel';
import ContactListViewModel from '../viewmodel/ContactListViewModel'
import { common } from '@kit.AbilityKit';

const TAG = 'ContactListView';

@ComponentV2
export struct ContactListView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Consumer() pathStack: NavPathStack = new NavPathStack();
  @Require @Param contactsViewModel: ContactListViewModel = new ContactListViewModel();
  @Local letterIndex: number = 0;
  @Local alphabetX: number = 0;
  @Consumer() selectedIndex: string[] = ['0_0'];
  private listScroller: ListScroller = new ListScroller();
  private info: DeviceInfo | undefined = AppStorageV2.connect<DeviceInfo>(DeviceInfo, () => new DeviceInfo());
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private moduleName: string = '';

  aboutToAppear(): void {
    this.moduleName = this.context.abilityInfo.moduleName;
  }

  build() {
    Column() {
      if (this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
        this.breakpoint.heightBreakpoint === HeightBreakpoint.HEIGHT_MD) {
        this.contactsList(0);
      } else {
        this.topSearch();
        this.contactsList(28)
      }
    }
    .padding({
      left: new WidthBreakpointType(16, 16, 24, 16).getValue(this.breakpoint.widthBreakpoint),
      right: new WidthBreakpointType(16, 16, 24, 16).getValue(this.breakpoint.widthBreakpoint)
    })
    .backgroundColor($r('app.color.background_primary'))
    .width('100%')
    .height('100%')
  }

  @Builder
  topSearch() {
    Row() {
      Image($r('app.media.ic_public_search'))
        .width(16)
        .height(16)
        .margin({ left: 12 })
        .opacity(0.9)
      Text($r('app.string.search'))
        .margin({ left: 8 })
        .fontSize(16)
        .lineHeight(21)
        .fontWeight(FontWeight.Regular)
        .fontColor($r('app.color.font_secondary'))
    }
    .width('100%')
    .height(40)
    .borderRadius(this.moduleName === CommonConstants.DEVICE_TYPE_PC ? 8 : 24)
    .backgroundColor($r('app.color.comp_background_tertiary'))
  }

  @Builder
  contactsList(marginTop: number) {
    Stack({ alignContent: Alignment.End }) {
      List({ space: 28, scroller: this.listScroller }) {
        ForEach(this.contactsViewModel.nameFirstLetter, (letter: string, indexGroup: number) => {
          ListItemGroup({ header: this.letterColumnGroupHeader(letter) }) {
            if (Object.keys(this.contactsViewModel.contacts).includes(letter)) {
              ForEach(this.contactsViewModel.contacts[letter], (item: ContactModel, index: number) => {
                ListItem() {
                  ContactView({
                    contact: item,
                    index: indexGroup + '_' + index,
                    breakpoint: this.breakpoint,
                    moduleName: this.moduleName,
                  })
                    .onClick(() => {
                      this.selectedIndex.push(indexGroup + '_' + index);
                      const targetParam = this.pathStack.getParamByName('UserView') as string[];
                      if (targetParam[targetParam.length - 1] === item.name) {
                        return;
                      }
                      this.pathStack.pushPath({
                        name: 'UserView', param: item.name, onPop: () => {
                          this.selectedIndex.pop();
                        }
                      });
                    })
                }
              }, (item: ContactModel, indexItem: number) => indexItem + JSON.stringify(item))
            }
          }
        }, (item: string, indexGroup: number) => indexGroup + JSON.stringify(item))
      }
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.Header)
      .margin({ top: marginTop })
      .onScrollIndex((index: number) => {
        this.letterIndex = index;
      })

      this.alphabetIndex();
    }
    .layoutWeight(1)
  }

  @Builder
  letterColumnGroupHeader(letter: string) {
    Column() {
      Text(letter)
        .fontSize(14)
        .lineHeight(19)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.font_secondary'))
    }
    .width('100%')
    .height(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  alphabetIndex() {
    AlphabetIndexer({ arrayValue: this.contactsViewModel.nameFirstLetter, selected: this.letterIndex })
      .width(24)
      .selectedColor($r('app.color.background_emphasize'))
      .selectedBackgroundColor($r('app.color.select_list_item_background'))
      .font({ size: 12 })
      .selectedFont({ size: 12 })
      .margin({ bottom: this.info && this.info.distributionOSApiVersion >= CommonConstants.API_VERSION_23 ? 50 : 0 })
      .itemSize(16)
      .onSelect((index: number) => {
        try {
          this.listScroller.scrollToItemInGroup(index, 0);
        } catch (error) {
          let err = error as BusinessError;
          Logger.error(TAG, `scroll failed, errorCode:${err.code}, errorMsg:${err.message}`);
        }
      })
  }
}

@ComponentV2
export struct ContactView {
  @Require @Param contact: ContactModel;
  @Require @Param index: string;
  @Consumer() selectedIndex: string[] = ['0_0'];
  @Require @Param breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Require @Param moduleName: string;

  build() {
    Row() {
      Image(this.contact.icon)
        .width(40)
        .height(40)
        .margin({ left: new WidthBreakpointType(8, 12, 16, 12).getValue(this.breakpoint.widthBreakpoint) })
      Column() {
        Text(this.contact.name)
          .fontSize(16)
          .lineHeight(21)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.font_primary'))
          .margin({ top: 22 })
        Row()
          .width('100%')
          .height('1px')
          .backgroundColor($r('app.color.divider_color'))
          .margin({ top: 20 })
      }
      .alignItems(HorizontalAlign.Start)
      .height('100%')
      .layoutWeight(1)
      .margin({ left: 12 })
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
    .attributeModifier(new RowSelectModifier(CommonConstants.TAB_CONTACT_INDEX, this.breakpoint.widthBreakpoint,
      this.selectedIndex[this.selectedIndex.length - 1], this.index))
    .borderRadius(this.moduleName === CommonConstants.DEVICE_TYPE_PC ? 8 : 16)
    .width('100%')
    .height(66)
  }
}