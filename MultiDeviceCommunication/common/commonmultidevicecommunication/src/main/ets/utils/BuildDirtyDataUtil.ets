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

export class BuildDirtyDataUtil {
  public static dirtyName: string[] = ['Alice', 'Amy', 'Andy'];
  public static dirtyIcon: string[] = [];
  private static readonly DIRTY_COUNT: number = 24;

  public static buildDirtyData(): void {
    BuildDirtyDataUtil.changeData(0, BuildDirtyDataUtil.dirtyName);
    for (let i = 0; i < BuildDirtyDataUtil.dirtyName.length / 6; i++) {
      for (let j = 1; j <= 6; j++) {
        BuildDirtyDataUtil.dirtyIcon.push('app.media.avatar' + j);
      }
    }
  }

  private static changeData(count: number, dirtyDataInit: string[]): void {
    if (count > BuildDirtyDataUtil.DIRTY_COUNT) {
      return;
    }
    let result: string[] = [];
    for (let dirty of dirtyDataInit) {
      result.push(String.fromCharCode(dirty.charCodeAt(0) + 1) + dirty.substring(1));
    }
    BuildDirtyDataUtil.dirtyName.push(...result);
    count++;
    BuildDirtyDataUtil.changeData(count, result);
  }
}