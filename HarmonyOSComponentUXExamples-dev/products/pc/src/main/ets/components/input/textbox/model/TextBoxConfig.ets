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

/**
 * Layout styles for the file item
 */
export enum FileItemLayoutMode {
  LIST_ROW = 0, // Horizontal layout (Icon + Text + Time)
  GRID_COLUMN = 1 // Vertical layout (Large Icon above Text)
}

/**
 * Input behavior styles for the editable text
 */
export enum FileItemInputMode {
  SINGLE_LINE = 0, // maxLines: 1, ellipsis center
  SCROLLABLE_INLINE = 1, // maxLines: 3, word break
  MULTI_LINE_AREA = 2 // TextArea, scrollable, maxLines: 3
}