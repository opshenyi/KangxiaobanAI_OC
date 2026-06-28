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
import { util } from '@kit.ArkTS';
import { HdsNavDestination } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { BreakpointModel, ComponentItem, HdsUtil, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';

interface ContactItemType {
  id?: string;
  name: ResourceStr;
  avatar?: ResourceStr;
}

/**
 * Enhanced data model for an individual contact item.
 */
@ObservedV2
class ContactItem {
  public readonly id: string;
  @Trace public name: ResourceStr;
  @Trace public avatar: ResourceStr;

  constructor(param: ContactItemType) {
    this.id = param.id ?? util.generateRandomUUID(true);
    this.name = param.name;
    this.avatar = param.avatar ?? $r('app.media.avatar1');
  }
}

/**
 * Data model for a grouped section of contacts.
 */
class ContactGroup {
  public letter: string;
  public contacts: ContactItem[];

  constructor(letter: string, contacts: ContactItem[]) {
    this.letter = letter;
    this.contacts = contacts;
  }
}

@Builder
export function BasicStyleAlphabetIndexerBuilder() {
  BasicStyleAlphabetIndexer()
}

@ComponentV2
struct BasicStyleAlphabetIndexer {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local pageParam: ComponentItem = { id: '', name: '', url: '' };
  // State Management: Tracks the currently selected index in the AlphabetIndexer
  @Local selectedIndex: number = 0;
  // Expanded Data Source: Comprehensive mock data for demonstration
  @Local contactGroups: ContactGroup[] = [
    new ContactGroup('A', [
      new ContactItem({ name: 'Alice' }),
      new ContactItem({ name: 'Aaron' }),
      new ContactItem({ name: 'Ada' })
    ]),
    new ContactGroup('B', [
      new ContactItem({ name: 'Bob' }),
      new ContactItem({ name: 'Bella' })
    ]),
    new ContactGroup('C', [
      new ContactItem({ name: 'Cathy' }),
      new ContactItem({ name: 'Chris', avatar: $r('app.media.avatar2') }), // Custom avatar
      new ContactItem({ name: 'Cindy', avatar: $r('app.media.avatar2') })
    ]),
    new ContactGroup('D', [
      new ContactItem({ name: 'David' }),
      new ContactItem({ name: 'Daisy', avatar: $r('app.media.avatar2') })
    ]),
    new ContactGroup('E', [
      new ContactItem({ name: 'Eric' }),
      new ContactItem({ name: 'Emily', avatar: $r('app.media.avatar2') })
    ]),
    new ContactGroup('F', [
      new ContactItem({ name: 'Finn' }),
      new ContactItem({ name: 'Fiona', avatar: $r('app.media.avatar2') }),
      new ContactItem({ name: 'Freya' })
    ]),
    new ContactGroup('G', [
      new ContactItem({ name: 'Grace' }),
      new ContactItem({ name: 'George' }),
      new ContactItem({ name: 'Gary' }),
      new ContactItem({ name: 'Gavin' }),
      new ContactItem({ name: 'Gloria' })
    ]),
    new ContactGroup('H', [
      new ContactItem({ name: 'Henry' }),
      new ContactItem({ name: 'Hunter' }),
      new ContactItem({ name: 'Helen' })
    ]),
    new ContactGroup('I', [
      new ContactItem({ name: 'Isaac' }),
      new ContactItem({ name: 'Ivy' })
    ]),
    new ContactGroup('J', [
      new ContactItem({ name: 'Jack' }),
      new ContactItem({ name: 'Jane' }),
      new ContactItem({ name: 'Judy' })
    ])
  ];
  // Controller: Manages list scrolling behavior
  private listScroller: ListScroller = new ListScroller();
  // Data Source: Standard alphabet array
  private alphabets: string[] = [
    '#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  aboutToAppear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
  }

  aboutToDisappear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  build() {
    HdsNavDestination() {
      Stack({ alignContent: Alignment.End }) {
        List({ scroller: this.listScroller }) {
          // Outer Repeat for groups
          Repeat<ContactGroup>(this.contactGroups)
            .each((groupItem: RepeatItem<ContactGroup>) => {
              ListItemGroup({ header: this.itemGroupHeader(groupItem.item.letter) }) {
                // Inner Repeat for contact items
                Repeat<ContactItem>(groupItem.item.contacts)
                  .each((contactItem: RepeatItem<ContactItem>) => {
                    ListItem() {
                      Row({ space: SpaceToken.SPACE_16 }) {
                        Image(contactItem.item.avatar)
                          .width(SizeToken.SIZE_NUM_40)
                          .height(SizeToken.SIZE_NUM_40)
                          .objectFit(ImageFit.Cover)

                        Text(contactItem.item.name)
                          .fontSize($r('sys.float.Subtitle_M'))
                          .fontColor($r('sys.color.font_primary'))
                          .fontWeight(FontWeight.Medium)
                      }
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .width(SizeToken.SIZE_PERCENT_100)
                      .height(SizeToken.SIZE_NUM_64)
                    }
                  })
                  .key((item: ContactItem) => item.id)
              }
              .divider({
                strokeWidth: SizeToken.SIZE_NUM_1PX,
                color: $r('sys.color.comp_divider'),
                startMargin: PaddingToken.PADDING_56VP,
                endMargin: PaddingToken.PADDING_12VP
              })
            })
            .key((item: ContactGroup) => item.letter)
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)
        .scrollBar(BarState.Off)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        .padding({
          left: this.breakpointModel.getValue({
            sm: PaddingToken.PADDING_16VP,
            md: PaddingToken.PADDING_16VP,
            lg: PaddingToken.PADDING_24VP
          }),
          right: PaddingToken.PADDING_24VP
        })
        .onScrollIndex((firstIndex: number) => {
          this.onListScrolled(firstIndex);
        })

        AlphabetIndexer({ arrayValue: this.alphabets, selected: this.selectedIndex })
          .width(SizeToken.SIZE_NUM_24)
          .autoCollapse(true)
          .usingPopup(true)
          .onSelect((index: number) => {
            this.onIndexerSelected(index);
          })
      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
    }
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .titleBar({
      padding: {
        start: this.horizontalPaddingLength,
        end: this.horizontalPaddingLength
      },
      enableComponentSafeArea: true,
      style: HdsUtil.getHdsStyle(),
      content: {
        title: {
          mainTitle: $r('app.string.alphabet_indexer_en_label')
        }
      }
    })
    .onReady((context: NavDestinationContext) => {
      this.pageParam = context.pathInfo.param as ComponentItem;
    })
  }

  /**
   * Two-way sync: Handle AlphabetIndexer selection
   */
  private onIndexerSelected(index: number): void {
    this.selectedIndex = index;
    const targetLetter = this.alphabets[index];
    const targetGroupIndex = this.contactGroups.findIndex(group => group.letter === targetLetter);
    if (targetGroupIndex !== -1) {
      this.listScroller.scrollToIndex(targetGroupIndex);
    }
  }

  /**
   * Two-way sync: Handle List scrolling
   */
  private onListScrolled(firstIndex: number): void {
    if (this.contactGroups[firstIndex]) {
      const currentLetter = this.contactGroups[firstIndex].letter;
      const targetAlphabetIndex = this.alphabets.indexOf(currentLetter);
      if (targetAlphabetIndex !== -1) {
        this.selectedIndex = targetAlphabetIndex;
      }
    }
  }

  @Builder
  private itemGroupHeader(text: string) {
    Row() {
      Text(text)
        .fontSize($r('sys.float.Caption_L'))
        .fontColor($r('sys.color.font_secondary'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SizeToken.SIZE_NUM_40)
    .width(SizeToken.SIZE_PERCENT_100)
  }
}