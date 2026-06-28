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
import { HdsNavDestination, HdsNavDestinationTitleMode } from '@kit.UIDesignKit';
import { Logger, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';
import { TitleBarUtils } from '../common/TitleBarUtils';

const TAG = 'DrawerTitle';

@Builder
export function DrawerTitle() {
  Column() {
    SubTitleView($r('app.string.drawer_single_line_title_bar_label'), PaddingToken.PADDING_28VP)
    HdsNavDestination() {
    }
    .height(SizeToken.SIZE_NUM_56)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .titleMode(HdsNavDestinationTitleMode.MINI)
    .hideBackButton(true)
    .titleBar({
      padding: TitleBarUtils.COMMON_PADDING,
      content: {
        title: { mainTitle: $r('app.string.title_en_label') },
        menu: {
          value: [{
            content: {
              label: 'menu1',
              icon: $r('sys.symbol.square_dashed'),
              isEnabled: true,
              action: () => Logger.info(TAG, 'HdsNavDestination menu1')
            }
          }]
        },
        subIcon: {
          content: {
            label: 'subIcon',
            icon: $r('sys.symbol.close_sidebar'),
            isEnabled: true,
            action: () => Logger.info(TAG, 'HdsNavDestination subIcon')
          }
        }
      }
    })

    SubTitleView($r('app.string.drawer_double_line_title_bar_label'), PaddingToken.PADDING_28VP)
    HdsNavDestination() {
    }
    .height(SizeToken.SIZE_NUM_56)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .titleMode(HdsNavDestinationTitleMode.MINI)
    .hideBackButton(true)
    .titleBar({
      padding: TitleBarUtils.COMMON_PADDING,
      content: {
        title: {
          mainTitle: $r('app.string.title_en_label'),
          subTitle: $r('app.string.subtitle_en_label')
        },
        menu: {
          value: [{
            content: {
              label: 'menu1',
              icon: $r('sys.symbol.square_dashed'),
              isEnabled: true,
              action: () => Logger.info(TAG, 'HdsNavDestination menu1')
            }
          }]
        },
        subIcon: {
          content: {
            label: 'subIcon',
            icon: $r('sys.symbol.close_sidebar'),
            isEnabled: true,
            action: () => Logger.info(TAG, 'HdsNavDestination subIcon')
          }
        }
      }
    })
  }
}