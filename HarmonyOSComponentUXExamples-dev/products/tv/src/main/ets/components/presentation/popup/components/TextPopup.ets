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

import { CommonItem } from '../../../common/CommonItem';

@ComponentV2
export struct TextPopup {
  @Local handlePopup: boolean = false;

  build() {
    CommonItem({ val: $r('app.string.pointer_style_popup_label') })
      .onClick(() => {
        this.handlePopup = !this.handlePopup;
      })
      .bindPopup(this.handlePopup, {
        // Bubble message content
        message: 'This is a popup with PopupOptions',
        // Set the display position of the Popup component relative to the host node CommonItem
        placement: Placement.Bottom,
        // Bubble state change event callback
        onStateChange: (event) => {
          // When the bubble is not displayed, set handlePopup to false
          if (!event.isVisible) {
            this.handlePopup = false;
          }
        }
      })
  }
}