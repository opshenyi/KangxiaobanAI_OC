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

import { uiObserver } from '@kit.ArkUI';
import {
  BreakpointType,
  getWindowInfoState,
  ImmersiveType,
  RouterUrlConstants,
  StyleConstants,
  WindowInfo
} from 'musicbasic';
import { RecommendCardUi } from '../model/RecommendUiModels';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';

/**
 * Phone “For you�?section: tappable header opens playlist detail; horizontal cards scale by breakpoint.
 */
@ComponentV2
export struct ForYouSection {
  /** Breakpoint env for card widths and typography. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Recommendation VM providing the “For you�?playlist card list. */
  @Param recommendViewModel: RecommendViewModel = new RecommendViewModel();
  /** Nav stack used when the section header navigates to playlist detail. */
  @Consumer('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  /** Title bar insets, immersive decor, and related window metrics. */
  @Local windowInfo: WindowInfo = getWindowInfoState();

  private homeScrollGutterH(): number {
    return new BreakpointType(16, 24, 32, 32).getValue(this.breakpointEnv.widthBreakpoint);
  }

  /**
   * Title row with chevron; whole row navigates to the playlist detail route name.
   */
  @Builder
  private SectionHeader() {
    Row() {
      Text($r('app.string.home_for_you_title'))
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.font_primary'))
      Blank()
      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize(24)
        .fontWeight(FontWeight.Regular)
        .height(24)
        .fontColor([$r('app.color.font_tertiary')])
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding({
      left: this.homeScrollGutterH(),
      right: this.homeScrollGutterH(),
      top: 10,
      bottom: 10
    })
    .onClick(() => {
      this.pageIndexInfos.replacePathByName(RouterUrlConstants.PLAYLIST_DETAIL, null);
    })
  }

  /**
   * One “For you�?playlist card sized from the current width breakpoint env.
   *
   * @param recommendCard - Card UI model.
   */
  @Builder
  private RecommendCard(recommendCard: RecommendCardUi) {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image(recommendCard.backgroundImage)
          .width(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 119 :
            new BreakpointType(131, 148, 189, 189).getValue(this.breakpointEnv.widthBreakpoint))
          .aspectRatio(1)
          .borderRadius(8)
          .objectFit(ImageFit.Fill)

        Row({ space: 6 }) {
          SymbolGlyph($r('sys.symbol.play_round_triangle_fill'))
            .fontSize(20)
            .fontWeight(FontWeight.Regular)
            .height(20)
            .fontColor(['#ffffff'])
          Text(recommendCard.playCountLabel)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .lineHeight(13)
            .fontColor($r('sys.color.comp_background_list_card'))
        }
        .padding(4)
      }
      .clip(true)

      Text(recommendCard.title)
        .fontSize(14)
        .fontColor('#e6000000')
        .maxLines(2)
        .lineHeight(19)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 4 })
        .width(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 119 :
          new BreakpointType(131, 148, 189, 189).getValue(this.breakpointEnv.widthBreakpoint))
    }
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * Column with header and horizontal scroller of recommendation cards.
   */
  build() {
    Column() {
      this.SectionHeader()
      Scroll() {
        Row({ space: new BreakpointType(8, 12, 16, 16).getValue(this.breakpointEnv.widthBreakpoint) }) {
          ForEach(this.recommendViewModel.recommendItems, (recommendCard: RecommendCardUi, index?: number) => {
            Column() {
              this.RecommendCard(recommendCard);
            }
          }, (_recommendCard: RecommendCardUi, index?: number) => `rec-${index}`)
        }
        .padding({ left: this.homeScrollGutterH(), right: this.homeScrollGutterH() })
        .alignItems(VerticalAlign.Top)
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Horizontal)
      .width(StyleConstants.FULL_WIDTH)
      .align(Alignment.Start)
    }
    .width(StyleConstants.FULL_WIDTH)
  }
}
