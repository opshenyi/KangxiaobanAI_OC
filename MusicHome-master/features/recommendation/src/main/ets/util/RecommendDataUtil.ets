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


import {
  HeroCardApiDto,
  MusicDbApi,
  PlaybackIntentState,
  RecommendCardApiDto,
  SongApiDto,
  TabApiDto
} from 'musicbasic';
import {
  RecommendCardUi,
  RecommendCategoryTabUi,
  RecommendHeroCardUi,
  RecommendPrivateSongUi
} from '../model/RecommendUiModels';

/**
 * Maps {@link MusicDbApi} DTOs to recommendation UI models and applies playback intents.
 */
export class RecommendDataUtil {
  /**
   * Fetches hero cards from the music DB and maps them to UI models.
   *
   * @returns Hero card UI list for banners.
   */
  public static getHeroCards(): RecommendHeroCardUi[] {
    return MusicDbApi.getInstance().getHeroCards().map((dto) => RecommendDataUtil.mapHeroDtoToUi(dto));
  }

  /**
   * Fetches recommendation playlists from the music DB and maps them to UI models.
   *
   * @returns Playlist card UI list for “For you” and similar strips.
   */
  public static getRecommendPlaylists(): RecommendCardUi[] {
    return MusicDbApi.getInstance().getRecommendPlaylists()
      .map((dto) => RecommendDataUtil.mapRecommendCardDtoToUi(dto));
  }

  /**
   * Fetches the private-songs display list from the music DB and maps it to UI models.
   *
   * @returns Private song rows for the home list.
   */
  public static getPrivateSongDisplayList(): RecommendPrivateSongUi[] {
    return MusicDbApi.getInstance()
      .getPrivateSongDisplayList()
      .map((dto) => RecommendDataUtil.mapSongDtoToPrivateUi(dto));
  }

  /**
   * Fetches category tabs from the music DB and maps them to UI models.
   *
   * @returns Category chip tab models.
   */
  public static getCategoryTabs(): RecommendCategoryTabUi[] {
    return MusicDbApi.getInstance().getCategoryTabs().map((dto) => RecommendDataUtil.mapTabDtoToUi(dto));
  }

  /**
   * Sets pending play song id, opens the player UI, and bumps the intent version on {@link PlaybackIntentState}.
   *
   * @param songId - Song to play.
   * @param intent - Global playback intent state to mutate.
   */
  public static applyPlaybackIntentForSongId(songId: number, intent: PlaybackIntentState): void {
    intent.pendingPlaySongId = songId;
    intent.openPlayerUi = true;
    intent.requestVersion++;
  }

  /**
   * Maps a hero card API DTO to {@link RecommendHeroCardUi}.
   *
   * @param dto - Source hero card DTO.
   * @returns Populated UI model.
   */
  private static mapHeroDtoToUi(dto: HeroCardApiDto): RecommendHeroCardUi {
    const ui = new RecommendHeroCardUi();
    ui.badge = dto.badge;
    ui.title = dto.title;
    ui.subLine = dto.subLine;
    ui.coverImage = dto.coverImage;
    ui.gradientStart = dto.gradientStart;
    ui.gradientEnd = dto.gradientEnd;
    return ui;
  }

  /**
   * Maps a recommendation card API DTO to {@link RecommendCardUi}.
   *
   * @param dto - Source playlist/card DTO.
   * @returns Populated UI model.
   */
  private static mapRecommendCardDtoToUi(dto: RecommendCardApiDto): RecommendCardUi {
    const ui = new RecommendCardUi();
    ui.title = dto.title;
    ui.playCountLabel = dto.playCountLabel;
    ui.paletteIndex = dto.paletteIndex;
    ui.backgroundImage = dto.backgroundImage;
    return ui;
  }

  /**
   * Maps a song API DTO to {@link RecommendPrivateSongUi} for the private-songs strip.
   *
   * @param dto - Source song DTO.
   * @returns Populated private-song row model.
   */
  private static mapSongDtoToPrivateUi(dto: SongApiDto): RecommendPrivateSongUi {
    const ui = new RecommendPrivateSongUi();
    ui.id = dto.id;
    ui.title = dto.title;
    ui.singer = dto.singer;
    ui.cover = dto.label;
    return ui;
  }

  /**
   * Maps a tab API DTO to {@link RecommendCategoryTabUi}.
   *
   * @param dto - Source category tab DTO.
   * @returns Populated tab chip model.
   */
  private static mapTabDtoToUi(dto: TabApiDto): RecommendCategoryTabUi {
    const ui = new RecommendCategoryTabUi();
    ui.title = dto.title;
    ui.iconSelected = dto.iconSelected;
    ui.iconUnselected = dto.iconUnselected;
    return ui;
  }
}
