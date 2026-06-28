import { LengthMetrics, SymbolGlyphModifier } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { hdsMaterial, HdsNavigation, HdsNavigationTitleMode, HdsTabsController } from '@kit.UIDesignKit';
import { HdsBarStyle, HdsTabs } from '@hms.hds.hdsBaseComponent';
import {
  ComponentItem,
  HdsUtil,
  PaddingToken,
  SizeToken,
} from 'common';
import { CapsuleStyle } from '../components/navigation/subtab/components/CapsuleStyle';
import { UnderlineStyle } from '../components/navigation/subtab/components/UnderlineStyle';

@Entry
@ComponentV2
struct Index {
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();
  private scroller: Scroller = new Scroller();
  private bottomController: HdsTabsController = new HdsTabsController();
  @Local isMiniBar: boolean = true;
  @Local currentTab: number = 0;
  private bottomTabs: BottomTabBarStyle[] = [
    new BottomTabBarStyle({
      normal: new SymbolGlyphModifier($r('sys.symbol.house_fill')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_primary')]),
      selected: new SymbolGlyphModifier($r('sys.symbol.house_fill')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_emphasize')])
    }, $r('app.string.tab_home')).labelStyle({ unselectedColor: $r('sys.color.icon_primary'), selectedColor: $r('sys.color.icon_emphasize') }),
    new BottomTabBarStyle({
      normal: new SymbolGlyphModifier($r('sys.symbol.compass')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_primary')]),
      selected: new SymbolGlyphModifier($r('sys.symbol.compass')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_emphasize')])
    }, $r('app.string.tab_discover')).labelStyle({ unselectedColor: $r('sys.color.icon_primary'), selectedColor: $r('sys.color.icon_emphasize') }),
    new BottomTabBarStyle({
      normal: new SymbolGlyphModifier($r('sys.symbol.message')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_primary')]),
      selected: new SymbolGlyphModifier($r('sys.symbol.message_fill')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_emphasize')])
    }, $r('app.string.tab_message')).labelStyle({ unselectedColor: $r('sys.color.icon_primary'), selectedColor: $r('sys.color.icon_emphasize') }),
    new BottomTabBarStyle({
      normal: new SymbolGlyphModifier($r('sys.symbol.person')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_primary')]),
      selected: new SymbolGlyphModifier($r('sys.symbol.person_fill')).renderingStrategy(SymbolRenderingStrategy.SINGLE).fontColor([$r('sys.color.icon_emphasize')])
    }, $r('app.string.tab_mine')).labelStyle({ unselectedColor: $r('sys.color.icon_primary'), selectedColor: $r('sys.color.icon_emphasize') }),
  ];

  @Builder
  miniBarBuilder() {
    Row() {
      Column() {
        SymbolGlyph($r('sys.symbol.music_note_list'))
          .fontSize(this.isMiniBar ? 28 : $r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_primary')])
      }
      .padding(this.isMiniBar ? 14 : $r('sys.float.padding_level3'))
      .width(56).aspectRatio(1).justifyContent(FlexAlign.Center)
      Column({ space: 6 }) {
        Text('康小伴').textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
          .fontWeight(FontWeight.Bold).fontColor($r('sys.color.font_primary')).fontSize($r('sys.float.Body_S'))
        Text('沉浸光感体验').textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
          .fontWeight(FontWeight.Regular).fontColor($r('sys.color.font_secondary')).fontSize($r('sys.float.Caption_M'))
      }
      .padding({ left: $r('sys.float.padding_level1') }).alignItems(HorizontalAlign.Start).layoutWeight(1)
      Row({ space: 16 }) {
        SymbolGlyph($r('sys.symbol.play_round_triangle_fill')).fontSize($r('sys.float.Title_M'))
        SymbolGlyph($r('sys.symbol.forward_end_fill')).fontSize($r('sys.float.Title_M'))
        SymbolGlyph($r('sys.symbol.music_note_list')).fontSize($r('sys.float.Title_M'))
      }
      .padding({ left: $r('sys.float.padding_level4'), right: $r('sys.float.padding_level8') })
    }
  }

  build() {
    HdsNavigation(this.navPathStack) {
      Stack({ alignContent: Alignment.BottomStart }) {
        // 背景层：List 触发 MaskBlur 渐变透明
        List({ scroller: this.scroller }) {
          ListItem() {
            Column() {
              CapsuleStyle()
              UnderlineStyle()
            }
            .width(SizeToken.SIZE_PERCENT_100)
            .padding({ bottom: PaddingToken.PADDING_16VP })
          }
        }
        .width(SizeToken.SIZE_PERCENT_100)
        .height(SizeToken.SIZE_PERCENT_100)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        .clipContent(ContentClipMode.SAFE_AREA)

        // 叠加层：HdsTabs 悬浮底部导航 + miniBar + 沉浸光感
        HdsTabs({ controller: this.bottomController }) {
          TabContent().tabBar(this.bottomTabs[0])
          TabContent().tabBar(this.bottomTabs[1])
          TabContent().tabBar(this.bottomTabs[2])
          TabContent().tabBar(this.bottomTabs[3])
        }
        .barOverlap(true)
        .vertical(false)
        .barPosition(BarPosition.End)
        .barFloatingStyle({
          barBottomMargin: $r('sys.float.padding_level8'),
          systemMaterialEffect: {
            materialType: hdsMaterial.MaterialType.IMMERSIVE,
            materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
          },
          miniBar: {
            miniBarBuilder: () => this.miniBarBuilder(),
            onBarStyleChange: (miniBarStyle: HdsBarStyle) => {
              this.isMiniBar = miniBarStyle === HdsBarStyle.COLLAPSE
            }
          }
        })
        .onChange((index: number) => { this.currentTab = index; })
        .hitTestBehavior(HitTestMode.Transparent)
        .height(SizeToken.SIZE_PERCENT_100)
        .width(SizeToken.SIZE_PERCENT_100)
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .titleBar({
      enableComponentSafeArea: true,
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_16VP),
        end: LengthMetrics.vp(PaddingToken.PADDING_16VP)
      },
      style: HdsUtil.getHdsStyle(),
      content: {
        title: { mainTitle: '首页' },
        menu: {
          value: [{
            content: {
              icon: $r('sys.symbol.magnifyingglass'),
              label: '搜索',
              isEnabled: true,
              action: () => {}
            }
          }]
        }
      }
    })
    .titleMode(HdsNavigationTitleMode.MINI)
    .hideBackButton(true)
    .backgroundColor($r('sys.color.background_secondary'))
  }
}
