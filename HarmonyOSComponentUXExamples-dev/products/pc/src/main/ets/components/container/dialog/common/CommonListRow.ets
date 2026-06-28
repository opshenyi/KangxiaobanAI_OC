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
import { CornerRadiusToken, PaddingToken, SizeToken } from 'componentuxexamplesbase';

/**
 * A highly reusable list row component for standardized UI/UX design.
 * Supports a title, optional custom right-side content, and an optional chevron icon.
 */
@ComponentV2
export struct CommonListRow {
  @Param title: ResourceStr = '';
  // Local state for managing mouse hover interactions
  @Local isHovered: boolean = false;
  // Check if the current list item is being pressed
  @Local isPressed: boolean = false;

  // Feature enhancement: Toggle the default right arrow
  @Param showRightIcon: boolean = true;

  // Feature enhancement: Inject custom UI elements on the right side
  @BuilderParam rightContent?: () => void;

  @Param rowBorderRadius: Length | BorderRadiuses | LocalizedBorderRadiuses = CornerRadiusToken.CORNER_RADIUS_16;
  @Param rowPadding: Length | Padding | LocalizedPadding = PaddingToken.PADDING_4VP;

  @Event onClickAction: () => void = () => {};

  /**
   * Computes the background color for the outer Column
   * Handles hover and selected state interactions on PC
   */
  @Computed
  get rowBackgroundColor(): ResourceColor {
    if (this.isPressed) {
      return $r('sys.color.interactive_pressed');
    }
    if (this.isHovered) {
      return $r('sys.color.interactive_hover');
    }
    return Color.Transparent;
  }

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        Blank()

        // Render injected custom content if provided
        if (this.rightContent) {
          this.rightContent()
        }

        // Render default chevron if enabled
        if (this.showRightIcon) {
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_fourth')])
        }
      }
      .width(SizeToken.SIZE_PERCENT_100)
      .height(SizeToken.SIZE_PERCENT_100)
      .backgroundColor(this.rowBackgroundColor)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .padding({
        left: PaddingToken.PADDING_8VP,
        right: PaddingToken.PADDING_8VP
      })
    }
    .borderRadius(this.rowBorderRadius)
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .padding(PaddingToken.PADDING_4VP)
    .onClick(() => {
      this.onClickAction();
    })
    // Listens for mouse hover events on PC to update local state
    .onHover((isHover: boolean) => {
      this.isHovered = isHover;
    })
    .onTouch((event: TouchEvent) => {
      // Update the pressed state based on the touch event type
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else {
        this.isPressed = false;
      }
    })
  }
}