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

import { HdsNavigation, HdsNavigationTitleMode, ScrollEffectType } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { Logger } from 'componentuxexamplesbase';
import { BreakpointModel, ColorToken, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';

const TAG = 'EmphasizedTitle';

@ComponentV2
export struct EmphasizedTitle {
  @Provider('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @Local isHideBackButton: boolean = false;
  @Local titleMode: HdsNavigationTitleMode = HdsNavigationTitleMode.FREE;
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
      SubTitleView($r('app.string.emphasized_title_bar_label'), PaddingToken.PADDING_28VP)
      HdsNavigation(this.pageInfos)
        .titleBar({
          padding: {
            start: this.horizontalPaddingLength,
            end: this.horizontalPaddingLength
          },
          style: {
            scrollEffectOpts: {
              enableScrollEffect: true,
              scrollEffectType: ScrollEffectType.COMMON_BLUR,
              blurEffectiveStartOffset: LengthMetrics.vp(PaddingToken.PADDING_0VP),
              blurEffectiveEndOffset: LengthMetrics.vp(PaddingToken.PADDING_20VP)
            },
            originalStyle: {
              backgroundStyle: {
                backgroundColor: $r('sys.color.comp_background_list_card')
              },
              contentStyle: {
                titleStyle: {
                  mainTitleColor: $r('sys.color.font_primary'),
                  subTitleColor: $r('sys.color.font_secondary')
                },
                menuStyle: {
                  backgroundColor: $r('sys.color.comp_background_tertiary'),
                  iconColor: $r('sys.color.icon_primary')
                },
                backIconStyle: {
                  backgroundColor: $r('sys.color.comp_background_tertiary'),
                  iconColor: $r('sys.color.icon_primary')
                }
              }
            }, scrollEffectStyle: {
              backgroundStyle: {
                backgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              },
              contentStyle: {
                titleStyle: {
                  mainTitleColor: $r('sys.color.font_primary'),
                  subTitleColor: $r('sys.color.font_secondary')
                },
                menuStyle: {
                  backgroundColor: $r('sys.color.comp_background_tertiary'),
                  iconColor: $r('sys.color.icon_primary')
                },
                backIconStyle: {
                  backgroundColor: $r('sys.color.comp_background_tertiary'),
                  iconColor: $r('sys.color.icon_primary')
                }
              }
            }
          },
          content: {
            title: {
              mainTitle: $r('app.string.title_en_label'),
              subTitle: $r('app.string.double_line_title_icon_in_the_upper_right_corner_label')
            },
            menu: {
              value: [{
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.circle_dashed'),
                  isEnabled: true,
                  action: () => {
                    Logger.info(TAG, 'HdsNavigation menu1');
                  }
                }
              }, {
                content: {
                  label: 'menu2',
                  icon: $r('sys.symbol.circle_dashed'),
                  isEnabled: true
                }
              }, {
                content: {
                  label: 'menu3',
                  icon: $r('sys.symbol.circle_dashed')
                }
              }]
            },
            backIcon: {
              label: 'backButton',
              icon: $r('sys.symbol.trunk'),
              isEnabled: true
            }
          }
        })
        .systemBarStyle({ statusBarContentColor: ColorToken.EMPHASIZE_COLOR },
          { statusBarContentColor: ColorToken.LIGHT_GRAY_COLOR })
        .titleMode(this.titleMode)
        .hideBackButton(this.isHideBackButton)
        .hideTitleBar(false)
        .navBarWidth(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_NUM_137)

      SubTitleView($r('app.string.emphasized_title_single_line_without_icon_label'), PaddingToken.PADDING_28VP)
      HdsNavigation(this.pageInfos) {
      }
      .titleBar({
        padding: {
          start: this.horizontalPaddingLength,
          end: this.horizontalPaddingLength
        },
        style: {
          scrollEffectOpts: {
            enableScrollEffect: true,
            scrollEffectType: ScrollEffectType.COMMON_BLUR,
            blurEffectiveStartOffset: LengthMetrics.vp(PaddingToken.PADDING_0VP),
            blurEffectiveEndOffset: LengthMetrics.vp(PaddingToken.PADDING_20VP)
          },
          originalStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.comp_background_list_card')
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
              menuStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              },
              backIconStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              }
            }
          }, scrollEffectStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
              menuStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              },
              backIconStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              }
            }
          }
        },
        content: {
          title: {
            mainTitle: $r('app.string.title_en_label')
          },
          backIcon: {
            label: 'backButton',
            icon: $r('sys.symbol.trunk'),
            isEnabled: true
          }
        }
      })
      .systemBarStyle({ statusBarContentColor: ColorToken.EMPHASIZE_COLOR },
        { statusBarContentColor: ColorToken.LIGHT_GRAY_COLOR })
      .titleMode(this.titleMode)
      .hideBackButton(this.isHideBackButton)
      .hideTitleBar(false)
      .navBarWidth(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_NUM_110)
    }
  }
}