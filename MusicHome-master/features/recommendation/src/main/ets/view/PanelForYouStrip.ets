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


import { StyleConstants } from 'musicbasic';
import { RecommendCardUi } from '../model/RecommendUiModels';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';

/**
 * Panel �For you�?horizontal strip: fixed card width, spacing constants, and light-on-dark card chrome.
 */
@ComponentV2
export struct PanelForYouStrip {
  /** Shared recommendation data for playlist cards. */
  @Param recommendViewModel: RecommendViewModel = new RecommendViewModel();
  private recommendScroller: Scroller = new Scroller();

  /**
   * Panel-styled section title row for �For you�?
   */
  @Builder
  private SectionHeader() {
    Row() {
      Text($r('app.string.home_for_you_title'))
        .fontSize(26)
        .lineHeight(35)
        .fontWeight(FontWeight.Bold)
        .fontColor('#e6ffffff')
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding({
      left: 56,
      right: 56,
      top: 10,
      bottom: 0
    })
  }

  /**
   * One playlist-style card with cover, play-count pill, and title for the panel strip.
   *
   * @param recommendCard - Card UI model.
   */
  @Builder
  private RecommendCard(recommendCard: RecommendCardUi) {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image(recommendCard.backgroundImage)
          .width(208)
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
      .width(208)
      .clip(true)

      Text(recommendCard.title)
        .fontSize(22)
        .fontColor('#e6ffffff')
        .maxLines(2)
        .lineHeight(29)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 4 })
        .width(208)
    }
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * Column with header and horizontal scroll of recommendation card builder items.
   */
  build() {
    Column({ space: 24 }) {
      this.SectionHeader()
      Scroll(this.recommendScroller) {
        Row({ space: 32 }) {
          ForEach(this.recommendViewModel.recommendItems, (recommendCard: RecommendCardUi, index?: number) => {
            Column() {
              this.RecommendCard(recommendCard);
            }
          }, (_recommendCard: RecommendCardUi, index?: number) => `panel-rec-${index}`)
        }
        .padding({ left: 56, right: 56 })
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Horizontal)
      .width(StyleConstants.FULL_WIDTH)
    }
    .width(StyleConstants.FULL_WIDTH)
  }
}

