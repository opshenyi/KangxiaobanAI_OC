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


import { AppStorageV2 } from '@kit.ArkUI';
import { AppStorageKeys, PlaybackIntentState } from 'musicbasic';
import { RecommendSongUiDataSource } from '../model/RecommendSongUiDataSource';
import {
  RecommendCardUi,
  RecommendCategoryTabUi,
  RecommendHeroCardUi,
  RecommendPrivateSongUi
} from '../model/RecommendUiModels';
import { RecommendDataUtil } from '../util/RecommendDataUtil';

/**
 * View model for the recommendation home: hero banners, playlists, private songs, and category chips.
 * State is observable via ArkUI {@code @ObservedV2} for UI binding.
 */
@ObservedV2
export class RecommendViewModel {
  private playbackIntent: PlaybackIntentState =
    AppStorageV2.connect(PlaybackIntentState, AppStorageKeys.PLAYBACK_INTENT_STATE, () => new PlaybackIntentState())!;

  /** Hero banner cards shown in the horizontal carousel. */
  @Trace public heroCards: RecommendHeroCardUi[] = [];
  /** “For you�?recommendation playlist cards. */
  @Trace public recommendItems: RecommendCardUi[] = [];
  /** Private-songs section list items (display model). */
  @Trace public privateSongDisplayList: RecommendPrivateSongUi[] = [];
  /** Lazy list data source backed by the private song display list. */
  @Trace public privateSongDataSource: RecommendSongUiDataSource = new RecommendSongUiDataSource([]);
  /** Category chip tabs (title and selected/unselected icons). */
  @Trace public categoryTabItems: RecommendCategoryTabUi[] = [];
  /** Index of the selected category chip in the category tab items array. */
  @Trace public selectedCategoryIndex: number = 0;
  /** Search query string reserved for future search integration. */
  @Trace public searchQuery: string = '';

  /**
   * Loads all recommendation UI data from RecommendDataUtil into trace fields.
   */
  public load(): void {
    this.heroCards = RecommendDataUtil.getHeroCards();
    this.recommendItems = RecommendDataUtil.getRecommendPlaylists();
    this.privateSongDisplayList = RecommendDataUtil.getPrivateSongDisplayList();
    this.privateSongDataSource = new RecommendSongUiDataSource(this.privateSongDisplayList);
    this.categoryTabItems = RecommendDataUtil.getCategoryTabs();
  }

  /**
   * Updates the selected category chip index.
   *
   * @param index - Selected index in the category tab items array.
   */
  public selectCategory(index: number): void {
    this.selectedCategoryIndex = index;
  }

  /**
   * Requests playback for the given song by updating global PlaybackIntentState.
   *
   * @param songId - Song identifier to play.
   */
  public requestPlayBySongId(songId: number): void {
    RecommendDataUtil.applyPlaybackIntentForSongId(songId, this.playbackIntent);
  }
}
