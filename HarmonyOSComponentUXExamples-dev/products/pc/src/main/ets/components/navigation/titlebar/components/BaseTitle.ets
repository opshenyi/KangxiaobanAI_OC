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
import { SegmentButtonV2Items, TabSegmentButtonV2 } from '@kit.ArkUI';
import { util } from '@kit.ArkTS';
import { HdsNavDestination, HdsNavDestinationTitleMode } from '@kit.UIDesignKit';
import { CornerRadiusToken, Logger, PaddingToken, SizeToken, SubTitleView } from 'componentuxexamplesbase';
import { TitleBarUtils } from '../common/TitleBarUtils';

const TAG = 'BaseTitle';

interface ImageInfoInterface {
  id?: string;
  res: Resource;
}

@ObservedV2
class ImageItemModel {
  public readonly id: string;
  @Trace public res: Resource;

  constructor(param: ImageInfoInterface) {
    this.id = param.id ?? util.generateRandomUUID(true);
    this.res = param.res;
  }
}

@ComponentV2
export struct BaseTitle {
  @Local textItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') },
    { text: $r('app.string.tabs_en_label') }
  ]);
  @Local textSelectedIndex: number = 1;
  @Local imageArrays: ImageItemModel[] = [
    new ImageItemModel({ id: 'xiaoyi', res: $r('app.media.xiaoyi') }),
    new ImageItemModel({ res: $r('sys.symbol.square_dashed') }),
    new ImageItemModel({ res: $r('sys.symbol.square_dashed') }),
    new ImageItemModel({ res: $r('sys.symbol.square_dashed') }),
    new ImageItemModel({ res: $r('sys.symbol.square_dashed') }),
    new ImageItemModel({ res: $r('sys.symbol.square_dashed') })
  ];

  @Builder
  StackBuilder1() {
    Row() {
      TabSegmentButtonV2({
        items: this.textItems,
        selectedIndex: this.textSelectedIndex!!,
      })
    }
    .width(SizeToken.SIZE_NUM_324)
    .height(SizeToken.SIZE_NUM_40)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  StackBuilder2() {
    Row() {
      ForEach(this.imageArrays, (item: ImageItemModel) => {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          if (item.id === 'xiaoyi') {
            Image(item.res)
              .width(SizeToken.SIZE_NUM_24)
              .height(SizeToken.SIZE_NUM_24)
          } else {
            SymbolGlyph(item.res)
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_primary')])
          }
        }
        .backgroundColor(Color.Transparent)
        .width(SizeToken.SIZE_NUM_40)
        .height(SizeToken.SIZE_NUM_40)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
      }, (item: ImageItemModel) => item.id)
    }
    .height(SizeToken.SIZE_NUM_40)
    .justifyContent(FlexAlign.Center)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
    .backgroundColor($r('sys.color.comp_background_tertiary'))
    .padding({
      left: PaddingToken.PADDING_8VP,
      right: PaddingToken.PADDING_8VP
    })
  }

  build() {
    Column() {
      SubTitleView($r('app.string.regular_single_line_title_bar_label'), PaddingToken.PADDING_28VP)
      HdsNavDestination() {
      }
      .height(SizeToken.SIZE_NUM_56)
      .hideBackButton(true)
      .titleBar({
        padding: TitleBarUtils.COMMON_PADDING,
        style: TitleBarUtils.getCommonStyleOpts(false),
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
          }
        }
      })

      SubTitleView($r('app.string.regular_double_line_title_bar_label'), PaddingToken.PADDING_28VP)
      HdsNavDestination() {
      }
      .height(SizeToken.SIZE_NUM_56)
      .hideBackButton(true)
      .titleBar({
        padding: TitleBarUtils.COMMON_PADDING,
        style: TitleBarUtils.getCommonStyleOpts(false),
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
          }
        }
      })

      SubTitleView($r('app.string.regular_title_bar_and_segment_buttons_in_the_middle_label'),
        PaddingToken.PADDING_28VP)
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
          stackBuilder: (): void => this.StackBuilder1(),
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.square_dashed'),
                isEnabled: true,
                action: () => Logger.info(TAG, 'HdsNavDestination menu1')
              }
            }, {
              content: {
                label: 'menu2',
                icon: $r('sys.symbol.square_dashed'),
                isEnabled: true,
                action: () => Logger.info(TAG, 'HdsNavDestination menu2')
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

      SubTitleView($r('app.string.regular_title_bar_and_toolbar_in_the_middle_label'), PaddingToken.PADDING_28VP)
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
          stackBuilder: (): void => this.StackBuilder2(),
          menu: {
            value: [
              {
                content: {
                  label: 'menu1',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavDestination menu1')
                }
              },
              {
                content: {
                  label: 'menu2',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavDestination menu2')
                }
              },
              {
                content: {
                  label: 'menu3',
                  icon: $r('sys.symbol.square_dashed'),
                  isEnabled: true,
                  action: () => Logger.info(TAG, 'HdsNavDestination menu3')
                }
              }
            ]
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
}