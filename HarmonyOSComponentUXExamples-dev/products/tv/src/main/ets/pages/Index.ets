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

import { KeyboardAvoidMode } from '@kit.ArkUI';
import { ComponentGroup, CornerRadiusToken, NoMore, PaddingToken, SizeToken } from 'componentuxexamplesbase';
import { ListGroupTitle } from '../components/common/ListGroupTitle';

const COMPONENT_DATA: ComponentGroup[] = [
  {
    id: 'group_navigation',
    title: $r('app.string.navigation_components_label'),
    items: [
      { id: 'sub_tabs', name: $r('app.string.index_list_item_sub_tabs_label'), url: 'SubTabBarExample' },
      { id: 'title_bar', name: $r('app.string.index_list_item_title_bar_label'), url: 'TitleBarExample' },
      { id: 'swiper', name: $r('app.string.index_list_item_title_swiper_label'), url: 'SwiperExample' },
    ]
  },
  {
    id: 'group_display',
    title: $r('app.string.display_components_label'),
    items: [
      { id: 'sub_header', name: $r('app.string.index_list_item_sub_header_label'), url: 'SubHeaderExample' },
      { id: 'progress', name: $r('app.string.index_list_item_progress_label'), url: 'ProgressExample' },
      { id: 'badge', name: $r('app.string.index_list_item_badge_label'), url: 'BadgeExample' },
      { id: 'toast', name: $r('app.string.index_list_item_toast_label'), url: 'ToastExample' },
      { id: 'snakeBar', name: $r('app.string.index_list_item_snackbar_label'), url: 'HdsSnackBarExample' },
      { id: 'popup', name: $r('app.string.index_list_item_popup_label'), url: 'PopupExample' },
      { id: 'data_panel', name: $r('app.string.index_list_item_data_panel_label'), url: 'DataPanelExample' },
      { id: 'qrcode', name: $r('app.string.index_list_item_qrcode_label'), url: 'QRCodeExample' }
    ]
  },
  {
    id: 'group_operation',
    title: $r('app.string.operation_components_label'),
    items: [
      { id: 'btn', name: $r('app.string.index_list_item_button_label'), url: 'ButtonExample' },
      { id: 'select', name: $r('app.string.index_list_item_select_label'), url: 'SelectExample' },
      { id: 'chip', name: $r('app.string.index_list_item_chip_label'), url: 'ChipExample' },
      { id: 'actionbar', name: $r('app.string.index_list_item_actionbar_label'), url: 'ActionBarExample' },
      { id: 'menu', name: $r('app.string.index_list_item_menu_label'), url: 'MenuExample' }
    ]
  },
  {
    id: 'group_input',
    title: $r('app.string.input_components_label'),
    items: [
      { id: 'text_box', name: $r('app.string.index_list_item_textbox_label'), url: 'TextBoxExample' },
      { id: 'search_box', name: $r('app.string.index_list_item_searchbox_label'), url: 'SearchBoxExample' }
    ]
  },
  {
    id: 'group_selection',
    title: $r('app.string.selection_components_label'),
    items: [
      { id: 'checkbox', name: $r('app.string.index_list_item_check_box_label'), url: 'CheckboxExample' },
      { id: 'toggle', name: $r('app.string.index_list_item_toggle_label'), url: 'ToggleExample' },
      { id: 'radio', name: $r('app.string.index_list_item_radio_label'), url: 'RadioExample' },
      { id: 'rating', name: $r('app.string.index_list_item_rating_label'), url: 'RatingExample' },
      { id: 'slider', name: $r('app.string.index_list_item_slider_label'), url: 'SliderExample' },
      { id: 'picker', name: $r('app.string.index_list_item_picker_label'), url: 'PickerExample' },
      { id: 'segment', name: $r('app.string.index_list_item_segmented_button_label'), url: 'SegmentButtonExample' }
    ]
  },
  {
    id: 'group_container',
    title: $r('app.string.container_components_label'),
    items: [
      { id: 'list', name: $r('app.string.index_list_item_list_label'), url: 'ListExample' },
      { id: 'grid', name: $r('app.string.index_list_item_grid_label'), url: 'GridExample' },
      { id: 'dialog', name: $r('app.string.index_list_item_dialog_label'), url: 'DialogExample' },
      { id: 'bind_sheet', name: $r('app.string.index_list_item_bind_sheet_label'), url: 'BindSheetExample' }
    ]
  }
];

@Entry
@ComponentV2
struct Index {
  // The first component is selected by default
  @Local selectedIndex: string = '0_0';
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();
  @Provider('isSplit') isSplit: boolean = true;

  aboutToAppear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
    // Page for initially loading the first component
    this.navPathStack.replacePath({ name: COMPONENT_DATA[0].items[0].url.toString() });
  }

  @Builder
  NavigationTitle() {
    Column() {
      Text($r('app.string.index_title'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('app.float.nav_title_text_size'))
        .fontWeight(FontWeight.Bold)
        .height($r('app.float.nav_title_height'))
        .textAlign(TextAlign.Start)
        .padding({
          left: $r('app.float.page_padding'),
          right: $r('app.float.page_padding')
        })
        .margin({ top: $r('app.float.nav_title_margin_top') })
    }
    .alignItems(HorizontalAlign.Start)
    .width(SizeToken.SIZE_PERCENT_100)
  }

  build() {
    Navigation(this.navPathStack) {
      List() {
        Repeat(COMPONENT_DATA)
          .each((groupWrap) => {
            ListItemGroup({
              header: ListGroupTitle(groupWrap.item.title, $r('sys.float.padding_level12'))
            }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Column() {
                      Text(itemWrap.item.name)
                        .fontColor($r('sys.color.font_primary'))
                        .fontSize($r('sys.float.Body_L'))
                        .fontWeight(FontWeight.Medium)
                        .margin({ left: $r('sys.float.padding_level12') })
                    }
                    .alignItems(HorizontalAlign.Start)
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor(this.selectedIndex === `${groupWrap.index}_${itemWrap.index}` ?
                      $r('app.color.item_background_highlight_color') : Color.Transparent)
                    .stateStyles({
                      pressed: {
                        .backgroundColor($r('app.color.item_background_highlight_color'))
                      }
                    })
                    .width(SizeToken.SIZE_PERCENT_100)
                    .height($r('app.float.item_height_M'))
                    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
                    .hoverEffect(HoverEffect.Highlight)
                    .onClick(() => {
                      this.navPathStack.replacePath({ name: itemWrap.item.url.toString() });
                      this.selectedIndex = groupWrap.index + '_' + itemWrap.index;
                    })
                  }
                })
                .key((item) => item.id)
            }
            .padding({ top: groupWrap.index === 0 ? PaddingToken.PADDING_16VP : 0 })
            .divider({
              strokeWidth: SizeToken.SIZE_NUM_16,
              color: Color.Transparent
            })
          })
          .key((group) => group.id)

        ListItem() {
          NoMore();
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8')
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding')
      })
      .scrollBar(BarState.Off)
    }
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .title({
      builder: this.NavigationTitle(),
      height: $r('app.float.nav_height')
    })
    .backgroundColor($r('app.color.page_background_color'))
    .mode(this.isSplit ? NavigationMode.Split : NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Full)
    .navBarWidth(SizeToken.SIZE_PERCENT_40)
  }
}