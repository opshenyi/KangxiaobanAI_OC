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
import { ArcList, LengthMetrics } from '@kit.ArkUI';
import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { ColorMetrics, ComponentContent } from '@ohos.arkui.node';
import { ArcAlphabetIndexer } from '@ohos.arkui.ArcAlphabetIndexer';
import { HeaderComponent } from '../../common/HeaderComponent';

@Builder
export function AlphabetIndexerExampleBuilder() {
  AlphabetIndexerExample()
}

interface ContactItemType {
  name: string;
  avatar?: ResourceStr;
  phoneNumber?: string;
}

@ObservedV2
class ContactItem {
  @Trace public name: string;
  @Trace public avatar: ResourceStr;
  @Trace public phoneNumber: string;

  constructor(param: ContactItemType) {
    this.name = param.name;
    this.avatar = param.name.length > 0 ? param.name.charAt(0).toUpperCase() : $r('sys.symbol.person_fill');
    this.phoneNumber = param.phoneNumber ?? '135XXXX9595';
  }
}

@ComponentV2
export struct AlphabetIndexerExample {
  @Local private param: string = ''
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  context: UIContext = this.getUIContext();
  private fullValue: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  @Local data: ContactItem[] = [
    new ContactItem({ name: 'Alice' }),
    new ContactItem({ name: 'Bob' }),
    new ContactItem({ name: 'Cindy', }),
    new ContactItem({ name: 'David' }),
    new ContactItem({ name: 'Eric' }),
    new ContactItem({ name: 'Finn' }),
    new ContactItem({ name: 'George' }),
    new ContactItem({ name: 'Helen' }),
    new ContactItem({ name: 'Isaac' }),
    new ContactItem({ name: 'Judy' }),
    new ContactItem({ name: 'Karon' }),
    new ContactItem({ name: 'Lda' }),
    new ContactItem({ name: 'Mella' }),
    new ContactItem({ name: 'Nana' }),
    new ContactItem({ name: 'Owen' }),
    new ContactItem({ name: 'Peter', }),
    new ContactItem({ name: 'Quinn', }),
    new ContactItem({ name: 'Ryan', }),
    new ContactItem({ name: 'Sophia' }),
    new ContactItem({ name: 'Taylor' }),
    new ContactItem({ name: 'Uma' }),
    new ContactItem({ name: 'Victor' }),
    new ContactItem({ name: 'William' }),
    new ContactItem({ name: 'Xavier' }),
    new ContactItem({ name: 'Yvonne' }),
    new ContactItem({ name: 'Zoe' })
  ];
  private scrollerForList: Scroller = new Scroller();
  @Local indexerIndex: number = 0;

  /**
   * @throws
   */
  build() {
    NavDestination() {
      Column() {
        Row() {
          Stack() {
            ArcList({
              scroller: this.scrollerForList,
              initialIndex: 0,
              header: new ComponentContent(this.context, wrapBuilder(HeaderComponent), this.param)
            }) {
              Repeat(this.data).each((itemWrap: RepeatItem<ContactItem>) => {
                Row() {
                  Text(itemWrap.item.avatar)
                    .width(SizeToken.SIZE_NUM_46)
                    .height(SizeToken.SIZE_NUM_46)
                    .backgroundColor($r('app.color.dark_gray_color'))
                    .borderRadius($r('sys.float.container_height'))
                    .fontSize(SizeToken.SIZE_NUM_24)
                    .fontColor(Color.White)
                    .focusable(true)
                    .focusOnTouch(true)
                    .defaultFocus(true)
                    .margin({ left: PaddingToken.PADDING_6VP })
                  Column() {
                    Text(itemWrap.item.name)
                      .fontColor(Color.White)
                      .fontSize($r('sys.float.Title_L'))
                      .margin({ left: PaddingToken.PADDING_6VP })
                    Text(itemWrap.item.phoneNumber)
                      .fontColor($r('app.color.gray_color'))
                      .fontSize($r('sys.float.Body_M'))
                      .margin({ left: PaddingToken.PADDING_6VP })
                  }.justifyContent(FlexAlign.Center)
                  .width(SizeToken.SIZE_NUM_115)
                  .height(SizeToken.SIZE_PERCENT_100)

                }
                .align(Alignment.Center)
                .width($r('app.float.item_width'))
                .height($r('app.float.home_item_height'))
                .borderRadius($r('app.float.home_item_height'))
                .backgroundColor($r('app.color.dark_gray_color'))
              })
            }
            .scrollBar(BarState.Off)
            .onScrollIndex((_firstIndex: number, _lastIndex: number, centerIndex: number) => {
              this.indexerIndex = centerIndex;
            })
            .focusable(true)
            .focusOnTouch(true)
            .defaultFocus(true)
            .borderWidth(SizeToken.SIZE_NUM_1)
            .width(SizeToken.SIZE_PERCENT_100)
            .height(SizeToken.SIZE_PERCENT_100)
            .borderRadius(SizeToken.SIZE_PERCENT_100)
            .space(LengthMetrics.px(SizeToken.SIZE_NUM_4))

            ArcAlphabetIndexer({ arrayValue: this.fullValue, selected: 0 })
              .autoCollapse(true)
              .width(SizeToken.SIZE_PERCENT_100)
              .height(SizeToken.SIZE_PERCENT_100)
              .usePopup(false)
              .selected(this.indexerIndex)
              .onSelect((index: number) => {
                this.indexerIndex = index;
                this.scrollerForList.scrollToIndex(this.indexerIndex);
              })
              .borderWidth(SizeToken.SIZE_NUM_1)
              .hitTestBehavior(HitTestMode.Transparent)
              .selectedColor(ColorMetrics.resourceColor(Color.White))
              .selectedBackgroundColor(ColorMetrics.resourceColor($r('app.color.blue_color')))
              .color(ColorMetrics.resourceColor(Color.White))
              .popupColor(ColorMetrics.resourceColor(Color.White))
              .itemSize(LengthMetrics.px(SizeToken.SIZE_NUM_24))
              .selectedFont({
                size: '11.0fp',
                style: FontStyle.Normal,
                weight: SizeToken.SIZE_NUM_500,
                family: 'HarmonyOS Sans'
              })
              .font({
                size: '11.0fp',
                style: FontStyle.Normal,
                weight: SizeToken.SIZE_NUM_500,
                family: 'HarmonyOS Sans'
              })

          }.width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
        }
      }
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as string;
    })
  }
}