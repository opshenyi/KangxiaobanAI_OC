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
import { HdsNavigation, hdsMaterial } from '@kit.UIDesignKit';
import {
  AppStorageKeys,
  getWindowInfoState,
  MusicAppState,
  MusicDbApi,
  PlaybackIntentState,
  PlaybackShellConstants,
  MusicEmptyComponent,
  SdkApiUtil,
  SdkConstants,
  StyleConstants,
  WindowInfo
} from 'musicbasic';
import { dispatchShellPlaybackIntent, PlaybackPageCoverContent } from 'player';
import { HomeMiniBarPlayer, RecommendPage } from 'recommendation';
import { HdsBarStyle, HdsTabs } from '@hms.hds.hdsBaseComponent';
import { deviceInfo } from '@kit.BasicServicesKit';

/**
 * Default phone shell: tabbed home with recommendation feed, floating mini player (API 601+),
 * and full-screen playback when MusicAppState.isShowPlay is true.
 */
@Entry
@ComponentV2
struct Index {
  /** Navigation stack for HdsNavigation routes and modal playback cover. */
  @Provider('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  /** Reactive window width / height breakpoint from the system. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** Index of the selected bottom tab (0 = home). */
  @Local currentTab: number = 0;
  /** Shared playback and UI state (queue, mini bar, full-screen flag). */
  @Local appState: MusicAppState =
    AppStorageV2.connect(MusicAppState, AppStorageKeys.MUSIC_APP_STATE, () => new MusicAppState())!;
  /** External intents (e.g. deep link) that request opening the player shell. */
  @Local intentState: PlaybackIntentState =
    AppStorageV2.connect(PlaybackIntentState, AppStorageKeys.PLAYBACK_INTENT_STATE, () => new PlaybackIntentState())!;
  /** Cached window metrics (safe areas, size) for layout padding. */
  @Local windowInfo: WindowInfo = getWindowInfoState();

  /** Initializes play queue ids from local DB for the session. */
  aboutToAppear() {
    this.appState.playQueueIds = MusicDbApi.getInstance().getSongList().map((dto) => dto.id);
  }

  /** Dispatches playback shell intent when {@link PlaybackIntentState.requestVersion} changes. */
  @Monitor('intentState.requestVersion')
  onPlaybackIntentChanged() {
    dispatchShellPlaybackIntent(this.appState, this.intentState, () => {
      this.getUIContext().animateTo({
        duration: PlaybackShellConstants.OPEN_PLAYER_UI_ANIMATION_MS,
        curve: Curve.EaseInOut
      }, () => {
        this.appState.isShowPlay = true;
      });
    });
  }

  /** Bottom inset (vp) for the floating tab bar; smaller on short-height SM layout. */
  private homeTabBarBottomMarginVp(): number {
    return this.breakpointEnv.widthBreakpoint === WidthBreakpoint.WIDTH_SM &&
      this.breakpointEnv.heightBreakpoint === HeightBreakpoint.HEIGHT_MD ? 16 : this.windowInfo.navigationBarBottomVp;
  }

  /** Small-width breakpoint (vp) for floating bar responsive layout. */
  private floatingBarSmallWidthVp(): number {
    const wPx = this.windowInfo.windowSize.width;
    if (wPx > 0) {
      const wVp = this.getUIContext().px2vp(wPx);
      return wVp - 96;
    }
    return 264;
  }

  /** Single bottom-tab label: icon + title, styled by selection. */
  @Builder
  private TabBarItem(index: number, title: Resource, symbol: Resource) {
    Column({ space: 4 }) {
      SymbolGlyph(symbol)
        .fontSize(22)
        .fontWeight(FontWeight.Regular)
        .height(22)
        .fontColor([this.currentTab === index ? '#E60012' : $r('sys.color.icon_primary')])
      Text(title)
        .fontSize(11)
        .fontColor(this.currentTab === index ? '#E60012' : $r('sys.color.icon_primary'))
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(16)
  }

  /** Syncs expanded/collapsed mini bar style into {@link MusicAppState.miniBarExpanded}. */
  private onMiniBarStyleChange(miniBarStyle: HdsBarStyle): void {
    if (miniBarStyle === HdsBarStyle.EXPAND) {
      this.appState.miniBarExpanded = true;
    } else {
      this.appState.miniBarExpanded = false;
    }
  }

  /** Compact mini player row shown inside the floating HDS bar. */
  @Builder
  private miniBar() {
    Column() {
      HomeMiniBarPlayer({ showPreviousTrack: false })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(56)
    .justifyContent(FlexAlign.Center)
  }

  /** Tab pages: home recommendation plus placeholder tabs. */
  @Builder
  private HomeTabsPages() {
    TabContent() {
      Column() {
        RecommendPage({ shellProvidesFloatingMiniBar: deviceInfo.distributionOSApiVersion >= 60100 })
          .layoutWeight(1)
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
    }
    .tabBar(this.TabBarItem(0, $r('app.string.tab_home'), $r('sys.symbol.house_fill')))

    TabContent() {
      Column() {
        MusicEmptyComponent()
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .padding({ top: this.windowInfo.statusBarTopVp })
    }
    .tabBar(this.TabBarItem(1, $r('app.string.tab_music_hall'), $r('sys.symbol.auditorium')))

    TabContent() {
      Column() {
        MusicEmptyComponent()
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .padding({ top: this.windowInfo.statusBarTopVp })
    }
    .tabBar(this.TabBarItem(2, $r('app.string.tab_cafe_listen'), $r('sys.symbol.podcast')))

    TabContent() {
      Column() {
        MusicEmptyComponent()
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .padding({ top: this.windowInfo.statusBarTopVp })
    }
    .tabBar(this.TabBarItem(3, $r('app.string.tab_mine'), $r('sys.symbol.person_crop_circle_fill_1')))
  }

  /** Root UI: {@link HdsNavigation} with tabs and optional playback cover. */
  build() {
    HdsNavigation(this.pageIndexInfos) {
      if (deviceInfo.distributionOSApiVersion >= 60100) {
        HdsTabs({ barPosition: BarPosition.End }) {
          this.HomeTabsPages()
        }
        .barMode(BarMode.Fixed)
        .barHeight(56)
        .zIndex(1)
        .barOverlap(true)
        .barPosition(BarPosition.End)
        .vertical(false)
        .scrollable(false)
        .barFloatingStyle({
          barWidth: {
            smallWidth: this.floatingBarSmallWidthVp(),
            mediumWidth: 284,
            largeWidth: 328
          },
          barBottomMargin: this.homeTabBarBottomMarginVp(),
          systemMaterialEffect: {
            materialType: hdsMaterial.MaterialType.ADAPTIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          },
          miniBar: {
            miniBarBuilder: (): void => {
              this.miniBar();
            },
            onBarStyleChange: (miniBarStyle: HdsBarStyle): void => {
              this.onMiniBarStyleChange(miniBarStyle);
            }
          }
        })
        .onChange((index: number) => {
          this.currentTab = index;
        })
        .height(StyleConstants.FULL_HEIGHT)
        .width(StyleConstants.FULL_WIDTH)
      } else {
        HdsTabs({ barPosition: BarPosition.End }) {
          this.HomeTabsPages()
        }
        .barMode(BarMode.Fixed)
        .barHeight(56)
        .zIndex(1)
        .barOverlap(true)
        .barPosition(BarPosition.End)
        .vertical(false)
        .scrollable(false)
        .padding({ bottom: this.windowInfo.navigationBarBottomVp })
        .onChange((index: number) => {
          this.currentTab = index;
        })
        .height(StyleConstants.FULL_HEIGHT)
        .width(StyleConstants.FULL_WIDTH)
      }
    }
    .bindContentCover(this.appState.isShowPlay, PlaybackPageCoverContent(), ModalTransition.NONE)
    .mode(NavigationMode.Stack)
    .backgroundColor($r('app.color.home_page_background'))
    .hideTitleBar(true)
    .hideToolBar(true)
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.BOTTOM])
  }
}