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

import { AppStorageV2, uiObserver } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import {
  AppStorageKeys,
  BreakpointConstants,
  BreakpointType,
  getAppRuntime,
  isWidthBreakpointLgOrXl,
  Logger,
  StyleConstants
} from 'musicbasic';
import { MusicAppState } from '../model/PlayerModels';
import { LrcEntry } from '../model/LrcEntry';
import { parseKrcLyric, parseLrcLyric } from '../util/LrcUtils';
import LrcView from './LrcView';
import { LyricScrollEffect, LyricTopPosition } from '../constant/LyricConst';
import { ControlAreaComponent } from './ControlAreaComponent';
import { LyricFile } from '../constant/LyricConst';
import { PlayerConstants } from '../constant/PlayerConstants';

const TAG = 'LyricsComponent';

/** Lyric panel: loads LRC/KRC from raw files, hosts LrcView, and optional ControlAreaComponent. */
@ComponentV2
export struct LyricsComponent {
  /** Window breakpoint for responsive lyric layout. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Shared playback state (track, progress). */
  @Local state: MusicAppState =
    AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
  /** When true, shows transport controls under lyrics (tablet / wide layouts). */
  @Param isShowControl: boolean = false;
  /** Tablet-style spacing flag passed to child layout. */
  @Param isTablet: boolean = false;
  /** Hides title/artist header above lyrics when embedded in split layouts. */
  @Param hideLyricsMetaHeader: boolean = false;
  /** When true, replaces the lyrics-bottom action row with the wide panel dual-icon variant. */
  @Param panelBottomBar: boolean = false;
  /** Normalized progress 0�? for lyric highlight sync. */
  @Local progress: number = 0.01;
  /** Human-readable elapsed time label beside progress. */
  @Local progressText: string = '';
  /** Visual scroll / gradient effect mode for LrcView. */
  @Local lyricScrollEffect: LyricScrollEffect = LyricScrollEffect.Line;
  /** Parsed lyric lines for the current track. */
  @Local mLrcEntryList: Array<LrcEntry> = [];
  /** Timer handle for auto page-show refresh (sample). */
  @Local intervalId: number = 0;
  /** Accumulated UI timer ticks for lyric header visibility. */
  @Local pageShowTime: number = 0;

  /** UIAbility context for raw lyric file access. */
  private get lyricAbilityContext(): common.UIAbilityContext | undefined {
    return getAppRuntime().context;
  }

  /** Triggers initial lyric load for the current song. */
  aboutToAppear(): void {
    this.getLrcEntryList();
  }

  /** Reloads parsed lyrics when the selected track or queue changes. */
  @Monitor('state.selectIndex', 'state.playQueueIds')
  getLrcEntryList() {
    this.mLrcEntryList = [];
    if (!this.lyricAbilityContext) {
      return;
    }
    const song = this.state.getCurrentSongItem();
    if (!song) {
      return;
    }
    const lyricPath = song.lyric;
    if (!lyricPath || lyricPath.length === 0) {
      return;
    }
    try {
      this.lyricAbilityContext.resourceManager.getRawFileContent(lyricPath)
        .then((value: Uint8Array) => {
          let textDecoder = util.TextDecoder.create(PlayerConstants.ENCODING, { ignoreBOM: true });
          let stringData = textDecoder.decodeToString(value, { stream: false });
          if (lyricPath.endsWith(LyricFile.krc)) {
            this.mLrcEntryList = parseKrcLyric(stringData);
          } else if (lyricPath.endsWith(LyricFile.lrc)) {
            this.mLrcEntryList = parseLrcLyric(stringData);
          }
        })
        .catch((error: BusinessError) => {
          Logger.error(TAG, `getRawFileContent failed, code: ${error.code}, message: ${error.message}`);
        });
    } catch (error) {
      Logger.error(TAG, `${error.code} + ${error.message}`);
    }
  }

  /** Column with LrcView, footer icons, and optional ControlAreaComponent. */
  build() {
    Column() {
      LrcView({
        lyricMilliSecondsTime: this.state.progress,
        mLrcEntryList: this.mLrcEntryList,
        lyricScrollEffect: this.lyricScrollEffect,
        lyricTopPosition: LyricTopPosition.Middle,
        mNormalTextSize: this.panelBottomBar ? 32 : 24,
        mCurrentTextSize: this.panelBottomBar ? 40 : 28
      })
        .layoutWeight(1)

      if (this.panelBottomBar) {
        Row({ space: 48 }) {
          SymbolGlyph($r('sys.symbol.arrow_up_left_and_arrow_down_right'))
            .fontSize(32)
            .fontWeight(FontWeight.Regular)
            .height(32)
            .fontColor(['#99ffffff'])
          SymbolGlyph($r('sys.symbol.dot_grid_1x2_circle'))
            .fontSize(32)
            .fontWeight(FontWeight.Regular)
            .height(32)
            .fontColor(['#99ffffff'])
        }
        .width(StyleConstants.FULL_WIDTH)
        .height($r('app.float.control_icon_height'))
        .justifyContent(FlexAlign.End)
      } else {
        Row() {
          if (this.isTablet) {
            Image($r('app.media.ic_public_likes'))
              .width($r('app.float.likes_image_lg'))
              .height($r('app.float.likes_image_lg'))
              .objectFit(ImageFit.Contain)
              .margin({
                right: $r('app.float.likes_margin')
              })
          }
          SymbolGlyph($r('sys.symbol.translate_square'))
            .fontSize(20)
            .fontWeight(FontWeight.Regular)
            .height(20)
            .fontColor(['#99ffffff'])
        }
        .width(StyleConstants.FULL_WIDTH)
        .height($r('app.float.control_icon_height'))
        .justifyContent(FlexAlign.End)
        .margin({
          top: $r('app.float.lyric_margin_top'),
          right: new BreakpointType(
            $r('app.float.lyric_margin_right_sm'),
            $r('app.float.lyric_margin_right_md'),
            $r('app.float.lyric_margin_right_lg'),
            $r('app.float.lyric_margin_right_lg')
          ).getValue(this.breakpointEnv.widthBreakpoint),
          bottom: this.breakpointEnv.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
            this.breakpointEnv.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? 24 : 0
        })
      }

      if (this.isShowControl) {
        ControlAreaComponent()
          .margin({
            top: $r('app.float.control_lyric_margin'),
            bottom: $r('app.float.music_component_bottom')
          })
      }
    }
    .width(StyleConstants.FULL_WIDTH)
    .height('100%')
    .onClick(() => {
      this.pageShowTime = 0;
    })
  }
}