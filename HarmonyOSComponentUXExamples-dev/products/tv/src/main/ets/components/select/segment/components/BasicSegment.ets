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

import { SegmentButtonV2Items, TabSegmentButtonV2 } from '@kit.ArkUI';

@ComponentV2
export struct BasicSegment {
  @Local segmentSelectedIndex: number = 0;
  @Local segmentItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    // Set segmented button option text
    { text: $r('app.string.segment_button_item_label') },
    { text: $r('app.string.segment_button_item_label') },
    { text: $r('app.string.segment_button_item_label') },
    { text: $r('app.string.segment_button_item_label') }
  ]);

  build() {
    TabSegmentButtonV2({
      items: this.segmentItems,
      selectedIndex: this.segmentSelectedIndex!!
    })
  }
}