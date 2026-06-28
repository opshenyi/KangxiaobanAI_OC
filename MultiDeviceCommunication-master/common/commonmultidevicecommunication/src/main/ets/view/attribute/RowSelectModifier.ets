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
import { RowModifier } from '@kit.ArkUI';
import { CommonConstants } from '../../../../../Index';
import { WidthBreakpointType } from '../../model/WidthBreakpointType';

export class RowSelectModifier implements AttributeModifier<RowModifier> {
  private type: number = 0;
  private widthBreakpoint: WidthBreakpoint = WidthBreakpoint.WIDTH_LG;
  private selectedIndex: string = '';
  private index: string = '';

  constructor(type: number, widthBreakpoint: WidthBreakpoint, selectedIndex: string, index: string) {
    this.type = type;
    this.widthBreakpoint = widthBreakpoint;
    this.selectedIndex = selectedIndex;
    this.index = index;
  }

  applyNormalAttribute(instance: RowModifier): void {
    if (this.widthBreakpoint !== WidthBreakpoint.WIDTH_SM) {
      instance
        .backgroundColor(this.selectedIndex === this.index ? $r('app.color.comp_emphasize_tertiary') :
          $r('app.color.background_primary'))
    }
    if (this.type === CommonConstants.TAB_MESSAGE_INDEX) {
      instance
        .margin({
          left: new WidthBreakpointType(8, 12, 16, 12).getValue(this.widthBreakpoint),
          right: new WidthBreakpointType(8, 12, 16, 12).getValue(this.widthBreakpoint)
        })
    }
  }
}