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


/**
 * UI row model for a song in the private-songs recommendation list.
 */
export class RecommendPrivateSongUi {
  /** Stable song id used for playback requests. */
  public id: number = 0;
  /** Song title text or resource. */
  public title: string | Resource = '';
  /** Artist or singer line. */
  public singer: string | Resource = '';
  /** Cover artwork resource (mapped from API label in util). */
  public cover: Resource = $r('app.string.page_show');
}


/**
 * UI model for a hero banner card (badge, copy, cover, gradient hints).
 */
export class RecommendHeroCardUi {
  /** Small badge label above the title. */
  public badge: Resource = $r('app.string.page_show');
  /** Primary headline. */
  public title: Resource = $r('app.string.page_show');
  /** Secondary subtitle line. */
  public subLine: Resource = $r('app.string.page_show');
  /** Main hero image. */
  public coverImage: Resource = $r('app.media.ic_good');
  /** Gradient start color (hex string). */
  public gradientStart: string = '#1E3A5F';
  /** Gradient end color (hex string). */
  public gradientEnd: string = '#4A6FA5';
}


/**
 * UI model for a “For you” style recommendation playlist card.
 */
export class RecommendCardUi {
  /** Card title. */
  public title: Resource = $r('app.string.page_show');
  /** Human-readable play count label. */
  public playCountLabel: Resource = $r('app.string.page_show');
  /** Palette index for themed styling. */
  public paletteIndex: number = 0;
  /** Background / cover image for the card. */
  public backgroundImage: Resource = $r('app.media.ic_avatar1');
}


/**
 * UI model for a single category chip tab (icons for selected vs unselected).
 */
export class RecommendCategoryTabUi {
  /** Tab label. */
  public title: Resource = $r('app.string.page_show');
  /** Icon when this tab is selected. */
  public iconSelected: Resource = $r('app.media.ic_home_chip_featured_sel');
  /** Icon when this tab is not selected. */
  public iconUnselected: Resource = $r('app.media.ic_home_chip_featured_unsel');
}
