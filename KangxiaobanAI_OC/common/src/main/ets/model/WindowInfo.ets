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

import { window } from '@kit.ArkUI';
import { ImmersiveType } from '../constants/CommonEnums';

@ObservedV2
export class WindowInfo {
  // Window status.
  @Trace public windowStatusType: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
  // Is the window an immersive layout.
  @Trace public isImmersive: ImmersiveType = ImmersiveType.NORMAL;
  // Window orientation.
  @Trace public orientation: window.Orientation = window.Orientation.UNSPECIFIED;
  // Window size.(unit: px)
  @Trace public windowSize: window.Size = { width: 0, height: 0 };
  // Top status bar height.(unit: px)
  @Trace public statusBarHeight: number = 0;
  // The height of the navigation bar area.(unit: px)
  @Trace public navAvoidAreaHeight: number = 0;
  // Navigation bar bottom height in vp for responsive layout.(unit: vp)
  @Trace public navigationBarBottomVp: number = 0;
  // used to obtain the height of the window's title bar
  @Trace public decorHeight: number = 0;
}