/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  EditorMenuOptions,
  ExpandedMenuOptions,
  LengthMetrics,
  SelectionMenu,
  SelectionMenuOptions,
  SymbolGlyphModifier
} from '@kit.ArkUI';
import Logger from '../../../../utils/Logger';
import { SubTitleView } from '../../../../common/SubTitleView';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';
import { SpaceToken } from '../../../../designtoken/SpaceToken';
import { BreakpointModel } from '../../../../model/BreakpointModel';

// --- Constants ---
const TAG = 'ContextMenuOnSelection';
const PC_MENU_WIDTH = 256;
const PRIMARY_MENU_SPACE = 10;
const MOCK_TEXT_REPEAT_COUNT = 180;

@Extend(Button)
function commonActionButtonStyle() {
  .stateEffect(true)
  .buttonStyle(ButtonStyleMode.TEXTUAL)
  .controlSize(ControlSize.SMALL)
  .fontSize($r('sys.float.Body_M'))
  .fontColor($r('sys.color.font_primary'))
  .fontWeight(FontWeight.Medium)
}

@ComponentV2
export struct ContextMenuOnSelection {
  // Whether the current device is a PC
  @Param isPC: boolean = false;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  // Indicates whether the secondary menu is expanded on mobile devices
  @Local isMenuExpanded: boolean = false;
  // Shared modifier for unified menu icons
  @Local startIconModifier: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_circle_fill'))
      .fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_primary')]);
  // Width of the primary menu upon initial render, used for expanded menu alignment
  @Local primaryMenuInitialWidth: Length = 0;
  // Controller to manage RichEditor interactions
  private controller: RichEditorController = new RichEditorController();

  @Computed
  get horizontalPadding(): number {
    if (this.isPC) {
      return PaddingToken.PADDING_24VP;
    }
    return this.breakpointModel.getValue({
      sm: PaddingToken.PADDING_16VP,
      md: PaddingToken.PADDING_16VP,
      lg: PaddingToken.PADDING_24VP
    }) as number;
  }

  // --- PC SelectionMenu Configuration ---

  // Top quick-edit menu items for text styling
  get editorMenuOptions(): EditorMenuOptions[] {
    return [
      {
        icon: $r('app.media.startIcon'),
        symbolStyle: new SymbolGlyphModifier($r('sys.symbol.bold')),
        action: () => {
          this.toggleTextStyle('fontWeight', FontWeight.Bolder, FontWeight.Normal);
        }
      },
      {
        icon: $r('app.media.startIcon'),
        symbolStyle: new SymbolGlyphModifier($r('sys.symbol.italic')),
        action: () => {
          this.toggleTextStyle('fontStyle', FontStyle.Italic, FontStyle.Normal);
        }
      },
      {
        icon: $r('app.media.startIcon'),
        symbolStyle: new SymbolGlyphModifier($r('sys.symbol.underline')),
        action: () => {
          this.toggleTextDecoration(TextDecorationType.Underline);
        }
      },
      {
        icon: $r('app.media.startIcon'),
        symbolStyle: new SymbolGlyphModifier($r('sys.symbol.textformat_size_square')),
        action: () => {
          Logger.info(TAG, 'Align text action triggered.');
        }
      },
      {
        icon: $r('app.media.startIcon'),
        symbolStyle: new SymbolGlyphModifier($r('sys.symbol.edit_colour')),
        action: () => {
          this.toggleTextStyle('fontColor', Color.Orange, $r('sys.color.font_primary'));
        }
      }
    ];
  }

  // Extended dropdown menu items under the 'More' section
  get expandedMenuOptions(): ExpandedMenuOptions[] {
    return [
      {
        startIcon: $r('sys.media.AI_translation'),
        content: $r('app.string.translation_label'),
        action: () => {
          Logger.info(TAG, 'Translate action triggered.');
        }
      },
      {
        startIcon: $r('sys.media.ohos_ic_public_search_filled'),
        content: $r('app.string.search_label'),
        action: () => {
          Logger.info(TAG, 'Search action triggered.');
        }
      }
    ];
  }

  // Combines configurations and injects the controller for default clipboard operations
  get selectionMenuOptions(): SelectionMenuOptions {
    return {
      editorMenuOptions: this.editorMenuOptions,
      expandedMenuOptions: this.expandedMenuOptions,
      controller: this.controller
    };
  }

  @Computed
  get primaryMenuPadding(): Length | Padding | LocalizedPadding {
    if (this.isMenuExpanded) {
      return 0;
    }
    return {
      left: PaddingToken.PADDING_18VP,
      right: PaddingToken.PADDING_6VP
    };
  }

  @Computed
  get primaryMenuSpace(): string | number | undefined {
    return this.isMenuExpanded ? undefined : PRIMARY_MENU_SPACE;
  }

  /**
   * Context menu builder for PC (Triggered by right-click)
   */
  @Builder
  PcContextMenuBuilder() {
    Column() {
      SelectionMenu(this.selectionMenuOptions)
    }
    .width(PC_MENU_WIDTH)
    .backgroundColor(Color.Transparent)
  }

  /**
   * Context menu builder for Mobile (Triggered by long-press)
   */
  @Builder
  MobileContextMenuBuilder() {
    Column() {
      this.PrimaryMenu()
    }
  }

  @Builder
  PrimaryMenu() {
    Column() {
      Row({ space: this.primaryMenuSpace }) {
        Row({ space: SpaceToken.SPACE_8 }) {
          Button($r('app.string.cut_label'))
            .commonActionButtonStyle()
            .onClick(() => Logger.info(TAG, 'Cut clicked.'))

          Button($r('app.string.copy_label'))
            .commonActionButtonStyle()
            .onClick(() => Logger.info(TAG, 'Copy clicked.'))

          Button($r('app.string.select_all_label'))
            .commonActionButtonStyle()
            .onClick(() => Logger.info(TAG, 'Select all clicked.'))

          Button($r('app.string.share_label'))
            .commonActionButtonStyle()
            .onClick(() => Logger.info(TAG, 'Share clicked.'))
        }
        .height(SizeToken.SIZE_NUM_40)
        .visibility(this.isMenuExpanded ? Visibility.Hidden : Visibility.Visible)
        .width(this.isMenuExpanded ? 0 : undefined)

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          SymbolGlyph(this.isMenuExpanded ? $r('sys.symbol.arrow_left') : $r('sys.symbol.dot_grid_2x2'))
            .fontSize($r('sys.float.Title_S'))
            .fontColor([$r('sys.color.icon_primary')])
        }
        .width(this.isMenuExpanded ? SizeToken.SIZE_NUM_40 : SizeToken.SIZE_NUM_32)
        .height(this.isMenuExpanded ? SizeToken.SIZE_NUM_40 : SizeToken.SIZE_NUM_32)
        .backgroundColor(this.isMenuExpanded ? $r('sys.color.background_primary') :
          $r('sys.color.comp_background_tertiary'))
        .onClick(() => {
          this.isMenuExpanded = !this.isMenuExpanded;
        })
      }
      .padding(this.primaryMenuPadding)
      .backgroundColor($r('sys.color.background_primary'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
      .shadow(ShadowStyle.OUTER_DEFAULT_MD)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: PaddingToken.PADDING_8VP })
      .onAreaChange((_oldValue: Area, newValue: Area) => {
        if (this.primaryMenuInitialWidth === 0) {
          this.primaryMenuInitialWidth = newValue.width;
        }
      })

      this.ExpandedMenu()
    }
    .alignItems(HorizontalAlign.End)
  }

  @Builder
  ExpandedMenu() {
    Row() {
      Column() {
        Menu() {
          MenuItem({ symbolStartIcon: this.startIconModifier, content: 'Menu Item 1' })
          MenuItem({ symbolStartIcon: this.startIconModifier, content: 'Menu Item 2' })
          MenuItem({ symbolStartIcon: this.startIconModifier, content: 'Menu Item 3' })
        }
        .backgroundColor(Color.Transparent)
        .menuItemDivider({
          strokeWidth: LengthMetrics.px(SizeToken.SIZE_NUM_1),
          color: $r('sys.color.comp_divider'),
          mode: DividerMode.EMBEDDED_IN_MENU,
          startMargin: LengthMetrics.vp(PaddingToken.PADDING_44VP)
        })
      }
      .backgroundColor($r('sys.color.background_primary'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
      .shadow(ShadowStyle.OUTER_DEFAULT_MD)
      .clip(true)
      .alignItems(HorizontalAlign.End)
    }
    .width(this.primaryMenuInitialWidth)
    .backgroundColor(Color.Transparent)
    .justifyContent(FlexAlign.End)
    .visibility(this.isMenuExpanded ? Visibility.Visible : Visibility.Hidden)
  }

  build() {
    Column() {
      Row() {
        SubTitleView($r('app.string.context_menu_on_selection_label'))
      }
      .padding({
        left: this.horizontalPadding,
        right: this.horizontalPadding,
        bottom: PaddingToken.PADDING_16VP
      })

      Column() {
        RichEditor({ controller: this.controller })
          .onReady(() => {
            this.controller.addTextSpan('A'.repeat(MOCK_TEXT_REPEAT_COUNT) + '.', {
              style: {
                fontSize: $r('sys.float.Body_L'),
                fontColor: $r('sys.color.font_primary')
              },
              paragraphStyle: {
                wordBreak: WordBreak.BREAK_ALL
              }
            });
          })
          // Mobile interaction: Long-press triggers the native floating action bar
          .bindSelectionMenu(
            RichEditorSpanType.TEXT,
            this.MobileContextMenuBuilder(),
            ResponseType.LongPress,
            {
              onDisappear: () => {
                this.isMenuExpanded = false;
              }
            }
          )
          // PC interaction: Right-click triggers the system-native SelectionMenu
          .bindSelectionMenu(
            RichEditorSpanType.TEXT,
            this.PcContextMenuBuilder(),
            RichEditorResponseType.RIGHT_CLICK
          )
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_NUM_132)
      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
    }
  }

  /**
   * Unified utility logic to process and apply styles to selected text spans.
   * @param updateCallback - Function defining how to mutate the text style of each span.
   */
  private updateSelectedSpansStyle(updateCallback: (textStyle: RichEditorTextStyle) => void): void {
    if (!this.controller) {
      Logger.warn(TAG, 'Controller is not initialized.');
      return;
    }

    const selection = this.controller.getSelection();
    if (!selection || !selection.spans || selection.spans.length === 0) {
      return;
    }

    selection.spans.forEach((item: RichEditorTextSpanResult | RichEditorImageSpanResult) => {
      if (typeof (item as RichEditorTextSpanResult)['textStyle'] !== 'undefined') {
        const span = item as RichEditorTextSpanResult;
        const currentStyle = span.textStyle || {};

        // Execute the targeted mutation
        updateCallback(currentStyle);

        const start = span.offsetInSpan[0];
        const end = span.offsetInSpan[1];
        const offset = span.spanPosition.spanRange[0];

        // Apply updated style to the specific offset range
        this.controller.updateSpanStyle({
          start: offset + start,
          end: offset + end,
          textStyle: currentStyle
        });
      }
    });
  }

  /**
   * Toggles standard text styles (e.g., Bold, Italic, Color) for the current selection.
   */
  private toggleTextStyle(
    styleKey: 'fontWeight' | 'fontStyle' | 'fontColor',
    activeValue: FontWeight | FontStyle | ResourceColor,
    inactiveValue: FontWeight | FontStyle | ResourceColor
  ): void {
    this.updateSelectedSpansStyle((textStyle: RichEditorTextStyle) => {
      switch (styleKey) {
        case 'fontWeight':
          textStyle.fontWeight =
            (textStyle.fontWeight === activeValue) ? (inactiveValue as FontWeight) : (activeValue as FontWeight);
          break;
        case 'fontStyle':
          textStyle.fontStyle =
            (textStyle.fontStyle === activeValue) ? (inactiveValue as FontStyle) : (activeValue as FontStyle);
          break;
        case 'fontColor':
          textStyle.fontColor =
            (textStyle.fontColor === activeValue) ? (inactiveValue as ResourceColor) : (activeValue as ResourceColor);
          break;
        default:
          break;
      }
    });
  }

  /**
   * Toggles text decorations (e.g., Underline, Strikethrough) for the current selection.
   */
  private toggleTextDecoration(type: TextDecorationType): void {
    this.updateSelectedSpansStyle((textStyle: RichEditorTextStyle) => {
      if (textStyle.decoration) {
        textStyle.decoration.type = (textStyle.decoration.type === type)
          ? TextDecorationType.None
          : type;
      } else {
        textStyle.decoration = { type: type, color: Color.Black };
      }
    });
  }
}