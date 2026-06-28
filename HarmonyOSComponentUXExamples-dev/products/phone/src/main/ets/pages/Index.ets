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
import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { HdsNavigation } from '@kit.UIDesignKit';
import {
  BreakpointModel,
  CodeSheetShow,
  CommonConstants,
  ComponentDataUtil,
  ComponentGroup,
  ComponentItem,
  CornerRadiusToken,
  HdsUtil,
  NoMore,
  PaddingToken,
  SheetParams,
  SizeToken,
  SpaceToken,
  StorageKey,
  SubTitleView as GroupHeader,
  TitleBuilder,
  WebSheetBuilder,
  WebUtil
} from 'componentuxexamplesbase';


/**
 * An independent list item component for mobile, tablet, and foldable layouts.
 * Responsible for managing background colors based on device breakpoints and selection states.
 */
@ComponentV2
struct ComponentListItem {
  // Input parameters from the parent component
  @Param itemData: ComponentItem = { id: util.generateRandomUUID(true), name: '', url: '' };
  @Param isSelected: boolean = false;
  @Param breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();

  /**
   * Calculates the background color for the inner Row.
   * Highlights the item when selected on medium or large screens (tablet/foldable).
   */
  get rowBackgroundColor(): ResourceColor {
    if (!this.breakpointModel.isSmallScreen() && this.isSelected && this.navPathStack.size() > 0) {
      return $r('app.color.list_item_selected_color');
    }
    return Color.Transparent;
  }

  /**
   * Calculates the background color for the outer Column.
   * Uses default background for mobile/tablet list cards.
   */
  get columnBackgroundColor(): ResourceColor {
    return $r('sys.color.comp_background_list_card');
  }

  // Callback event triggered when the item is clicked
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

        // Chevron right icon displayed on phone screens
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .justifyContent(FlexAlign.End)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .padding({ left: PaddingToken.PADDING_8VP, right: PaddingToken.PADDING_8VP })
      .backgroundColor(this.rowBackgroundColor)
      .stateStyles({
        // Apply pressed state styling natively
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .padding(PaddingToken.PADDING_4VP)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .backgroundColor(this.columnBackgroundColor)
    // Trigger the callback function passed from the parent
    .onClick(() => {
      this.onClickItem();
    })
  }
}

/**
 * The main entry component of the page.
 */
@Entry
@ComponentV2
struct Index {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local selectedId: string = '';
  @Local componentData: ComponentGroup[] = [];
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();
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
    const context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    this.mainSourceUrl = ComponentDataUtil.loadCodeSourceUrl(context, 'code-source-url.json');
    this.componentData = ComponentDataUtil.loadComponentData(context, 'component-data-phone.json');
    this.componentItemData = {
      id: '',
      name: $r('app.string.PhoneAbility_label'),
      url: '',
      sourceUrl: this.mainSourceUrl
    }
    if (this.codeSheetShow) {
      this.codeSheetShow.mainSheetParams =
        new SheetParams(this.mainSourceUrl, $r('app.string.PhoneAbility_label'), 'PhoneAbility_label');
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

  aboutToDisappear(): void {
    AppStorage.delete(StorageKey.UI_CONTEXT);
    AppStorageV2.remove(StorageKey.CODE_SHEET_SHOW);
  }

  build() {
    HdsNavigation(this.navPathStack) {
      List({ space: SpaceToken.SPACE_12 }) {
        // Iterate through component groups
        Repeat(this.componentData)
          .each((groupWrap) => {
            ListItemGroup({
              header: GroupHeader(groupWrap.item.title, undefined, $r('app.color.default_background_color')),
              space: SizeToken.SIZE_NUM_12
            }) {
              // Iterate through items within each group
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    // Render the encapsulated list item component
                    ComponentListItem({
                      itemData: itemWrap.item,
                      // Compute the selected state dynamically
                      isSelected: this.selectedId === itemWrap.item.id && this.navPathStack.size() !== 0,
                      breakpointModel: this.breakpointModel,
                      onClickItem: () => {
                        this.componentItemData = itemWrap.item;
                        const targetUrl = itemWrap.item.url.toString();
                        // Navigation logic: handle routing based on screen size (phone vs tablet/foldable)
                        if (this.breakpointModel.isSmallScreen()) {
                          this.navPathStack.replacePath({ name: targetUrl, param: itemWrap.item });
                        } else {
                          if (this.selectedId !== itemWrap.item.id || this.navPathStack.size() === 0) {
                            this.navPathStack.replacePath({ name: targetUrl, param: itemWrap.item });
                          }
                        }
                        // Update the selected item ID
                        this.selectedId = itemWrap.item.id;
                      }
                    })
                  }
                })
                .key((item) => item.id) // Use the unique item ID as the Repeat key
            }
          })
          .key((group) => group.id) // Use the unique group ID as the Repeat key

        // Render the "No More" footer at the bottom of the list
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
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      .clipContent(ContentClipMode.SAFE_AREA)
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
      content: HdsUtil.getHdsContent(this.getUIContext(), $r('app.string.index_title'), this.componentItemData,
        $r('sys.symbol.code'))
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .mode(this.breakpointModel.currentNavigationMode)
    .navBarWidth(SizeToken.SIZE_PERCENT_40)
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