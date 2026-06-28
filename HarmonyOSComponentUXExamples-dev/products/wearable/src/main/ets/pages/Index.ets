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
import { ArcList, ArcListItem, ComponentContent, LengthMetrics, UIContext } from '@kit.ArkUI';
import { PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { HeaderComponent } from '../components/common/HeaderComponent';
import { SubTitleComponent } from '../components/common/SubTitleComponent';

export interface HomeItemData {
  avatar: ResourceStr;
  name: ResourceStr;
  url: ResourceStr;

}

export interface HomeGroupData {
  title: ResourceStr;
  items: HomeItemData[];
}

const HOME_GROUP_DATA: HomeGroupData[] = [
  {
    title: $r('app.string.navigation_components_label'),
    items: [
      {
        avatar: $r('app.media.ic_titlebar'),
        name: $r('app.string.index_list_item_title_bar_label'),
        url: 'TitleBarExample'
      },
      { avatar: $r('app.media.ic_swiper'), name: $r('app.string.index_list_item_swiper_label'), url: 'SwiperExample' }
    ]
  },
  {
    title: $r('app.string.display_components_label'),
    items: [
      { avatar: $r('app.media.ic_text'), name: $r('app.string.index_list_item_text_label'), url: 'TextExample' },
      {
        avatar: $r('app.media.ic_progress'),
        name: $r('app.string.index_list_item_progress_label'),
        url: 'ProgressExample'
      },
      { avatar: $r('app.media.ic_toast'), name: $r('app.string.index_list_item_toast_label'), url: 'ToastExample' },
      { avatar: $r('app.media.ic_qrcode'), name: $r('app.string.qrcode_label'), url: 'QRCodeExample' },
      {
        avatar: $r('app.media.ic_alphabetIndexer'),
        name: $r('app.string.alphabet_indexer_label'),
        url: 'AlphabetIndexerExample'
      }
    ]
  },
  {
    title: $r('app.string.operation_components_label'),
    items: [
      { avatar: $r('app.media.ic_btn'), name: $r('app.string.index_list_item_button_label'), url: 'ButtonExample' }
    ]
  },
  {
    title: $r('app.string.input_components_label'),
    items: [
      {
        avatar: $r('app.media.ic_textinput'),
        name: $r('app.string.index_list_item_textbox_label'),
        url: 'TextInputExample'
      },
      {
        avatar: $r('app.media.ic_search'),
        name: $r('app.string.index_list_item_searchbox_label'),
        url: 'SearchBoxExample'
      }
    ]
  },
  {
    title: $r('app.string.selection_components_label'),
    items: [
      { avatar: $r('app.media.ic_toggle'), name: $r('app.string.index_list_item_toggle_label'), url: 'ToggleExample' },
      { avatar: $r('app.media.ic_slider'), name: $r('app.string.index_list_item_slider_label'), url: 'SliderExample' },
      { avatar: $r('app.media.ic_radio'), name: $r('app.string.index_list_item_radio_label'), url: 'RadioExample' },
      {
        avatar: $r('app.media.ic_checkbox'),
        name: $r('app.string.index_list_item_checkbox_label'),
        url: 'CheckboxExample'
      },
      { avatar: $r('app.media.ic_picker'), name: $r('app.string.index_list_item_picker_label'), url: 'PickerExample' }
    ]
  },
  {
    title: $r('app.string.container_components_label'),
    items: [
      { avatar: $r('app.media.ic_list'), name: $r('app.string.index_list_item_list_label'), url: 'ListExample' },
      { avatar: $r('app.media.ic_dialog'), name: $r('app.string.index_list_item_dialog_label'), url: 'DialogExample' },
    ]
  }
];

@Entry
@ComponentV2
struct Index {
  context: UIContext = this.getUIContext();
  listHeader: ComponentContent<Object> =
    new ComponentContent(this.context, wrapBuilder(HeaderComponent), $r('app.string.index_title'));
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();

  @Builder
  ItemComponent(item: HomeItemData) {
    Row() {
      Image(item.avatar)
        .width($r('sys.float.container_height'))
        .height($r('sys.float.container_height'))
        .borderRadius($r('sys.float.container_height'))
        .margin({ left: PaddingToken.PADDING_6VP })
      Text(item.name)
        .fontColor(Color.White)
        .fontSize($r('sys.float.Title_L'))
        .width($r('app.float.home_item_text_width'))
        .margin({ left: PaddingToken.PADDING_6VP })
      SymbolGlyph($r('sys.symbol.chevron_right'))
        .width(SizeToken.SIZE_NUM_48)
        .height(SizeToken.SIZE_NUM_48)
        .fontSize(SizeToken.SIZE_NUM_24)
        .fontColor([Color.White])
    }
    .align(Alignment.Center)
    .width($r('app.float.item_width'))
    .height($r('app.float.home_item_height'))
    .borderRadius($r('app.float.home_item_height'))
    .backgroundColor($r('app.color.dark_gray_color'))
    .onClick(() => {
      this.navPathStack.replacePath({ name: item.url.toString(), param: item.name });
    })
  }

  build() {
    Navigation(this.navPathStack) {
      ArcList({ header: this.listHeader }) {
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[0].title)
        }

        Repeat(HOME_GROUP_DATA[0].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[1].title)
        }.margin({ top: SizeToken.SIZE_NUM_16 })

        Repeat(HOME_GROUP_DATA[1].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[2].title)
        }.margin({ top: SizeToken.SIZE_NUM_16 })

        Repeat(HOME_GROUP_DATA[2].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[3].title)
        }.margin({ top: SizeToken.SIZE_NUM_16 })

        Repeat(HOME_GROUP_DATA[3].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[4].title)
        }.margin({ top: SizeToken.SIZE_NUM_16 })

        Repeat(HOME_GROUP_DATA[4].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
        ArcListItem() {
          SubTitleComponent(HOME_GROUP_DATA[5].title)
        }.margin({ top: SizeToken.SIZE_NUM_16 })

        Repeat(HOME_GROUP_DATA[5].items)
          .each((itemWrap) => {
            ArcListItem() {
              this.ItemComponent(itemWrap.item)
            }
          })
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .width(SizeToken.SIZE_PERCENT_100)
      .space(LengthMetrics.px(PaddingToken.PADDING_4VP))
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }
    .backgroundColor(Color.Black)
    .hideTitleBar(true)
  }
}