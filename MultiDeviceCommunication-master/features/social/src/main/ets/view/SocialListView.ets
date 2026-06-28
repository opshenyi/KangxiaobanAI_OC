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
import { uiObserver } from '@kit.ArkUI';
import { WidthBreakpointType } from 'commonmultidevicecommunication';
import { SocialModel } from '../model/SocialModel';
import SocialListViewModel from '../viewmodel/SocialListViewModel'

@ComponentV2
export struct SocialListView {
  @Env(SystemProperties.BREAK_POINT) breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;
  @Local socialsViewModel: SocialListViewModel = new SocialListViewModel();

  aboutToAppear(): void {
    this.socialsViewModel.loadSocials();
  }

  build() {
    List({ space: 24 }) {
      ForEach(this.socialsViewModel.socials, (item: SocialModel) => {
        ListItem() {
          SocialView({ social: item, breakpoint: this.breakpoint })
        }
      }, (item: SocialModel, index: number) => index + JSON.stringify(item))
    }
    .padding({
      left: new WidthBreakpointType(16, 24, 32, 24).getValue(this.breakpoint.widthBreakpoint),
      right: new WidthBreakpointType(16, 24, 32, 24).getValue(this.breakpoint.widthBreakpoint)
    })
    .backgroundColor($r('app.color.background_primary'))
    .scrollBar(BarState.Off)
  }
}

@ComponentV2
export struct SocialView {
  @Require @Param social: SocialModel;
  @Require @Param breakpoint: uiObserver.WindowSizeLayoutBreakpointInfo;

  build() {
    Row() {
      Image($r('app.media.icon_avatar'))
        .width(40)
        .height(40)
        .borderRadius(5)
      Column() {
        Text(this.social.name)
          .fontSize(16)
          .lineHeight(21)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.social_name_color'))
        Text(this.social.msg)
          .fontSize(16)
          .lineHeight(21)
          .fontWeight(FontWeight.Regular)
          .fontColor($r('app.color.social_msg_color'))
          .margin({ top: 2 })
        Grid() {
          ForEach(this.social.lastUpdate, (item: Resource) => {
            GridItem() {
              Image(item)
                .objectFit(ImageFit.Cover)
            }
          }, (item: number, index: number) => JSON.stringify(item) + index)
        }
        .layoutDirection(GridDirection.Row)
        .rowsTemplate('1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr')
        .rowsGap(5)
        .columnsGap(5)
        .width(this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_LG ||
          this.breakpoint.widthBreakpoint === WidthBreakpoint.WIDTH_XL ? '65%' : '100%')
        .aspectRatio(1.5)
        .margin({ top: 8 })

        Row() {
          Text(this.social.time)
            .fontSize(14)
            .lineHeight(19)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Blank()
          Column() {
            SymbolGlyph($r('sys.symbol.dot_grid_1x2'))
          }
          .justifyContent(FlexAlign.Center)
          .width(24)
          .height(24)
          .borderRadius(4)
          .backgroundColor($r('app.color.background_secondary'))
        }
        .width('100%')
        .padding({ right: 10 })
        .margin({ top: 8 })

        Column() {
          Column() {
            Row() {
              SymbolGlyph($r('sys.symbol.heart'))
                .width(18)
                .height(18)
                .fontColor([$r('app.color.social_msg_color')])
              Text($r('app.string.social_common_name'))
                .fontSize(14)
                .lineHeight(17)
                .fontWeight(FontWeight.Regular)
                .fontColor($r('app.color.social_name_color'))
            }
            .width('100%')
            .margin({ top: 8 })

            Row()
              .width('100%')
              .height('1px')
              .backgroundColor($r('app.color.social_divider_color'))
              .margin({ top: 8 })

            Row() {
              Text($r('app.string.social_common'))
                .fontSize(14)
                .lineHeight(17)
                .fontWeight(FontWeight.Regular)
                .fontColor($r('app.color.social_name_color'))

            }
            .width('100%')
            .margin({ top: 8 })
          }
          .padding({ left: 8, right: 8 })
          .width('100%')
          .height(new WidthBreakpointType(88, 69, 69, 69).getValue(this.breakpoint.widthBreakpoint))
          .borderRadius(4)
          .backgroundColor($r('app.color.background_secondary'))
        }
        .width('100%')
        .padding({ right: 10 })
        .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ left: 8 })
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}