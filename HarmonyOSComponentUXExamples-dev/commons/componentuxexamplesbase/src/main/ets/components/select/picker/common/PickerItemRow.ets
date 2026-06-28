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
import { CommonConstants } from '../../../../constants/CommonConstants';
import { CornerRadiusToken } from '../../../../designtoken/CornerRadiusToken';
import { PaddingToken } from '../../../../designtoken/PaddingToken';
import { SizeToken } from '../../../../designtoken/SizeToken';

@ComponentV2
export struct PickerItemRow {
  @Require @Param label: ResourceStr;
  @Require @Param value: string;
  @Require @Param onClickAction: () => void;

  build() {
    Row() {
      Text(this.label)
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Text(this.value)
        .fontSize($r('sys.float.Body_M'))
        .fontColor($r('sys.color.font_secondary'))
        .fontWeight(FontWeight.Regular)
        .maxLines(CommonConstants.TEXT_MAX_LINES_1)
        .constraintSize({ maxWidth: SizeToken.SIZE_PERCENT_60 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.End)
        .margin({ right: PaddingToken.PADDING_4VP })

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_16)
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_56)
    .padding({
      left: PaddingToken.PADDING_12VP,
      right: PaddingToken.PADDING_12VP
    })
    .onClick(() => {
      this.onClickAction();
    })
  }
}