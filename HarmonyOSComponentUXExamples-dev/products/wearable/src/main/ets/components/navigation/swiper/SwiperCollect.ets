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
import { ArcDirection, ArcDotIndicator, ArcSwiper, ArcSwiperController } from '@ohos.arkui.ArcSwiper';
import { ComponentItem, SizeToken } from 'componentuxexamplesbase';
import { TitleComponent } from '../../common/TitleComponent';
import { CircleShape } from '@ohos.arkui.shape';

@Builder
export function SwiperCollectBuilder() {
  SwiperCollect()
}

@ComponentV2
struct SwiperCollect {
  @Local private param: ComponentItem = { id: '', name: '', url: '' };
  context: UIContext = this.getUIContext();
  private wearableSwiperController: ArcSwiperController = new ArcSwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();
  @Local isVertical: boolean = false;
  @Local arcDirection: number = ArcDirection.SIX_CLOCK_DIRECTION;
  @Local items: Resource[] =
    [$r('sys.symbol.figure_running'), $r('sys.symbol.swim_strokes'), $r('sys.symbol.figure_outdoor_cycle'),
      $r('sys.symbol.figure_skiing_downhill'), $r('sys.symbol.figure_cooldown')]
  innerSelectedIndex: number = 0;

  build() {
    NavDestination() {
      Column() {
        ArcSwiper(this.wearableSwiperController) {
          Repeat(this.items)
            .each((itemWrap) => {
              Column() {
                TitleComponent(this.param.name)
                SymbolGlyph(itemWrap.item)
                  .fontColor([$r('app.color.light_blue_color')])
                  .fontSize(SizeToken.SIZE_NUM_32)
                  .width(SizeToken.SIZE_NUM_64)
                  .height(SizeToken.SIZE_NUM_64)
                  .borderRadius(SizeToken.SIZE_NUM_64)
                  .backgroundColor($r('app.color.dark_gray_color'))
                  .margin({ top: SizeToken.SIZE_NUM_40 })
              }.width(SizeToken.SIZE_PERCENT_100)
              .height(SizeToken.SIZE_PERCENT_100)

            })
        }
        .clipShape(new CircleShape({ width: SizeToken.SIZE_PERCENT_100, height: SizeToken.SIZE_PERCENT_100 }))
        .effectMode(EdgeEffect.None)
        .backgroundColor(Color.Black)
        .indicator(this.arcDotIndicator
          .arcDirection(this.arcDirection)
          .itemColor($r('app.color.gray_color'))
          .selectedItemColor(Color.White)
          .maskColor(new LinearGradient([{ color: Color.Transparent, offset: 1 }]))
        )
        .disableSwipe(false)
        .focusable(true)
        .defaultFocus(true)
        .focusOnTouch(true)
        .digitalCrownSensitivity(CrownSensitivity.MEDIUM)
        .vertical(this.isVertical)
        .disableTransitionAnimation(true)
        .onAnimationStart((targetIndex: number) => {
          this.innerSelectedIndex = targetIndex;
        })
        .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer): GestureJudgeResult => {
          if (current) {
            let target = current.getEventTargetInfo();
            if (target && current.isBuiltIn() && current.getType() === GestureControl.GestureType.PAN_GESTURE) {
              let swiperTarget = target as ScrollableTargetInfo
              if (swiperTarget instanceof ScrollableTargetInfo &&
                (swiperTarget.isBegin() || this.innerSelectedIndex === 0)) {
                let panEvent = event as PanGestureEvent;
                if (panEvent && panEvent.offsetX > 0 && (swiperTarget.isBegin() || this.innerSelectedIndex === 0)) {
                  return GestureJudgeResult.REJECT;
                }
              }
            }
          }
          return GestureJudgeResult.CONTINUE;
        })
      }.height(SizeToken.SIZE_PERCENT_100)
    }.hideTitleBar(true)
    .hideBackButton(true)
    .backgroundColor(Color.Black)
    .onReady((context: NavDestinationContext) => {
      this.param = context.pathInfo.param as ComponentItem;
      if (this.param.id === 'horizontal_swiper') {
        this.isVertical = false
        this.arcDirection = ArcDirection.SIX_CLOCK_DIRECTION;
      }
      if (this.param.id === 'vertical_swiper') {
        this.isVertical = true
        this.arcDirection = ArcDirection.THREE_CLOCK_DIRECTION;
      }
    })
  }
}