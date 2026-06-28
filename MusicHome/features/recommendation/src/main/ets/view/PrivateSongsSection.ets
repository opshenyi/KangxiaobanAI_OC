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
import { BreakpointType, RouterUrlConstants, StyleConstants } from 'musicbasic';
import { RecommendPrivateSongUi } from '../model/RecommendUiModels';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';

/**
 * Home “private songs�?section: header navigates to playlist detail; grid list plays on row tap.
 */
@ComponentV2
export struct PrivateSongsSection {
  /** Responsive column lane count from system breakpoint env. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Recommendation VM supplying the lazy list data source for private songs. */
  @Param recommendViewModel: RecommendViewModel = new RecommendViewModel();
  /** Nav stack for routing to playlist detail on header tap. */
  @Consumer('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();

  private homeScrollGutterH(): number {
    return new BreakpointType(16, 24, 32, 32).getValue(this.breakpointEnv.widthBreakpoint);
  }

  /**
   * Row header with title, badge, and chevron; tap replaces route with playlist detail.
   */
  @Builder
  private SectionHeader() {
    Row() {
      Row({ space: 8 }) {
        Text($r('app.string.home_private_songs_title'))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.font_primary'))
          .lineHeight(22)
        Row() {
          Image($r('app.media.ic_pause_music'))
            .width(24)
            .height(24)
            .fillColor($r('app.color.private_song_like_color'))
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
      }

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize(24)
        .fontWeight(FontWeight.Regular)
        .height(24)
        .fontColor(['#66000000'])
    }
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16, bottom: 12 })
    .onClick(() => {
      this.pageIndexInfos.replacePathByName(RouterUrlConstants.PLAYLIST_DETAIL, null);
    })
  }

  /**
   * Single private-song row: cover, title, singer; tap requests play by song id.
   *
   * @param item - Row model from the data source.
   */
  @Builder
  private PrivateSongListItem(item: RecommendPrivateSongUi) {
    Row({ space: 10 }) {
      Image(item.cover)
        .width(48)
        .height(48)
        .borderRadius(4)
        .objectFit(ImageFit.Cover)
      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.font_primary'))
          .maxLines(1)
          .lineHeight(21)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(item.singer)
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
          .fontWeight(FontWeight.Regular)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(72)
    .padding({ top: 12, bottom: 12 })
    .onClick(() => {
      this.recommendViewModel.requestPlayBySongId(item.id);
    })
  }

  /**
   * Column with header and multi-lane lazy-for-each list of private songs.
   */
  build() {
    Column() {
      this.SectionHeader()
      List() {
        LazyForEach(this.recommendViewModel.privateSongDataSource,
          (item: RecommendPrivateSongUi, index?: number) => {
            ListItem() {
              this.PrivateSongListItem(item);
            }
          }, (item: RecommendPrivateSongUi, index?: number) => (item).toString() + index)
      }
      .lanes(new BreakpointType(1, 2, 3, 3).getValue(this.breakpointEnv.widthBreakpoint))
      .width(StyleConstants.FULL_WIDTH)
      .scrollBar(BarState.Off)
      .padding({
        bottom: 62
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding({ left: this.homeScrollGutterH(), right: this.homeScrollGutterH() })
  }
}
