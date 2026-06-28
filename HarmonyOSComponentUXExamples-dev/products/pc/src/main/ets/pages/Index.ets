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

import { AppStorageV2, KeyboardAvoidMode, LengthMetrics } from '@kit.ArkUI';
import { util } from '@kit.ArkTS';
import { HdsNavigation } from '@kit.UIDesignKit';
import { common } from '@kit.AbilityKit';
import {
  BreakpointModel,
  CodeSheetShow,
  CommonConstants,
  ComponentDataUtil,
  ComponentGroup,
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  ImmersiveType,
  NoMore,
  PaddingToken,
  SheetParams,
  SizeToken,
  SpaceToken,
  StorageKey,
  SubTitleView as GroupHeader,
  TitleBuilder,
  WebSheetBuilder,
  WebUtil,
  WindowUtil
} from 'componentuxexamplesbase';

/**
 * Standalone list item component (PC-only)
 * Manages hover state and calculates interactive background color
 */
@ComponentV2
struct ComponentListItem {
  @Param itemData: ComponentItem = { id: util.generateRandomUUID(true), name: '', url: '' };
  @Param isSelected: boolean = false;
  // Local state for managing mouse hover interactions, PC-only logic
  @Local isHovered: boolean = false;

  /**
   * Computes the background color for the outer Column
   * Handles hover and selected state interactions on PC
   */
  @Computed
  get columnBackgroundColor(): ResourceColor {
    if (this.isSelected) {
      return $r('app.color.list_item_selected_color');
    }
    if (this.isHovered) {
      return $r('sys.color.interactive_hover');
    }
    return Color.Transparent;
  }

  // Click event callback
  @Event onClickItem: () => void = () => {
  };

  build() {
    Column() {
      Row() {
        Text(this.itemData.name)
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .maxLines(CommonConstants.TEXT_MAX_LINES_1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(CommonConstants.LAYOUT_WEIGHT_1)
      }
      .justifyContent(FlexAlign.Start) // Left-aligned for PC
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({ left: PaddingToken.PADDING_8VP, right: PaddingToken.PADDING_8VP })
      .backgroundColor(Color.Transparent) // Row background remains transparent on PC; controlled by the Column
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_48) // PC-specific list item height
    .padding(PaddingToken.PADDING_4VP)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_8) // PC-specific corner radius
    .backgroundColor(this.columnBackgroundColor)
    // Listens for mouse hover events on PC to update local state
    .onHover((isHover: boolean) => {
      this.isHovered = isHover;
    })
    .onClick(() => {
      this.onClickItem();
    })
  }
}

/**
 * Main entry component for the page (PC)
 */
@Entry
@ComponentV2
struct Index {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local selectedId: string = '';
  @Local componentData: ComponentGroup[] = [];
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();
  private winUtil: WindowUtil = WindowUtil.getInstance();
  private mainSourceUrl: string = '';
  @Local codeSheetShow: CodeSheetShow | undefined =
    AppStorageV2.connect<CodeSheetShow>(CodeSheetShow, StorageKey.CODE_SHEET_SHOW, () => new CodeSheetShow());
  private componentItemData: ComponentItem = {
    id: '',
    name: '',
    url: '',
    sourceUrl: ''
  };

  @Builder
  CustomTitleBuilder() {
    TitleBuilder(this.getUIContext(), this.codeSheetShow?.sheetParams ?? new SheetParams('', ''));
  }

  aboutToAppear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
    this.winUtil.setImmersiveType(ImmersiveType.IMMERSIVE);
    this.winUtil.registerWindowStatusListener();
    const context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    this.mainSourceUrl = ComponentDataUtil.loadCodeSourceUrl(context, 'code-source-url.json');
    this.componentData = ComponentDataUtil.loadComponentData(context, 'component-data-pc.json');

    this.componentItemData = {
      id: '',
      name: $r('app.string.PcAbility_label'),
      url: '',
      sourceUrl: this.mainSourceUrl
    }
    if (this.codeSheetShow) {
      this.codeSheetShow.mainSheetParams = new SheetParams(this.mainSourceUrl, $r('app.string.PcAbility_label'),'PcAbility_label');
    }

    const initItemData = this.componentData[0].items[0];
    const targetUrl = initItemData.url.toString();
    // Navigation logic: handle routing based on screen size (phone vs tablet/foldable)
    if (!this.breakpointModel.isSmallScreen()) {
      this.navPathStack.replacePath({ name: targetUrl, param: initItemData });
      // Update the selected item ID
      this.selectedId = initItemData.id;
    }
  }

  /**
   * Lifecycle callback: invoked before the component is destroyed
   * Cleans up immersive mode and listeners to prevent memory leaks
   */
  aboutToDisappear(): void {
    this.winUtil.setImmersiveType(ImmersiveType.NORMAL);
    this.winUtil.unregisterWindowStatusListener();
    AppStorage.delete(StorageKey.UI_CONTEXT);
    AppStorageV2.remove(StorageKey.CODE_SHEET_SHOW);

  }

  build() {
    HdsNavigation(this.navPathStack) {
      List({ space: SpaceToken.SPACE_12 }) {
        Repeat(this.componentData)
          .each((groupWrap) => {
            ListItemGroup({
              header: GroupHeader(groupWrap.item.title, undefined, $r('app.color.default_background_color')),
              space: SizeToken.SIZE_NUM_4
            }) {
              // Iterates over items within each group
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    // Renders the encapsulated list item component
                    ComponentListItem({
                      itemData: itemWrap.item,
                      isSelected: this.selectedId === itemWrap.item.id && this.navPathStack.size() !== 0,
                      onClickItem: () => {
                        const targetUrl = itemWrap.item.url.toString();
                        // Navigation logic: replaces the right pane view directly in PC split mode
                        if (this.selectedId !== itemWrap.item.id || this.navPathStack.size() === 0) {
                          this.navPathStack.replacePath({ name: targetUrl, param: itemWrap.item });
                        }
                        // Updates the selected item ID
                        this.selectedId = itemWrap.item.id;
                      }
                    })
                  }
                })
                .key((item) => item.id)
            }
          })
          .key((group) => group.id)

        // Renders a "No more items" footer at the bottom of the list
        ListItem() {
          NoMore()
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8')
        })
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({ left: PaddingToken.PADDING_16VP, right: PaddingToken.PADDING_16VP })
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.None) // Disables sticky header for PC
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      .clipContent(ContentClipMode.SAFE_AREA)
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height(SizeToken.SIZE_PERCENT_100)
    .width(SizeToken.SIZE_PERCENT_100)
    .titleBar({
      enableComponentSafeArea: true,
      padding: {
        start: LengthMetrics.vp(PaddingToken.PADDING_28VP), // PC-specific padding
        end: LengthMetrics.vp(PaddingToken.PADDING_28VP)
      },
      style: HdsUtil.getHdsStyle(),
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.index_title'), this.componentItemData,
        $r('sys.symbol.code'))
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .mode(this.breakpointModel.currentNavigationMode)
    .navBarWidth(SizeToken.SIZE_NUM_280) // The PC left sidebar width
    .bindSheet(this.codeSheetShow!.isCodeSheetShow!!,
      WebSheetBuilder(this.codeSheetShow!.sheetParams), {
        showClose: true,
        title: () => this.CustomTitleBuilder(),
        preferType: SheetType.CENTER,
        height: this.breakpointModel.currentWidthBreakpoint === WidthBreakpoint.WIDTH_XL ?
          ((this.getUIContext().px2vp(this.breakpointModel.windowInfo.windowSize.height) -
            this.breakpointModel.windowInfo.decorHeight) * 0.9) : SheetSize.LARGE,
        width: this.breakpointModel.currentWidthBreakpoint === WidthBreakpoint.WIDTH_XL ? SizeToken.SIZE_NUM_800 :
          undefined,
        onWillDisappear: () => {
          WebUtil.getWebNode(this.componentItemData.sourceUrl)?.remove();
        }
      })
  }
}