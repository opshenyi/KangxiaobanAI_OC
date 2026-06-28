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
import { ActionBarButton, ActionBarStyle, HdsActionBar } from '@kit.UIDesignKit';
import { CommonUtils, PaddingToken, SizeToken } from 'componentuxexamplesbase';

@ComponentV2
export struct VerticalActionBar {
  @Local isExpand: boolean = true;
  @Local isPrimaryIconChanged: boolean = false;
  @Local startButtonArray: ActionBarButton[] = [];

  aboutToAppear(): void {
    this.startButtonArray = [
      new ActionBarButton({
        baseIcon: $r('sys.symbol.AI_pencil'),
        onClick: () => {
          CommonUtils.showToast('The pencil button has been clicked currently.');
        }
      }),
      new ActionBarButton({
        baseIcon: $r('sys.symbol.ballpointpen_tip_crop_circle'),
        onClick: () => {
          CommonUtils.showToast('The ballpoint pen button has been clicked currently.');
        }
      }),
      new ActionBarButton({
        baseIcon: $r('sys.symbol.character_textbox'),
        onClick: () => {
          CommonUtils.showToast('The character textbox button has been clicked currently.');
        }
      }),
      new ActionBarButton({
        baseIcon: $r('sys.symbol.character_arrow_2_circlepath'),
        onClick: () => {
          CommonUtils.showToast('The edit button has been clicked currently.');
        }
      })];
  }

  build() {
    Row() {
      HdsActionBar({
        startButtons: this.startButtonArray,
        primaryButton: new ActionBarButton({
          baseIcon: $r('sys.symbol.xmark'),
          altIcon: $r('sys.symbol.plus'),
          onClick: () => {
            this.isExpand = !this.isExpand;
            this.isPrimaryIconChanged = !this.isPrimaryIconChanged;
          }
        }),
        actionBarStyle: new ActionBarStyle({
          isPrimaryIconChanged: this.isPrimaryIconChanged,
          isHorizontal: false
        }),
        isExpand: this.isExpand!!
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .justifyContent(FlexAlign.End)
    .alignItems(VerticalAlign.Center)
    .padding({ bottom: PaddingToken.PADDING_36VP })
  }
}