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
import { util } from '@kit.ArkTS';

export interface GridItemDataType {
  id?: string;
  title?: ResourceStr;
  imageRes: Resource;
  subtitle?: ResourceStr;
}

@ObservedV2
export class GridItemData {
  public readonly id: string;
  @Trace public title: ResourceStr;
  @Trace public imageRes: Resource;
  @Trace public subtitle: ResourceStr;

  constructor(param: GridItemDataType) {
    this.id = param.id ?? util.generateRandomUUID(true);
    this.title = param.title ?? $r('app.string.title_label');
    this.imageRes = param.imageRes;
    this.subtitle = param.subtitle ?? $r('app.string.description_label');
  }
}