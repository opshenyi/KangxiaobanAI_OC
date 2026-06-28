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
import {
  CommonConstants,
  ComponentItem,
  CornerRadiusToken,
  PaddingToken,
  SizeToken,
  SpaceToken
} from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';

@Builder
export function QRCodeCollectBuilder() {
  QRCodeCollect()
}

@ComponentV2
struct QRCodeCollect {
  @Local private param: ComponentItem = {
    id: '',
    name: '',
    url: ''
  };
  context: UIContext = this.getUIContext();
  private value: string = 'Hello HarmonyOS, I\'m excited to explore your smooth and connected features.';
  private timeoutId: number = -1;
  @Local isExpired: boolean = true;

  @Builder
  BaseStyleQRCode() {
    Column() {
      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
      }
      .width(SizeToken.SIZE_NUM_132)
      .height(SizeToken.SIZE_NUM_132)
      .margin({ top: SizeToken.SIZE_NUM_12 })
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      Text($r('app.string.scan_view_details'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('app.color.gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_8 })
    }.justifyContent(FlexAlign.Center)
  }

  @Builder
  AvatarStyleQRCode() {
    Column() {
      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)

        Image($r('app.media.avatar1'))
          .width(SizeToken.SIZE_NUM_42)
          .height(SizeToken.SIZE_NUM_42)
          .margin({ bottom: SizeToken.SIZE_NUM_12 })
          .padding(PaddingToken.PADDING_2VP)
          .borderRadius(SizeToken.SIZE_NUM_42)
          .backgroundColor(Color.White)
      }
      .width(SizeToken.SIZE_NUM_132)
      .height(SizeToken.SIZE_NUM_132)
      .margin({ top: SizeToken.SIZE_NUM_12 })
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      Text($r('app.string.scan_view_details'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('app.color.gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_8 })
    }.justifyContent(FlexAlign.Center)
  }

  @Builder
  IconStyleQRCode() {
    Column() {
      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)

        Image($r('app.media.weather'))
          .width(SizeToken.SIZE_NUM_42)
          .height(SizeToken.SIZE_NUM_42)
          .margin({ bottom: SizeToken.SIZE_NUM_12 })
          .padding(PaddingToken.PADDING_2VP)
          .borderRadius(SizeToken.SIZE_NUM_12)
          .backgroundColor(Color.White)
      }
      .width(SizeToken.SIZE_NUM_132)
      .height(SizeToken.SIZE_NUM_132)
      .margin({ top: SizeToken.SIZE_NUM_12 })
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      Text($r('app.string.scan_view_details'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('app.color.gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_8 })
    }.justifyContent(FlexAlign.Center)
  }

  @Builder
  LoadingStatusQRCode() {
    Column() {
      Stack() {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
          .contentOpacity(0.1)

        LoadingProgress()
          .width(SizeToken.SIZE_NUM_30)
          .height(SizeToken.SIZE_NUM_30)
          .color($r('app.color.light_blue_color'))
      }
      .width(SizeToken.SIZE_NUM_132)
      .height(SizeToken.SIZE_NUM_132)
      .margin({ top: SizeToken.SIZE_NUM_12 })
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      Text($r('app.string.scan_view_details'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('app.color.gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_8 })
    }.justifyContent(FlexAlign.Center)
  }

  @Builder
  ErrorStatusQRCode() {
    Column() {

      Stack({ alignContent: Alignment.Bottom }) {
        QRCode(this.value)
          .width(SizeToken.SIZE_PERCENT_100)
          .height(SizeToken.SIZE_PERCENT_100)
          .contentOpacity(this.isExpired ? 0.1 : 1.0)
          .animation({ duration: CommonConstants.DURATION_300, curve: Curve.EaseInOut })
        if (this.isExpired) {
          Column({ space: SpaceToken.SPACE_8_point_75VP }) {
            SymbolGlyph($r('sys.symbol.arrow_clockwise'))
              .fontSize($r('sys.float.Title_L'))

            Text($r('app.string.expiration_prompt_message_en_label'))
              .fontSize($r('sys.float.Body_L'))
              .fontColor('#e5000000')
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
          }
          .margin({ bottom: PaddingToken.PADDING_22_point_75VP })
          .transition(TransitionEffect.OPACITY)
          .onClick(() => {
            this.refreshQRCode();
          })
        }
      }
      .width(SizeToken.SIZE_NUM_132)
      .height(SizeToken.SIZE_NUM_132)
      .margin({ top: SizeToken.SIZE_NUM_12 })
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_12)
      .backgroundColor($r('sys.color.icon_on_primary'))
      .padding(PaddingToken.PADDING_12_point_75VP)

      Text($r('app.string.scan_view_details'))
        .fontSize($r('sys.float.Title_S'))
        .fontColor($r('app.color.gray_color'))
        .margin({ top: SizeToken.SIZE_NUM_8 })
    }.justifyContent(FlexAlign.Center)
  }

  private clearTimer(): void {
    if (this.timeoutId !== -1) {
      clearTimeout(this.timeoutId);
      this.timeoutId = -1;
    }
  }

  private refreshQRCode(): void {
    this.clearTimer();
    this.isExpired = false;
    this.value = `Hello HarmonyOS_${Date.now()}`;
    this.timeoutId = setTimeout(() => {
      this.isExpired = true;
    }, 5000);
  }

  aboutToDisappear(): void {
    this.clearTimer();
  }

  build() {
    NavDestination() {
      Column() {
        TitleComponent(this.param.name)
        if (this.param.id === 'style_base') {
          this.BaseStyleQRCode()
        }
        if (this.param.id === 'avatar_style_qrcode') {
          this.AvatarStyleQRCode()
        }
        if (this.param.id === 'icon_style_qrcode') {
          this.IconStyleQRCode()
        }
        if (this.param.id === 'loading_status') {
          this.LoadingStatusQRCode()
        }
        if (this.param.id === 'error_status') {
          this.ErrorStatusQRCode()
        }
      }
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
    })
  }
}