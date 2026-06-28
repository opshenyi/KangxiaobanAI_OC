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
import { PlaylistSongUi } from '../model/PlaylistUiModels';
import { MusicListPlaybackViewModel } from '../viewmodel/MusicListPlaybackViewModel';

/**
 * Playlist song list with play-all header, lazy list, and nested scroll behavior for detail page.
 */
@ComponentV2
export struct PlaylistDetailSongListSection {
  /** Current window breakpoint for horizontal padding and lane count. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Window info for bottom padding under immersive mini bar. */
  @Local windowInfo: WindowInfo = getWindowInfoState();
  /** View model supplying songs and play-by-index actions. */
  @Param listVm: MusicListPlaybackViewModel = new MusicListPlaybackViewModel();
  /** List vertical scroller instance bound to the LazyForEach list. */
  private scroller: Scroller = new Scroller();

  /**
   * Builds a single playlist row: metadata, tags, overflow affordance, and tap-to-play.
   * @param item Song UI model for the row.
   * @param index Zero-based index in the playlist for playback requests.
   */
  @Builder
  private PlaylistSongRow(item: PlaylistSongUi, index: number) {
    Row({ space: 8 }) {
      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.playlist_detail_song_title'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Row({ space: 6 }) {
          Text('VIP')
            .fontSize(10)
            .lineHeight(13)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.playlist_detail_tag_text'))
            .padding({
              left: 4,
              right: 4,
              top: 1,
              bottom: 1
            })
            .backgroundColor($r('app.color.playlist_detail_tag_background'))
            .borderRadius(4)
          Text($r('app.string.playlist_tag_spatial'))
            .fontSize(9)
            .fontColor($r('app.color.playlist_detail_tag_text'))
            .padding({
              left: 4,
              right: 4,
              top: 1,
              bottom: 1
            })
            .backgroundColor($r('app.color.playlist_detail_tag_background'))
            .borderRadius(4)
          Text(item.singer)
            .fontSize(12)
            .lineHeight(16)
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.primary40'))
            .maxLines(1)
            .layoutWeight(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.ic_list_more'))
        .width(18)
        .height(18)
        .opacity(0.45)
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding({
      top: 10,
      bottom: 10,
    })
    .onClick(() => {
      this.listVm.requestPlayByListIndex(index);
    })
  }

  /**
   * Builds header, sort affordance, and multi-lane lazy list of songs.
   */
  build() {
    Column() {
      Row() {
        Row({ space: 8 }) {
          SymbolGlyph($r('sys.symbol.play_round_triangle_fill'))
            .fontSize(32)
            .fontWeight(FontWeight.Regular)
            .height(32)
            .fontColor([$r('app.color.playlist_play_all_icon')])
          Text($r('app.string.playlist_play_all'))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .lineHeight(24)
            .fontColor($r('app.color.mini_bar_primary'))
          Text(`${this.listVm.playlistSongUis.length}`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .lineHeight(24)
            .fontColor($r('app.color.mini_bar_primary'))
        }

        Blank()
        SymbolGlyph($r('sys.symbol.list_checkmask'))
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .height(20)
          .fontColor([$r('app.color.primary40')])
      }
      .width(StyleConstants.FULL_WIDTH)
      .padding({
        left: new BreakpointType(16, 24, 0, 0).getValue(this.breakpointEnv.widthBreakpoint),
        right: new BreakpointType(16, 24, 32, 32).getValue(this.breakpointEnv.widthBreakpoint),
        top: new BreakpointType(8, 8, 16, 16).getValue(this.breakpointEnv.widthBreakpoint)
      })

      List({ scroller: this.scroller }) {
        LazyForEach(this.listVm.songListDataSource, (item: PlaylistSongUi, index: number) => {
          ListItem() {
            this.PlaylistSongRow(item, index);
          }
        }, (item: PlaylistSongUi, index?: number) => `pl-${index}-${item.id}`)
      }
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .lanes(new BreakpointType(1, 2, 2, 2).getValue(this.breakpointEnv.widthBreakpoint), 32)
      .width(StyleConstants.FULL_WIDTH)
      .scrollBar(BarState.Off)
      .padding({
        left: new BreakpointType(16, 24, 0, 0).getValue(this.breakpointEnv.widthBreakpoint),
        right: new BreakpointType(16, 24, 32, 32).getValue(this.breakpointEnv.widthBreakpoint),
        bottom: this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 48 : 104
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }
}
