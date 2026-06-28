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
import { Logger } from 'componentuxexamplesbase';
import { Popup, PopupButtonOptions, PopupIconOptions, PopupTextOptions } from '@ohos.arkui.advanced.Popup';
import { CommonListRow, CornerRadiusToken, SizeToken, SubTitleView as GroupHeader } from 'componentuxexamplesbase';

const TAG = 'BasicStylePopup';

@ComponentV2
export struct BasicStylePopup {
  @Local handlePopup1: boolean = false;
  @Local handlePopup2: boolean = false;
  @Local handlePopup3: boolean = false;
  @Local handlePopup4: boolean = false;
  @Local handlePopup5: boolean = false;

  @Styles
  commonListItemStyles() {
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .stateStyles({
      normal: {
        .backgroundColor($r('sys.color.comp_background_list_card'))
      },
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      }
    })
  }

  /**
   * Style: Text + Close Button
   */
  @Builder
  PopupStyle2() {
    Row() {
      Popup({
        maxWidth: SizeToken.SIZE_NUM_312,
        message: {
          text: 'A'.repeat(25),
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_primary'),
          fontWeight: FontWeight.Regular
        } as PopupTextOptions,
        showClose: true,
        onClose: () => {
          if (this.handlePopup2) {
            this.handlePopup2 = false;
          }
        }
      })
    }
  }

  /**
   * Style: Title + Text + Close Button
   */
  @Builder
  PopupStyle3() {
    Row() {
      Popup({
        maxWidth: SizeToken.SIZE_NUM_312,
        title: {
          text: $r('app.string.title_en_label'),
          fontSize: $r('sys.float.Subtitle_M'),
          fontColor: $r('sys.color.font_primary'),
          fontWeight: FontWeight.Medium
        } as PopupTextOptions,
        message: {
          text: 'A'.repeat(50),
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_secondary'),
          fontWeight: FontWeight.Regular
        } as PopupTextOptions,
        showClose: true,
        onClose: () => {
          if (this.handlePopup3) {
            this.handlePopup3 = false;
          }
        }
      })
    }
  }

  /**
   * Style: Title + Text + Close Button + Action
   */
  @Builder
  PopupStyle4() {
    Row() {
      Popup({
        maxWidth: SizeToken.SIZE_NUM_312,
        title: {
          text: $r('app.string.title_en_label'),
          fontSize: $r('sys.float.Subtitle_M'),
          fontColor: $r('sys.color.font_primary'),
          fontWeight: FontWeight.Medium
        } as PopupTextOptions,
        message: {
          text: 'A'.repeat(50),
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_secondary'),
          fontWeight: FontWeight.Regular
        } as PopupTextOptions,
        showClose: true,
        onClose: () => {
          if (this.handlePopup4) {
            this.handlePopup4 = false;
          }
        },
        buttons: [{
          text: $r('app.string.confirm_en_label'),
          action: () => {
            Logger.info(TAG, 'Confirm button clicked');
          },
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_emphasize')
        },
          {
            text: $r('app.string.cancel_en_label'),
            action: () => {
              Logger.info(TAG, 'Cancel button clicked');
            },
            fontSize: $r('sys.float.Body_M'),
            fontColor: $r('sys.color.font_emphasize')
          }] as [PopupButtonOptions?, PopupButtonOptions?]
      })
    }
  }

  /**
   * Style: Icon + Title + Text + Close Button + Action
   */
  @Builder
  PopupStyle5() {
    Row() {
      Popup({
        maxWidth: SizeToken.SIZE_NUM_312,
        icon: {
          image: $r('app.media.startIcon'),
          width: SizeToken.SIZE_NUM_32,
          height: SizeToken.SIZE_NUM_32,
          borderRadius: CornerRadiusToken.CORNER_RADIUS_8
        } as PopupIconOptions,
        title: {
          text: $r('app.string.title_en_label'),
          fontSize: $r('sys.float.Subtitle_M'),
          fontColor: $r('sys.color.font_primary'),
          fontWeight: FontWeight.Medium
        } as PopupTextOptions,
        message: {
          text: 'A'.repeat(50),
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_secondary'),
          fontWeight: FontWeight.Regular
        } as PopupTextOptions,
        showClose: true,
        onClose: () => {
          if (this.handlePopup5) {
            this.handlePopup5 = false;
          }
        },
        buttons: [{
          text: $r('app.string.confirm_en_label'),
          action: () => {
            Logger.info(TAG, 'Confirm button clicked');
          },
          fontSize: $r('sys.float.Body_M'),
          fontColor: $r('sys.color.font_emphasize')
        },
          {
            text: $r('app.string.cancel_en_label'),
            action: () => {
              Logger.info(TAG, 'Cancel button clicked');
            },
            fontSize: $r('sys.float.Body_M'),
            fontColor: $r('sys.color.font_emphasize')
          }] as [PopupButtonOptions?, PopupButtonOptions?]
      })
    }
  }

  build() {
    ListItemGroup({
      header: GroupHeader($r('app.string.basic_style_label'), undefined, $r('app.color.default_background_color'))
    }) {
      ListItem() {
        CommonListRow({
          title: $r('app.string.plain_text_label'),
          onClickAction: () => {
            this.handlePopup1 = !this.handlePopup1;
          }
        })
          .bindPopup(this.handlePopup1!!, {
            message: 'A'.repeat(25),
            placement: Placement.BottomLeft
          })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.text_close_button_label'),
          onClickAction: () => {
            this.handlePopup2 = !this.handlePopup2;
          }
        })
          .bindPopup(this.handlePopup2!!, {
            builder: this.PopupStyle2,
            placement: Placement.BottomLeft
          })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.title_text_close_button_label'),
          onClickAction: () => {
            this.handlePopup3 = !this.handlePopup3;
          }
        })
          .bindPopup(this.handlePopup3!!, {
            builder: this.PopupStyle3,
            placement: Placement.BottomLeft
          })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.title_text_close_button_action_label'),
          onClickAction: () => {
            this.handlePopup4 = !this.handlePopup4;
          }
        })
          .bindPopup(this.handlePopup4!!, {
            builder: this.PopupStyle4,
            placement: Placement.BottomLeft
          })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.icon_title_text_close_button_action_label'),
          onClickAction: () => {
            this.handlePopup5 = !this.handlePopup5;
          }
        })
          .bindPopup(this.handlePopup5!!, {
            builder: this.PopupStyle5,
            placement: Placement.BottomLeft
          })
      }
      .commonListItemStyles()
    }
    .divider({
      strokeWidth: SizeToken.SIZE_NUM_12,
      color: $r('sys.color.background_secondary'),
    })
  }
}