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
import { CommonUtils } from 'componentuxexamplesbase';

export interface FileItemTypes {
  id?: string;
  fileName: string;
  fileTime?: string;
  icon: Resource;
}

/**
 * File Data Model
 */
@ObservedV2
export class FileItemModel {
  // Stable and immutable unique identifier
  public readonly id: string;
  @Trace public fileName: string;
  @Trace public fileTime: string;
  @Trace public icon: Resource;

  constructor(param: FileItemTypes) {
    this.id = param.id ?? util.generateRandomUUID(true);
    this.fileName = param.fileName;
    this.fileTime = param.fileTime ?? CommonUtils.getCurrentFormattedTime();
    this.icon = param.icon;
  }
}