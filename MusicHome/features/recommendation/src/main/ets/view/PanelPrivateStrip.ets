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
import { RecommendPrivateSongUi } from '../model/RecommendUiModels';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';

/**
 * Panel variant of the private-songs strip (light-on-dark styling, three lanes).
 */
@ComponentV2
export struct PanelPrivateStrip {
  /** Shared recommendation view model with private song data source. */
  @Param recommendViewModel: RecommendViewModel = new RecommendViewModel();

  /**
   * Section title row for the panel private-songs block (non-interactive header).
   */
  @Builder
  private SectionHeader() {
    Row() {
      Row({ space: 8 }) {
        Text($r('app.string.home_private_songs_title'))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#e6ffffff')
          .lineHeight(22)
        Row() {
          Image($r('app.media.ic_pause_music'))
            .width(24)
            .height(24)
            .fillColor('#FF1949')
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16, bottom: 0 })
  }

  /**
   * One private-song row for the panel list; tap requests playback.
   *
   * @param item - Row model.
   */
  @Builder
  private PrivateSongListItem(item: RecommendPrivateSongUi) {
    Row({ space: 22 }) {
      Image(item.cover)
        .width(64)
        .height(64)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#e6ffffff')
          .maxLines(1)
          .lineHeight(21)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(item.singer)
          .fontSize(22)
          .fontColor('#99ffffff')
          .fontWeight(FontWeight.Regular)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor('#1affffff')
    .borderRadius(16)
    .borderWidth(1)
    .borderColor('#26ffffff')
    .onClick(() => {
      this.recommendViewModel.requestPlayBySongId(item.id);
    })
  }

  /**
   * Column with header and three-lane lazy list of private songs.
   */
  build() {
    Column({ space: 24 }) {
      this.SectionHeader()
      List({ space: 16 }) {
        LazyForEach(this.recommendViewModel.privateSongDataSource,
          (item: RecommendPrivateSongUi, index?: number) => {
            ListItem() {
              this.PrivateSongListItem(item);
            }
          }, (item: RecommendPrivateSongUi, index?: number) => (item).toString() + index)
      }
      .lanes(2, 32)
      .width(StyleConstants.FULL_WIDTH)
      .scrollBar(BarState.Off)
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding({ left: 56, right: 56 })
  }
}