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
import {
  BreakpointModel,
  CommonUtils,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken,
  SubTitleView
} from 'componentuxexamplesbase';

/**
 * Interface defining the parameters for the IconItem builder.
 */
interface IconItemParams {
  /**
   * The color resource for the icon symbol.
   */
  iconColor: Resource;

  /**
   * The style mode of the button (e.g., EMPHASIZED, NORMAL, TEXTUAL).
   */
  btnStyle: ButtonStyleMode;

  /**
   * The descriptive text displayed below the button.
   */
  label: Resource;

  /**
   * Indicates whether the button is interactive. Defaults to true.
   */
  isEnabled?: boolean;

  /**
   * Indicates whether the button contains inner text below the icon. Defaults to false.
   */
  hasInnerLabel?: boolean;
}

function isEnabled(params: IconItemParams): boolean {
  return params.isEnabled ?? true;
}

function hasInnerLabel(params: IconItemParams): boolean {
  return params.hasInnerLabel ?? false;
}

/**
 * A reusable builder component that generates a customized icon button
 * along with its descriptive bottom label.
 * * @param params - The configuration object for the icon button.
 */
@Builder
function IconItem(params: IconItemParams) {
  Column({ space: SpaceToken.SPACE_8 }) {
    Button({ type: ButtonType.Circle }) {
      if (hasInnerLabel(params)) {
        // Layout for icon with inner text
        Column({ space: SpaceToken.SPACE_2 }) {
          SymbolGlyph($r('sys.symbol.bell'))
            .fontColor([params.iconColor])
            .fontSize($r('sys.float.Title_M'))

          Text('Text')
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_S'))
        }
      } else {
        // Layout for icon only
        SymbolGlyph($r('sys.symbol.bell'))
          .fontColor([params.iconColor])
          .fontSize($r('sys.float.Title_M'))
      }
    }
    .buttonStyle(params.btnStyle)
    .width(SizeToken.SIZE_NUM_40)
    .height(SizeToken.SIZE_NUM_40)
    .stateEffect(isEnabled(params))
    .hoverEffect(isEnabled(params) ? HoverEffect.Auto : HoverEffect.None)
    .enabled(isEnabled(params))

    // Descriptive label below the button
    Text(params.label)
      .fontColor($r('sys.color.font_secondary'))
      .fontSize($r('sys.float.Subtitle_S'))
      .lineHeight(SizeToken.SIZE_NUM_19)
  }
  .width(SizeToken.SIZE_NUM_60)
  .onClick(() => {
    // Only trigger the toast event if the button is enabled
    if (isEnabled(params)) {
      CommonUtils.showToast(params.label);
    }
  })
}

/**
 * Reusable text style extension for section subtitles.
 */
@Extend(Text)
function sectionTitleStyle() {
  .fontSize($r('sys.float.Subtitle_S'))
  .fontColor($r('sys.color.font_secondary'))
  .lineHeight(SizeToken.SIZE_NUM_19)
  .fontWeight(FontWeight.Medium)
  .width(SizeToken.SIZE_PERCENT_100)
  .margin({ top: PaddingToken.PADDING_12VP })
}

@ComponentV2
export struct IconButton {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      SubTitleView($r('app.string.icon_button_label'))
      Column({ space: SpaceToken.SPACE_16 }) {

        // --- Normal Status Section ---
        Text($r('app.string.button_type_or_normal_label')).sectionTitleStyle()

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          IconItem({
            iconColor: $r('sys.color.icon_on_primary'),
            btnStyle: ButtonStyleMode.EMPHASIZED,
            label: $r('app.string.emphasize_the_background_label')
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.NORMAL,
            label: $r('app.string.plain_background_label')
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.TEXTUAL,
            label: $r('app.string.icon_only_label')
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.TEXTUAL,
            label: $r('app.string.with_text_label'),
            hasInnerLabel: true
          })
        }

        // --- Disabled Status Section ---
        Text($r('app.string.disabled_status_label')).sectionTitleStyle()

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          IconItem({
            iconColor: $r('sys.color.icon_on_primary'),
            btnStyle: ButtonStyleMode.EMPHASIZED,
            label: $r('app.string.emphasize_the_background_label'),
            isEnabled: false
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.NORMAL,
            label: $r('app.string.plain_background_label'),
            isEnabled: false
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.TEXTUAL,
            label: $r('app.string.icon_only_label'),
            isEnabled: false
          })
          IconItem({
            iconColor: $r('sys.color.icon_secondary'),
            btnStyle: ButtonStyleMode.TEXTUAL,
            label: $r('app.string.with_text_label'),
            isEnabled: false,
            hasInnerLabel: true
          })
        }
      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_20)
      .padding({
        left: this.breakpointModel.getValue({
          sm: PaddingToken.PADDING_12VP,
          md: PaddingToken.PADDING_16VP,
          lg: PaddingToken.PADDING_16VP
        }),
        right: this.breakpointModel.getValue({
          sm: PaddingToken.PADDING_12VP,
          md: PaddingToken.PADDING_16VP,
          lg: PaddingToken.PADDING_16VP
        }),
        top: PaddingToken.PADDING_16VP,
        bottom: PaddingToken.PADDING_16VP
      })
    }
  }
}