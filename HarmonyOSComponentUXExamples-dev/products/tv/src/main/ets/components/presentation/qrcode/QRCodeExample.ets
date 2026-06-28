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

import { ListGroupTitle } from '../../common/ListGroupTitle';
import { SubNavigationTitle } from '../../common/SubNavTitle';
import { SizeToken } from 'componentuxexamplesbase';
import { BasicQRCode } from './components/BasicQRCode';
import { WithAvatar } from './components/WithAvatar';
import { WithAppIcon } from './components/WithAppIcon';
import { CustomQRCode } from './components/CustomQRCode';
import { ErrorQRCode } from './components/ErrorQRCode';
import { LoadingQRCode } from './components/LoadingQRCode';

@Builder
export function QRCodeExampleBuilder() {
  QRCodeExample()
}

@ComponentV2
struct QRCodeExample {
  private value: string = 'Hello World';

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          ListGroupTitle($r('app.string.basic_style_label'))
          BasicQRCode(this.value)
          ListGroupTitle($r('app.string.qrcode_with_avatar_label'))
          WithAvatar(this.value)
          ListGroupTitle($r('app.string.qrcode_with_app_icon_label'))
          WithAppIcon(this.value)
          ListGroupTitle($r('app.string.qrcode_loading_status_label'))
          LoadingQRCode(this.value)
          ListGroupTitle($r('app.string.qrcode_error_status_label'))
          ErrorQRCode(this.value)
          ListGroupTitle($r('app.string.qrcode_custom_effect_label'))
          CustomQRCode(this.value)
        }
      }
      .height(SizeToken.SIZE_PERCENT_100)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .fadingEdge(true)
      .padding({
        left: $r('app.float.page_padding'),
        right: $r('app.float.page_padding'),
        top: $r('sys.float.padding_level8'),
        bottom: $r('sys.float.padding_level11')
      })
    }
    .title({
      builder: SubNavigationTitle($r('app.string.qrcode_title_label')),
      height: $r('app.float.nav_height')
    })
  }
}