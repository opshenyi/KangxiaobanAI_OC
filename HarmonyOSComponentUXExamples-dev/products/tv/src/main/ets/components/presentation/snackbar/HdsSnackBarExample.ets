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
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarOperationType,
  SnackBarStyleOptions
} from '@kit.UIDesignKit'
import { CommonConstants, CommonUtils, SpaceToken } from 'componentuxexamplesbase'
import { CommonItem } from '../../common/CommonItem'
import { ListGroupTitle } from '../../common/ListGroupTitle'
import { SubNavigationTitle } from '../../common/SubNavTitle'

@Builder
export function HdsSnackBarExampleBuilder() {
  HdsSnackBarExample()
}

@ComponentV2
struct HdsSnackBarExample {
  private uiContext: UIContext = this.getUIContext();
  private hdsSnackBar: HdsSnackBar = new HdsSnackBar(this.uiContext);
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
  };
  private onlyTitleMessage: SnackBarMessageOptions = {
    title: $r('app.string.title_label')
  };
  private titleWithContentMessage: SnackBarMessageOptions = {
    title: $r('app.string.title_label'),
    content: $r('app.string.snackbar_content_label')
  };
  private operationWithClose: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_CLOSE,
    content: $r('app.string.text_button_label'),
    textButtonId: 'snackBarTextButton',
    onContentClick: () => {
      CommonUtils.showToast($r('app.string.toast_content_button_clicked_label'));
    },
    onCloseButtonClick: () => {
      CommonUtils.showToast($r('app.string.toast_close_clicked_label'));
    }
  };
  private operationWithArrow: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_ARROW,
    content: $r('app.string.text_button_label'),
    textButtonId: 'snackBarTextButton',
    onArrowClick: () => {
      CommonUtils.showToast($r('app.string.toast_arrow_clicked_label'));
    }
  };
  private style: SnackBarStyleOptions = {
    duration: CommonConstants.DURATION_2500
  };

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.type_label'))
          Column({ space: SpaceToken.SPACE_16 }) {
            CommonItem({ val: $r('app.string.snackbar_with_close_label') })
              .onClick(() => {
                this.hdsSnackBar.show(this.icon, this.onlyTitleMessage, this.operationWithClose, this.style);
              })
            CommonItem({ val: $r('app.string.snackbar_with_arrow_label') })
              .onClick(() => {
                this.hdsSnackBar.show(this.icon, this.onlyTitleMessage, this.operationWithArrow, this.style);
              })
            CommonItem({ val: $r('app.string.snackbar_with_text_label') })
              .onClick(() => {
                this.hdsSnackBar.show(this.icon, this.titleWithContentMessage, this.operationWithClose, this.style);
              })
          }
        }
      }
      .height('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.snackbar_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}