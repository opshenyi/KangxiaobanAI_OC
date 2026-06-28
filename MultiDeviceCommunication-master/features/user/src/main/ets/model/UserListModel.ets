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
import { BuildDirtyDataUtil } from 'commonmultidevicecommunication/src/main/ets/utils/BuildDirtyDataUtil';
import { UserModel } from 'commonmultidevicecommunication/src/main/ets/model/UserModel';

export class UserListModel {
  public users: UserModel[] = [];

  constructor(users: UserModel[]) {
    this.users = users;
  }

  loadUsers(): UserModel[] {
    this.users = [
      {
        name: $r('app.string.ZhangXM'),
        icon: $r('app.media.avatar1'),
        phoneNum: '12345678910',
        lastUpdate: [$r('app.media.social_circle1'),
          $r('app.media.social_circle2'),
          $r('app.media.social_circle3'),
          $r('app.media.social_circle6')]
      },

      {
        name: $r('app.string.LiuXX'),
        icon: $r('app.media.avatar2'),
        phoneNum: '12345678910',
        lastUpdate: [$r('app.media.social_circle1'),
          $r('app.media.social_circle2'),
          $r('app.media.social_circle3'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle5')]
      },

      {
        name: $r('app.string.DengSS'),
        icon: $r('app.media.avatar11'),
        phoneNum: '10987654321',
        lastUpdate: [$r('app.media.social_circle7'),
          $r('app.media.social_circle8'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle5'),
          $r('app.media.social_circle6')]
      },
      {
        name: $r('app.string.FenF'),
        icon: $r('app.media.avatar4'),
        phoneNum: '52541568203',
        lastUpdate: [$r('app.media.social_circle5'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle2')]
      },
      {
        name: $r('app.string.Jack'),
        icon: $r('app.media.avatar5'),
        phoneNum: '92042036410',
        lastUpdate: [$r('app.media.social_circle2'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle8'),
          $r('app.media.social_circle3')]
      },

      {
        name: $r('app.string.TongT'),
        icon: $r('app.media.avatar6'),
        phoneNum: '85206613470',
        lastUpdate: [$r('app.media.social_circle3'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle6'),
          $r('app.media.social_circle2'),
          $r('app.media.social_circle4')]
      },
      {
        name: $r('app.string.Tom'),
        icon: $r('app.media.avatar7'),
        phoneNum: '21053678106',
        lastUpdate: [$r('app.media.social_circle3'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle2')]
      },
      {
        name: $r('app.string.football'),
        icon: $r('app.media.avatar8'),
        phoneNum: '85203697410',
        lastUpdate: [$r('app.media.social_circle3'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle7')]
      },
      {
        name: $r('app.string.Lily'),
        icon: $r('app.media.avatar9'),
        phoneNum: '35279563104',
        lastUpdate: [$r('app.media.social_circle7'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle2'),
          $r('app.media.social_circle3'),
          $r('app.media.social_circle5')]
      },
      {
        name: $r('app.string.Jack2'),
        icon: $r('app.media.avatar10'),
        phoneNum: '96321478965',
        lastUpdate: [$r('app.media.social_circle7'),
          $r('app.media.social_circle1'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle8')]
      },
      {
        name: $r('app.string.ZhangXT'),
        icon: $r('app.media.avatar11'),
        phoneNum: '66665544111',
        lastUpdate: [$r('app.media.social_circle9'),
          $r('app.media.social_circle2'),
          $r('app.media.social_circle4'),
          $r('app.media.social_circle6'),
          $r('app.media.social_circle7'),
          $r('app.media.social_circle3')]
      },
      {
        name: $r('app.string.sport_club'),
        icon: $r('app.media.avatar1'),
        phoneNum: '52136412367',
        lastUpdate: [$r('app.media.social_circle7'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle8'),
          $r('app.media.social_circle4')]
      },
      {
        name: $r('app.string.alice'),
        icon: $r('app.media.avatar8'),
        phoneNum: '52136412367',
        lastUpdate: [$r('app.media.social_circle7'),
          $r('app.media.social_circle9'),
          $r('app.media.social_circle8'),
          $r('app.media.social_circle2')]
      }
    ];
    const dirtyName: string[] = BuildDirtyDataUtil.dirtyName;
    const dirtyIcon: string[] = BuildDirtyDataUtil.dirtyIcon;
    if (dirtyName.length === dirtyIcon.length) {
      for (let i = 0; i < dirtyName.length; i++) {
        this.users.push({
          name: dirtyName[i],
          icon: $r(dirtyIcon[i]),
          phoneNum: '12345678910',
          lastUpdate: [$r('app.media.social_circle7'),
            $r('app.media.social_circle8'),
            $r('app.media.social_circle9'),
            $r('app.media.social_circle4'),
            $r('app.media.social_circle5'),
            $r('app.media.social_circle6')]
        });
      }
    }
    return this.users;
  }
}