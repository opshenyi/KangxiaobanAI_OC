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
import { PaddingToken } from '../designtoken/PaddingToken';
import { SizeToken } from '../designtoken/SizeToken';

export interface SubTitleTypes {
  val: ResourceStr;
  leftPadding ?: Length;
  bgColor ?: ResourceColor;
  topPadding ?: Length;
}


@Builder
export function SubTitleView(val: ResourceStr, leftPadding: Length | undefined = PaddingToken.PADDING_12VP,
  bgColor?: ResourceColor) {
  Row() {
    Text(val)
      .fontSize($r('sys.float.Subtitle_S'))
      .fontColor($r('sys.color.font_secondary'))
      .lineHeight(SizeToken.SIZE_NUM_20)
      .fontWeight(FontWeight.Medium)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .padding({
    left: leftPadding,
    top: PaddingToken.PADDING_28VP,
    bottom: PaddingToken.PADDING_8VP
  })
  .backgroundColor(bgColor)
}

@Builder
export function SubTitleViewV2(param: SubTitleTypes) {
  Row() {
    Text(param.val)
      .fontSize($r('sys.float.Subtitle_S'))
      .fontColor($r('sys.color.font_secondary'))
      .lineHeight(SizeToken.SIZE_NUM_20)
      .fontWeight(FontWeight.Medium)
  }
  .width(SizeToken.SIZE_PERCENT_100)
  .padding({
    left: param.leftPadding ?? PaddingToken.PADDING_12VP,
    top: param.topPadding ?? PaddingToken.PADDING_28VP,
    bottom: PaddingToken.PADDING_8VP
  })
  .backgroundColor(param.bgColor)
}