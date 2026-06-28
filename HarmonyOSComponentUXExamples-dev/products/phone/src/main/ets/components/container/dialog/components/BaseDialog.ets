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
import { CustomContentDialog } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { CommonListRow, CornerRadiusToken, SizeToken, SubTitleView as GroupHeader } from 'componentuxexamplesbase';

const TAG = 'BaseDialog';

@ComponentV2
export struct BaseDialog {
  // Dialog controller
  private basicDialogController: CustomDialogController | undefined = undefined;
  private doubleTitleDialogController: CustomDialogController | undefined = undefined;
  private threeButtonDialogController: CustomDialogController | undefined = undefined;

  @Builder
  buildContent(): void {
    Column() {
      Text($r('app.string.content_label'))
        .fontColor($r('sys.color.font_emphasize'))
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.dialog_content_background_color'))
  }

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

  aboutToAppear(): void {
    this.basicDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              Logger.info(TAG, 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL
          }
        ]
      })
    });
    this.doubleTitleDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        secondaryTitle: 'Auxiliary Text',
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              Logger.info(TAG, 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL
          }
        ]
      })
    });
    this.threeButtonDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.EMPHASIZED,
            action: () => {
              Logger.info(TAG, 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
          }
        ]
      })
    });
  }

  build() {
    ListItemGroup({
      header: GroupHeader($r('app.string.basic_composition_label'), undefined,
        $r('app.color.default_background_color'))
    }) {
      ListItem() {
        CommonListRow({
          title: $r('app.string.basic_components_of_dialog_label'),
          onClickAction: () => {
            this.basicDialogController?.open();
          }
        })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.double_line_title_dialog_label'),
          onClickAction: () => {
            this.doubleTitleDialogController?.open();
          }
        })
      }
      .commonListItemStyles()

      ListItem() {
        CommonListRow({
          title: $r('app.string.three_line_button_dialog_label'),
          onClickAction: () => {
            this.threeButtonDialogController?.open();
          }
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