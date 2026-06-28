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

import { LengthMetrics, uiObserver } from '@kit.ArkUI';
import { hdsMaterial, HdsNavDestination, HdsNavigationTitleBarOptions, ScrollEffectType } from '@kit.UIDesignKit';
import {
  BreakpointConstants,
  BreakpointType,
  getWindowInfoState,
  GridConstants,
  ImmersiveType,
  SdkApiUtil,
  StyleConstants,
  WindowInfo
} from 'musicbasic';
import { MusicListPlaybackViewModel } from '../viewmodel/MusicListPlaybackViewModel';
import { PlaylistDetailHeroSection } from './PlaylistDetailHeroSection';
import { PlaylistFloatingMiniBar } from './PlaylistFloatingMiniBar';
import { PlaylistDetailSongListSection } from './PlaylistDetailSongListSection';

/**
 * Full-screen playlist detail page with hero header, song list, and floating mini player.
 */
@ComponentV2
export struct PlaylistDetailPage {
  /** Current window width/height breakpoint from the design system environment. */
  @Env(SystemProperties.BREAK_POINT) breakpointEnv: uiObserver.WindowSizeLayoutBreakpointInfo;
  /** View model driving playlist songs and play actions for this page. */
  @Local listVm: MusicListPlaybackViewModel = new MusicListPlaybackViewModel();
  /** Window chrome and immersive layout information shared app-wide. */
  @Local windowInfo: WindowInfo = getWindowInfoState();
  /** Hero header area width in pixels, updated from child layout. */
  @Local private headerWidthPx: number = 0;
  /** Hero header area height in pixels, updated from child layout. */
  @Local private headerHeightPx: number = 0;
  /** Curve depth in pixels for the small-screen hero clip shape. */
  @Local private depth: number = 18;
  /** Vertical scroller for the main playlist content. */
  private pageScrollScroller: Scroller = new Scroller();
  /** Dynamic top padding applied while scrolling under the title bar. */
  @Local paddingTop: number = 0;

  /**
   * Whether the current width breakpoint is small or medium.
   * @returns True when layout is SM or MD.
   */
  private isWidthBreakpointSmOrMd(): boolean {
    const w: WidthBreakpoint = this.breakpointEnv.widthBreakpoint;
    return w === WidthBreakpoint.WIDTH_SM || w === WidthBreakpoint.WIDTH_MD;
  }

  /**
   * Whether this page uses the mainline playlist detail layout (large width, immersive, or legacy SDK).
   * @returns True when hero and list follow the mainline composition rules.
   */
  private isPlaylistDetailMainline(): boolean {
    const w: WidthBreakpoint = this.breakpointEnv.widthBreakpoint;
    return SdkApiUtil.isSdkApiAtMost(22) ||
      this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ||
      w === WidthBreakpoint.WIDTH_LG ||
      w === WidthBreakpoint.WIDTH_XL;
  }

  /**
   * Whether the PC immersive bottom bar should participate in normal column flow.
   * @returns True when immersive decoration is active.
   */
  private isPcImmersiveBottomBarInFlow(): boolean {
    return this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE;
  }

  /**
   * Scroll handler: drives {@link paddingTop} from {@link pageScrollScroller} so content clears the title bar.
   * Mainline + immersive skips dynamic padding (fixed inset handled elsewhere).
   */
  private onPlaylistScrollDidScroll(): void {
    if (this.isPlaylistDetailMainline() && this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE) {
      return;
    }
    const offset: number = this.pageScrollScroller.currentOffset().yOffset;
    if (offset > 0 && offset < 56) {
      this.paddingTop = offset;
    } else if (offset >= 56) {
      this.paddingTop = 56;
    } else {
      this.paddingTop = 0;
    }
  }

  /**
   * Builds the scrollable grid of hero and song list sections.
   */
  @Builder
  private PlaylistScrollContentRoot() {
    GridRow({
      columns: {
        sm: BreakpointConstants.COLUMN_LG,
        md: BreakpointConstants.COLUMN_LG,
        lg: BreakpointConstants.COLUMN_LG,
        xl: BreakpointConstants.COLUMN_LG
      }
    }) {
      GridCol({
        span: {
          sm: GridConstants.SPAN_TWELVE,
          md: GridConstants.SPAN_TWELVE,
          lg: GridConstants.SPAN_FOUR,
          xl: GridConstants.SPAN_FOUR
        }
      }) {
        PlaylistDetailHeroSection({
          headerWidthPx: this.headerWidthPx,
          headerHeightPx: this.headerHeightPx,
          depth: this.depth,
          onHeaderAreaChange: (widthPx: number, heightPx: number) => {
            this.headerWidthPx = widthPx;
            this.headerHeightPx = heightPx;
          }
        })
      }

      GridCol({
        span: {
          sm: GridConstants.SPAN_TWELVE,
          md: GridConstants.SPAN_TWELVE,
          lg: GridConstants.SPAN_EIGHT,
          xl: GridConstants.SPAN_EIGHT
        }
      }) {
        PlaylistDetailSongListSection({ listVm: this.listVm })
      }
    }
    .width(StyleConstants.FULL_WIDTH)
  }

  /**
   * Builds the nav destination body: either column+mini bar in flow or stacked mini bar overlay.
   */
  @Builder
  private PlaylistNavDestinationSlot() {
    if (this.isPcImmersiveBottomBarInFlow()) {
      Column() {
        Scroll(this.pageScrollScroller) {
          this.PlaylistScrollContentRoot()
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({
          top: this.isPlaylistDetailMainline() ?
            (this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? 56 : this.paddingTop) :
            this.paddingTop
        })
        .onDidScroll((): void => {
          this.onPlaylistScrollDidScroll();
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

        PlaylistFloatingMiniBar()
          .width(StyleConstants.FULL_WIDTH)
          .padding({
            left: 0,
            right: 0
          })
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    } else {
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll(this.pageScrollScroller) {
          this.PlaylistScrollContentRoot()
        }
        .height('100%')
        .scrollBar(BarState.Off)
        .padding({
          top: this.isPlaylistDetailMainline() ? 56 : this.paddingTop
        })
        .onDidScroll((): void => {
          this.onPlaylistScrollDidScroll();
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

        PlaylistFloatingMiniBar()
          .zIndex(10)
          .margin({
            left: new BreakpointType(16, 24, 32, 32, 9).getWidthValueWithHeightSM(
              this.breakpointEnv.widthBreakpoint, this.breakpointEnv.heightBreakpoint),
            right: new BreakpointType(16, 24, 32, 32, 9).getWidthValueWithHeightSM(
              this.breakpointEnv.widthBreakpoint, this.breakpointEnv.heightBreakpoint)
          })
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
  }

  /**
   * Builds HDS title bar options for back, menu, padding, and scroll/blur styles for this route.
   * @returns Configured navigation title bar for the current breakpoint and immersive mode.
   */
  private getPlaylistDetailTitleBar(): HdsNavigationTitleBarOptions {
    const startVp: number = new BreakpointType(16, 24, 24, 24, 18).getWidthValueWithHeightSM(
      this.breakpointEnv.widthBreakpoint, this.breakpointEnv.heightBreakpoint);
    const endVp: number = this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ?
      Math.max(0, this.windowInfo.titleButtonWidthVp) + 8 : startVp;
    if (this.isPlaylistDetailMainline()) {
      if (this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE) {
        return {
          padding: {
            start: LengthMetrics.vp(startVp),
            end: LengthMetrics.vp(endVp)
          },
          style: {
            originalStyle: {
              backgroundStyle: {
                backgroundColor: $r('app.color.background_secondary')
              }
            },
            scrollEffectStyle: {
              backgroundStyle: {
                backgroundColor: $r('app.color.background_secondary')
              }
            }
          },
          content: {
            title: {
              mainTitle: ''
            },
            backIcon: {
              label: 'back',
              icon: $r('sys.symbol.chevron_left'),
              isEnabled: true
            },
            menu: {
              value: [
                {
                  content: {
                    label: 'share',
                    icon: $r('sys.symbol.share'),
                    isEnabled: true,
                    action: (): void => {
                    }
                  }
                },
                {
                  content: {
                    label: 'more',
                    icon: $r('sys.symbol.dot_grid_2x2'),
                    isEnabled: true,
                    action: (): void => {
                    }
                  }
                }
              ]
            }
          }
        };
      }
      return {
        padding: {
          start: LengthMetrics.vp(startVp),
          end: LengthMetrics.vp(endVp)
        },
        style: {
          originalStyle: {
            backgroundStyle: {
              backgroundColor: $r('app.color.background_secondary')
            },
            contentStyle: {
              backIconStyle: {
                iconColor: $r('app.color.font_primary'),
                backgroundColor: $r('app.color.primary5')
              },
              menuStyle: {
                iconColor: $r('app.color.font_primary'),
                backgroundColor: $r('app.color.primary5')
              }
            }
          },
          scrollEffectStyle: {
            backgroundStyle: {
              backgroundColor: $r('app.color.background_secondary')
            },
            contentStyle: {
              backIconStyle: {
                iconColor: $r('app.color.font_primary'),
                backgroundColor: $r('app.color.primary5')
              },
              menuStyle: {
                iconColor: $r('app.color.font_primary'),
                backgroundColor: $r('app.color.primary5')
              }
            }
          }
        },
        content: {
          title: {
            mainTitle: ''
          },
          backIcon: {
            label: 'back',
            icon: $r('sys.symbol.chevron_left'),
            isEnabled: true
          },
          menu: {
            value: [
              {
                content: {
                  label: 'share',
                  icon: $r('sys.symbol.share'),
                  isEnabled: true,
                  action: (): void => {
                  }
                }
              },
              {
                content: {
                  label: 'more',
                  icon: $r('sys.symbol.dot_grid_2x2'),
                  isEnabled: true,
                  action: (): void => {
                  }
                }
              }
            ]
          }
        }
      };
    }
    return {
      padding: {
        start: LengthMetrics.vp(startVp),
        end: LengthMetrics.vp(endVp)
      },
      style: {
        scrollEffectOpts: {
          enableScrollEffect: this.windowInfo.immersiveDecor === ImmersiveType.IMMERSIVE ? false : true,
          enableRefreshOffsetChange: false,
          scrollEffectType: ScrollEffectType.IMMERSIVE_GRADIENT_BLUR
        },
        originalStyle: {
          backgroundStyle: {
            backgroundColor: '#00000000'
          },
          contentStyle: {
            backIconStyle: {
              iconColor: $r('app.color.on_primary90'),
            },
            menuStyle: {
              iconColor: $r('app.color.on_primary90'),
            }
          }
        },
        scrollEffectStyle: {
          backgroundStyle: {
            backgroundColor: $r('app.color.background_secondary')
          },
          contentStyle: {
            backIconStyle: {
              iconColor: $r('app.color.font_primary'),
            },
            menuStyle: {
              iconColor: $r('app.color.font_primary'),
            }
          }
        },
        systemMaterialEffect: {
          materialType: hdsMaterial.MaterialType.ADAPTIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
        }
      },
      content: {
        title: {
          mainTitle: ''
        },
        backIcon: {
          label: 'back',
          icon: $r('sys.symbol.chevron_left'),
          isEnabled: true
        },
        menu: {
          value: [
            {
              content: {
                label: 'share',
                icon: $r('sys.symbol.share'),
                isEnabled: true,
                action: (): void => {
                }
              }
            },
            {
              content: {
                label: 'more',
                icon: $r('sys.symbol.dot_grid_2x2'),
                isEnabled: true,
                action: (): void => {
                }
              }
            }
          ]
        }
      }
    };
  }

  /**
   * Runs when the page appears: converts curve depth to px and refreshes playlist data.
   */
  private onPlaylistDetailPageAppear(): void {
    this.depth = this.getUIContext().vp2px(18);
    this.listVm.syncPlaylistFromApi();
  }

  /**
   * Composes the HDS nav destination, title bar, and scrollable playlist content.
   */
  build() {
    HdsNavDestination() {
      this.PlaylistNavDestinationSlot();
    }
    .hideTitleBar(false)
    .titleBar(this.getPlaylistDetailTitleBar())
    .backgroundColor($r('app.color.background_secondary'))
    .systemBarStyle(
      { statusBarContentColor: this.isWidthBreakpointSmOrMd() ? '#FFFFFF' : '#000000' },
      { statusBarContentColor: '#000000' })
    .onAppear((): void => {
      this.onPlaylistDetailPageAppear();
    });
  }
}

/**
 * Global builder entry for routing to {@link PlaylistDetailPage}.
 * @param name Route or page name (unused placeholder for navigation integration).
 * @param param Optional route parameters object.
 */
@Builder
export function PlaylistDetailPageBuilder(name: string, param: Object) {
  PlaylistDetailPage()
}
