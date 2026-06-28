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
import { BreakpointTypes } from './BreakpointType';
import { WindowInfo } from './WindowInfo';

@ObservedV2
export class BreakpointModel {
  private static singleton_: BreakpointModel;
  @Trace public currentWidthBreakpoint: WidthBreakpoint = WidthBreakpoint.WIDTH_SM;
  @Trace public currentHeightBreakpoint: HeightBreakpoint = HeightBreakpoint.HEIGHT_SM;
  @Trace public currentGridColumn: string = '1fr 1fr';
  @Trace public currentNavigationMode: NavigationMode = NavigationMode.Auto;
  @Trace public windowInfo: WindowInfo = new WindowInfo();

  private constructor() {
  }

  public static getInstance() {
    if (!BreakpointModel.singleton_) {
      BreakpointModel.singleton_ = new BreakpointModel();
    }
    return BreakpointModel.singleton_;
  }

  /**
   * Returns the corresponding value from the provided options based on the current width breakpoint.
   */
  getValue<T>(param: BreakpointTypes<T>): T {
    switch (this.currentWidthBreakpoint) {
      case WidthBreakpoint.WIDTH_XS:
        return param.xs ?? param.sm;
      case WidthBreakpoint.WIDTH_SM:
        return param.sm;
      case WidthBreakpoint.WIDTH_MD:
        return param.md;
      case WidthBreakpoint.WIDTH_LG:
        return param.lg;
      default:
        return param.xl ?? param.lg;
    }
  }

  /**
   * Checks if the current device is considered a small screen.
   * A screen is considered small if the width breakpoint is WIDTH_XS or WIDTH_SM.
   * @returns {boolean} True if the current screen is small, false otherwise.
   */
  public isSmallScreen(): boolean {
    return this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_XS ||
      this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_SM;
  }

  /**
   * Checks if the current device is considered a middle screen.
   * A screen is considered middle if the width breakpoint is WIDTH_MD.
   * @returns {boolean} True if the current screen is middle, false otherwise.
   */
  public isMiddleScreen(): boolean {
    return this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_MD;
  }

  /**
   * Checks if the current device is considered a large screen.
   * A screen is considered large if the width breakpoint is WIDTH_MD or WIDTH_LG.
   * @returns {boolean} True if the current screen is large, false otherwise.
   */
  public isMiddleOrLargeScreen(): boolean {
    return this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_MD ||
      this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_LG;
  }

  /**
   * Checks if the current device is considered an extra large screen.
   * A screen is considered extra large if the width breakpoint is WIDTH_XL.
   * @returns {boolean} True if the current screen is extra large, false otherwise.
   */
  public isExtraLargeScreen(): boolean {
    return this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_XL;
  }

  /**
   * Checks if the current device is considered a large or extra large screen.
   * A screen is considered large if the width breakpoint is WIDTH_LG or WIDTH_XL.
   * @returns {boolean} True if the current screen is large or extra large, false otherwise.
   */
  public isLargeOrExtraLargeScreen(): boolean {
    return this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_LG ||
      this.currentWidthBreakpoint === WidthBreakpoint.WIDTH_XL;
  }

  /**
   * Determines whether the back button should be hidden based on the current screen size.
   * The back button is hidden on non-small screens (e.g., tablets or larger devices)
   * and remains visible on small screens (e.g., mobile phones).
   * @returns {boolean} True if the back button should be hidden, false if it should be visible.
   */
  public shouldHideBackButton(): boolean {
    if (this.isSmallScreen()) {
      return false;
    }
    return true;
  }
}