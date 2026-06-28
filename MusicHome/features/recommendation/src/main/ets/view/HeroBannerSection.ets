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
import { BreakpointType, getWindowInfoState, ImmersiveType, StyleConstants, WindowInfo } from 'musicbasic';
import { RecommendHeroCardUi } from '../model/RecommendUiModels';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';

/**
 * Responsive horizontal hero banner carousel for the phone recommendation home.
 */
@ComponentV2
export struct HeroBannerSection {
  /** Breakpoint env for card width/height and inter-card spacing. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** VM providing hero banner card data for the carousel. */
  @Param recommendViewModel: RecommendViewModel = new RecommendViewModel();
  /** Title bar insets, immersive decor, and related window metrics. */
  @Local windowInfo: WindowInfo = getWindowInfoState();

  private homeScrollGutterH(): number {
    return new BreakpointType(16, 24, 32, 32).getValue(this.breakpointEnv.widthBreakpoint);
  }

  /**
   * Single full-bleed hero card with badge, title stack, and decorative play icon.
   *
   * @param item - Hero card UI model.
   */
  @Builder
  private HeroBannerCard(item: RecommendHeroCardUi) {
    Stack() {
      Image(item.coverImage)
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)
        .objectFit(ImageFit.Fill)

      Column() {
        Row({ space: 4 }) {
          Image($r('app.media.ic_music_symbol'))
            .width(14)
            .height(14)
            .fillColor('#FFFFFF')
          Text(item.badge)
            .fontSize(12)
            .lineHeight(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .padding(12)
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Row() {
          Column({ space: 4 }) {
            Text(item.title)
              .fontSize(20)
              .fontColor('#e6ffffff')
              .fontWeight(FontWeight.Bold)
              .lineHeight(27)
            Text(item.subLine)
              .fontSize(12)
              .fontColor('#99ffffff')
              .maxLines(1)
              .lineHeight(16)
              .fontWeight(FontWeight.Regular)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          SymbolGlyph($r('sys.symbol.play_round_triangle_fill'))
            .fontSize(36)
            .fontWeight(FontWeight.Regular)
            .height(36)
            .fontColor(['#e6ffffff'])
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#26000000')
        .backgroundBlurStyle(BlurStyle.BACKGROUND_ULTRA_THICK)
        .padding(12)
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 187 :
      new BreakpointType(223, 223, 292, 292, 203).getWidthValueWithHeightSM(this.breakpointEnv.widthBreakpoint,
        this.breakpointEnv.heightBreakpoint))
    .height(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 234 :
      new BreakpointType(280, 280, 365, 365, 186).getWidthValueWithHeightSM(this.breakpointEnv.widthBreakpoint,
        this.breakpointEnv.heightBreakpoint))
    .clip(true)
    .borderRadius(20)
  }

  /**
   * Horizontal scroll of hero cards driven by the view model hero list.
   */
  build() {
    Scroll() {
      Row({ space: new BreakpointType(8, 12, 16, 16).getValue(this.breakpointEnv.widthBreakpoint) }) {
        ForEach(this.recommendViewModel.heroCards, (item: RecommendHeroCardUi, index?: number) => {
          Column() {
            this.HeroBannerCard(item);
          }
        }, (_item: RecommendHeroCardUi, index?: number) => `hero-${index}`)
      }
      .padding({ left: this.homeScrollGutterH(), right: this.homeScrollGutterH() })
    }
    .scrollBar(BarState.Off)
    .scrollable(ScrollDirection.Horizontal)
    .width(StyleConstants.FULL_WIDTH)
    .align(this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? Alignment.Start : Alignment.Center)
  }
}
