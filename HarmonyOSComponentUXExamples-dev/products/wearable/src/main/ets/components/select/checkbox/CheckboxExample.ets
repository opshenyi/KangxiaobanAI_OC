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
import { Logger, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

const TAG = 'CheckboxExample';

@Builder
export function CheckboxExampleBuilder() {
  CheckboxExample()
}

@ObservedV2
class CheckboxItem {
  @Trace public isSelect: boolean = false;
  @Trace public name: Resource = $r('app.string.checkbox_text_1')

  constructor(isSelect: boolean, name: Resource) {
    this.isSelect = isSelect;
    this.name = name;
  }
}

@ComponentV2
export struct CheckboxExample {
  @Local private param: string = ''
  private checkboxItems: CheckboxItem[] =
    [new CheckboxItem(false, $r('app.string.checkbox_text_1')),
      new CheckboxItem(false, $r('app.string.checkbox_text_2')),
      new CheckboxItem(false, $r('app.string.checkbox_text_3')),
      new CheckboxItem(false, $r('app.string.checkbox_text_4'))]

  build() {
    NavDestination() {
      List({ space: SizeToken.SIZE_NUM_6 }) {
        Repeat<CheckboxItem>(this.checkboxItems)
          .each((ri: RepeatItem<CheckboxItem>) => {
            ListItem() {
              Row() {
                Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
                  .width(SizeToken.SIZE_NUM_30)
                  .height(SizeToken.SIZE_NUM_30)
                  .select(ri.item.isSelect)
                  .selectedColor($r('app.color.blue_color'))
                  .margin({ left: SpaceToken.SPACE_10 })
                  .shape(CheckBoxShape.CIRCLE)
                  .onChange((value: boolean) => {
                    Logger.info(TAG, 'Checkbox1 change is' + value);
                    ri.item.isSelect = value
                  })
                Column() {
                  Text(ri.item.name)
                    .fontColor(Color.White)
                    .fontSize($r('sys.float.Title_M'))
                    .margin({ left: SpaceToken.SPACE_24 })
                  Text(ri.item.isSelect === true ? $r('app.string.selected') : $r('app.string.not_selected'))
                    .fontColor(Color.Gray)
                    .fontSize($r('sys.float.Title_S'))
                    .margin({ left: SpaceToken.SPACE_24 })
                }
                .height(SizeToken.SIZE_PERCENT_100)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
              .width(SizeToken.SIZE_NUM_181)
              .height(SizeToken.SIZE_NUM_50)
              .borderRadius($r('app.float.item_border_radius'))
              .backgroundColor($r('app.color.dark_gray_color'))
            }
          })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .alignListItem(ListItemAlign.Center)
      .scrollBar(BarState.Off)
      .contentEndOffset(SizeToken.SIZE_NUM_30)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }
    .title({ builder: TitleComponent(this.param), height: SizeToken.SIZE_NUM_45 })
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}