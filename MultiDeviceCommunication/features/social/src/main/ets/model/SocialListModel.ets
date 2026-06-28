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
import { SocialModel } from './SocialModel';

export default class SocialListModel {
  public socials: SocialModel[] = [];

  constructor(socials: SocialModel[]) {
    this.socials = socials;
  }

  loadSocials(): SocialModel[] {
    let social: SocialModel = {
      name: $r('app.string.social_name'),
      icon: $r('app.media.icon_avatar'),
      msg: $r('app.string.social_msg'),
      time: $r('app.string.social_time'),
      common: $r('app.string.social_common'),
      lastUpdate: [$r('app.media.social_circle7'),
        $r('app.media.social_circle8'),
        $r('app.media.social_circle9'),
        $r('app.media.social_circle4'),
        $r('app.media.social_circle5'),
        $r('app.media.social_circle6')]
    }
    for (let i = 0; i < 10; i++) {
      this.socials.push(social);
    }
    return this.socials;
  }
}