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
import { LengthMetrics } from '@kit.ArkUI';
import { HdsNavDestination, HdsNavDestinationTitleMode } from '@kit.UIDesignKit';
import { Logger } from 'componentuxexamplesbase';
import { BreakpointModel, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'DrawerTitle';

@ComponentV2
export struct DrawerTitle {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  // Dedicated LengthMetrics margins for NavDestination titles
  @Computed
  get horizontalPaddingLength(): LengthMetrics {
    return LengthMetrics.vp(this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }));
  }

  build() {
    Column() {
      SubTitleView($r('app.string.drawer_style_single_line_title_bar_label'), PaddingToken.PADDING_28VP)

      HdsNavDestination()
        .height(SizeToken.SIZE_NUM_56)
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .titleMode(HdsNavDestinationTitleMode.MINI)
        .titleBar({
          padding: {
            start: this.horizontalPaddingLength,
            end: this.horizontalPaddingLength
          },
          content: {
            title: {
              mainTitle: $r('app.string.title_en_label')
            },
            menu: {
              value: [{
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.circle_dashed'),
                  isEnabled: true,
                  action: () => {
                    Logger.info(TAG, 'HdsNavDestination menu1');
                  }
                }
              }]
            },
            subIcon: {
              content: {
                label: 'subIcon',
                icon: $r('sys.symbol.close_sidebar'),
                isEnabled: true,
                action: () => {
                  Logger.info(TAG, 'HdsNavDestination subIcon');
                }
              }
            }
          }
        })
        .hideBackButton(true)

      SubTitleView($r('app.string.drawer_style_multi_line_title_bar_label'), PaddingToken.PADDING_28VP)

      HdsNavDestination()
        .height(SizeToken.SIZE_NUM_56)
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .titleMode(HdsNavDestinationTitleMode.MINI)
        .titleBar({
          padding: {
            start: this.horizontalPaddingLength,
            end: this.horizontalPaddingLength
          },
          content: {
            title: {
              mainTitle: $r('app.string.title_en_label'),
              subTitle: $r('app.string.subtitle_en_label')
            },
            menu: {
              value: [{
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.circle_dashed'),
                  isEnabled: true,
                  action: () => {
                    Logger.info(TAG, 'HdsNavDestination menu1');
                  }
                }
              }]
            },
            subIcon: {
              content: {
                label: 'subIcon',
                icon: $r('sys.symbol.close_sidebar'),
                isEnabled: true,
                action: () => {
                  Logger.info(TAG, 'HdsNavDestination subIcon');
                }
              }
            }
          }
        })
        .hideBackButton(true)
    }
  }
}