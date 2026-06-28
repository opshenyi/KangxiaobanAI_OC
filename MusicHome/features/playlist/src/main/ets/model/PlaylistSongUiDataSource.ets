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


import { PlaylistSongUi } from './PlaylistUiModels';

/**
 * {@link IDataSource} adapter exposing {@link PlaylistSongUi} rows to LazyForEach lists.
 */
export class PlaylistSongUiDataSource implements IDataSource {
  /** Backing array of UI song models. */
  private dataArray: PlaylistSongUi[] = [];
  /** Registered list data change listeners. */
  private listeners: DataChangeListener[] = [];

  /**
   * Copies the given songs into an internal array for lazy list consumption.
   * @param element Initial playlist song UI items.
   */
  public constructor(element: PlaylistSongUi[]) {
    for (let index = 0; index < element.length; index++) {
      this.dataArray.push(element[index]);
    }
  }

  /**
   * Returns the number of items in the data source.
   * @returns Total row count.
   */
  public totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * Returns the song UI model at the given index.
   * @param index Zero-based index into the backing array.
   * @returns The {@link PlaylistSongUi} at the given index.
   */
  public getData(index: number): PlaylistSongUi {
    return this.dataArray[index];
  }

  /**
   * Registers a listener to be notified when list data changes.
   * @param listener Data change listener instance.
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  /**
   * Removes a previously registered data change listener.
   * @param listener Listener instance to unregister.
   */
  public unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }
}
