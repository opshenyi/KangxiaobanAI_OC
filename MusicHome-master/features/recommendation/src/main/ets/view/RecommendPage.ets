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
  SdkApiUtil,
  SdkConstants,
  SongConstants,
  StyleConstants,
  WindowInfo
} from 'musicbasic';
import { RecommendViewModel } from '../viewmodel/RecommendViewModel';
import { HomeFloatingMiniBar } from './HomeFloatingMiniBar';
import { CategoryChipsSection } from './CategoryChipsSection';
import { ForYouSection } from './ForYouSection';
import { HeroBannerSection } from './HeroBannerSection';
import { HomeTopBar } from './HomeTopBar';
import { PrivateSongsSection } from './PrivateSongsSection';

/**
 * Recommendation home page: scrollable sections plus optional bottom mini player.
 * Phone may host the mini player in {@link HdsTabs} floating chrome; PC embeds {@link HomeFloatingMiniBar} here.
 */
@ComponentV2
export struct RecommendPage {
  /**
   * When true, the host shell renders the mini player (e.g. phone {@link HdsTabs} floating bar).
   * PC and other shells without that integration must leave this false so {@link HomeFloatingMiniBar} shows.
   */
  @Param shellProvidesFloatingMiniBar: boolean = false;
  /** Current window width breakpoint from system env for responsive padding. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Title bar insets, immersive decor, and related window metrics. */
  @Local windowInfo: WindowInfo = getWindowInfoState();
  /** Loads and holds hero, category, for-you, and private-songs data for child sections. */
  @Local recommendViewModel: RecommendViewModel = new RecommendViewModel();

  /**
   * Loads recommendation content into the local recommend view model.
   */
  aboutToAppear() {
    this.recommendViewModel.load();
  }

  /**
   * Bottom padding reserved when the floating tab bar overlaps the mini player (non-HDS API).
   *
   * @returns Extra bottom space in vp, or 0 when immersive or when API supports floating tabs.
   */
  private homeFloatingMiniBarTabOverlapReserveBottomVp(): number {
    if (this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE) {
      return 0;
    }
    if (this.shellProvidesFloatingMiniBar) {
      return 0;
    }
    return SdkApiUtil.isSdkApiAtLeast(SdkConstants.HDS_TABS_BAR_FLOATING_MIN_SDK_API) ? 0 : 56;
  }

  /**
   * Builds the scrollable home column, optional {@link HomeFloatingMiniBar}, and outer padding.
   */
  build() {
    Column() {
      Scroll() {
        Column() {
          HomeTopBar()
          HeroBannerSection({ recommendViewModel: this.recommendViewModel })
          CategoryChipsSection({ recommendViewModel: this.recommendViewModel })
          ForYouSection({ recommendViewModel: this.recommendViewModel })
          PrivateSongsSection({ recommendViewModel: this.recommendViewModel })
        }
      }
      .layoutWeight(1)
      .padding({
        bottom: this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 0 : 16
      })
      .backgroundColor($r('app.color.background_secondary'))
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      if (!this.shellProvidesFloatingMiniBar) {
        HomeFloatingMiniBar()
      }
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .padding({ bottom: this.homeFloatingMiniBarTabOverlapReserveBottomVp() })
  }

  /**
   * Standard push/pop page transition timing for this route.
   */
  pageTransition() {
    PageTransitionEnter({ duration: SongConstants.TRANSITION_DURATION, curve: Curve.Smooth, type: RouteType.Pop })
    PageTransitionExit({ duration: SongConstants.TRANSITION_DURATION, curve: Curve.Smooth, type: RouteType.Push })
  }
}
