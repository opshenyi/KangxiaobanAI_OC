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

import { HdsNavigation, HdsNavigationTitleMode } from '@kit.UIDesignKit';
import { ColorToken, Logger, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';
import { TitleBarUtils } from '../common/TitleBarUtils';

const TAG = 'EmphasizedTitle';

@ComponentV2
export struct EmphasizedTitle {
  @Provider('pageInfos1') pageInfos1: NavPathStack = new NavPathStack();
  @Provider('pageInfos2') pageInfos2: NavPathStack = new NavPathStack();
  @Local mainTitle1: ResourceStr = $r('app.string.title_en_label');
  @Local subTitle1: ResourceStr = $r('app.string.subtitle_en_label');
  @Local mainTitle2: ResourceStr = $r('app.string.title_en_label');

  build() {
    Column() {
      SubTitleView($r('app.string.emphasized_double_line_title_bar_label'), PaddingToken.PADDING_36VP)
      HdsNavigation(this.pageInfos1) {
      }
      .titleBar({
        padding: TitleBarUtils.COMMON_PADDING,
        // Using common style with transparent background enabled
        style: TitleBarUtils.getCommonStyleOpts(true),
        content: {
          title: {
            mainTitle: this.mainTitle1,
            subTitle: this.subTitle1
          },
          menu: {
            value: [
              {
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavigation menu1')
                }
              },
              {
                content: {
                  label: 'menu2',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavigation menu2')
                }
              },
              {
                content: {
                  label: 'menu3',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavigation menu3')
                }
              }
            ]
          },
          backIcon: {
            label: 'backButton',
            icon: $r('sys.symbol.square_dashed'),
            isEnabled: true
          }
        }
      })
      .systemBarStyle(
        { statusBarContentColor: ColorToken.EMPHASIZE_COLOR },
        { statusBarContentColor: ColorToken.LIGHT_GRAY_COLOR }
      )
      .titleMode(HdsNavigationTitleMode.FREE)
      .hideBackButton(false)
      .hideTitleBar(false)
      .navBarWidth(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_138)

      SubTitleView($r('app.string.emphasized_single_line_title_bar_label'), PaddingToken.PADDING_36VP)
      HdsNavigation(this.pageInfos2) {
      }
      .titleBar({
        padding: TitleBarUtils.COMMON_PADDING,
        style: TitleBarUtils.getCommonStyleOpts(true),
        content: {
          title: { mainTitle: this.mainTitle2 },
          menu: {
            value: [
              {
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavigation menu1')
                }
              },
              { content: { label: 'menu2', icon: $r('sys.symbol.square_dashed'), isEnabled: true } },
              { content: { label: 'menu3', icon: $r('sys.symbol.square_dashed') } }
            ]
          },
          backIcon: {
            label: 'backButton',
            icon: $r('sys.symbol.square_dashed'),
            isEnabled: true
          }
        }
      })
      .systemBarStyle(
        { statusBarContentColor: ColorToken.EMPHASIZE_COLOR },
        { statusBarContentColor: ColorToken.LIGHT_GRAY_COLOR }
      )
      .titleMode(HdsNavigationTitleMode.FREE)
      .hideBackButton(false)
      .hideTitleBar(false)
      .navBarWidth(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_112)
    }
  }
}