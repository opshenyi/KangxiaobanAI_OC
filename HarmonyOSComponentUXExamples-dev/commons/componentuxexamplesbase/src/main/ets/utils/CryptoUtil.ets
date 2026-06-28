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
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import Logger from './Logger';

export class CryptoUtil {
  // Static variable initialized as null
  private static rand: cryptoFramework.Random | null = null;

  /**
   * Synchronously generates a secure random integer within the specified range [min, max]
   * @param min Minimum value (inclusive)
   * @param max Maximum value (inclusive)
   * @returns number Generated random integer. Returns -1 in exceptional cases.
   * @throws Error When min is greater than max (invalid range)
   */
  public static generateRangeRandomSync(min: number, max: number): number {
    // Basic validation
    if (min > max) {
      throw new Error(`Invalid range: min (${min}) cannot be greater than max (${max})`);
    }
    if (min === max) {
      return min;
    }
    try {
      // Instance reuse: call singleton getter method
      const rand = CryptoUtil.getRandomInstance();
      // Synchronously generate 4 bytes (32 bits) of random data
      const len = 4;
      const blob = rand.generateRandomSync(len);
      // Data conversion (Uint8Array -> Uint32)
      // Validate data integrity
      if (!blob || !blob.data) {
        throw new Error('Failed to generate random blob');
      }
      const dataView = new DataView(blob.data.buffer);
      // Read 32-bit unsigned integer from buffer offset 0
      const randomInt32 = dataView.getUint32(0);
      // Range mapping
      const range = max - min + 1;
      const result = (randomInt32 % range) + min;
      return result;
    } catch (error) {
      Logger.error(`generateRangeRandomSync error: ${JSON.stringify(error)}`);
      // Fallback strategy: return -1 for critical errors
      return -1;
    }
  }

  /**
   * Internal private method: retrieves singleton Random instance
   * Implements lazy initialization - created only on first access
   * @returns cryptoFramework.Random Random instance
   * @throws Error When failed to create Random instance
   * @private
   */
  private static getRandomInstance(): cryptoFramework.Random {
    if (!CryptoUtil.rand) {
      try {
        CryptoUtil.rand = cryptoFramework.createRandom();
      } catch (error) {
        Logger.error(`CryptoFramework createRandom failed: ${JSON.stringify(error)}`);
        throw new Error('Failed to create Random instance');
      }
    }
    return CryptoUtil.rand;
  }
}