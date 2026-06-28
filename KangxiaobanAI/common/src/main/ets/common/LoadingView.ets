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
import { SizeToken } from '../designtoken/SizeToken';
import { BreakpointType } from '../model/BreakpointType';

@Builder
export function LoadingView(breakpoint: WidthBreakpoint) {
  Column() {
    Row() {
      LoadingProgress()
    }
    .width(new BreakpointType({
      sm: SizeToken.SIZE_NUM_72,
      md: SizeToken.SIZE_NUM_100,
      lg: SizeToken.SIZE_NUM_100
    }).getValue(breakpoint))
    .aspectRatio(1)

    Text('Loading...')
      .fontSize($r('sys.float.Body_M'))
      .fontColor($r('sys.color.font_secondary'))
      .margin($r('sys.float.padding_level12'))
  }
  .alignItems(HorizontalAlign.Center)
  .justifyContent(FlexAlign.Center)
  .backgroundColor($r('sys.color.background_secondary'))
  .height(SizeToken.SIZE_PERCENT_100)
  .width(SizeToken.SIZE_PERCENT_100)
}