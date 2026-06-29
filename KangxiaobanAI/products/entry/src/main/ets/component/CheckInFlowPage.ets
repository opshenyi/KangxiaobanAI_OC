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
  DividerShowType,
  hdsMaterial,
  HdsNavDestination,
  ScrollEffectType
} from '@kit.UIDesignKit';

interface CheckInFlowItem {
  title: ResourceStr;
  subtitle: ResourceStr;
  tag: ResourceStr;
}

interface CheckInFlowSection {
  title: ResourceStr;
  description: ResourceStr;
  items: CheckInFlowItem[];
}

@ComponentV2
export struct CheckInFlowPage {
  @Consumer('mainPageStack') pathStack: NavPathStack = new NavPathStack();
  private sections: CheckInFlowSection[] = [
    {
      title: $r('app.string.check_in_section_steps_title'),
      description: $r('app.string.check_in_section_steps_desc'),
      items: [
        {
          title: $r('app.string.check_in_step_1_title'),
          subtitle: $r('app.string.check_in_step_1_subtitle'),
          tag: $r('app.string.check_in_step_1_tag')
        },
        {
          title: $r('app.string.check_in_step_2_title'),
          subtitle: $r('app.string.check_in_step_2_subtitle'),
          tag: $r('app.string.check_in_step_2_tag')
        },
        {
          title: $r('app.string.check_in_step_3_title'),
          subtitle: $r('app.string.check_in_step_3_subtitle'),
          tag: $r('app.string.check_in_step_3_tag')
        },
        {
          title: $r('app.string.check_in_step_4_title'),
          subtitle: $r('app.string.check_in_step_4_subtitle'),
          tag: $r('app.string.check_in_step_4_tag')
        },
        {
          title: $r('app.string.check_in_step_5_title'),
          subtitle: $r('app.string.check_in_step_5_subtitle'),
          tag: $r('app.string.check_in_step_5_tag')
        }
      ]
    },
    {
      title: $r('app.string.check_in_section_ready_title'),
      description: $r('app.string.check_in_section_ready_desc'),
      items: [
        {
          title: $r('app.string.check_in_ready_1_title'),
          subtitle: $r('app.string.check_in_ready_1_subtitle'),
          tag: $r('app.string.check_in_ready_1_tag')
        },
        {
          title: $r('app.string.check_in_ready_2_title'),
          subtitle: $r('app.string.check_in_ready_2_subtitle'),
          tag: $r('app.string.check_in_ready_2_tag')
        },
        {
          title: $r('app.string.check_in_ready_3_title'),
          subtitle: $r('app.string.check_in_ready_3_subtitle'),
          tag: $r('app.string.check_in_ready_3_tag')
        }
      ]
    }
  ];

  @Builder
  private sectionHeader(title: ResourceStr, description: ResourceStr) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize($r('sys.float.Subtitle_S'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.font_primary'))
      Text(description)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private flowItem(item: CheckInFlowItem, index: number, isLast: boolean) {
    Row({ space: $r('sys.float.padding_level4') }) {
      Text(`${index + 1}`)
        .width(26)
        .height(26)
        .textAlign(TextAlign.Center)
        .fontSize($r('sys.float.Caption_M'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.font_primary'))
        .backgroundColor($r('sys.color.comp_background_secondary'))
        .borderRadius(13)

      Column({ space: 4 }) {
        Text(item.title)
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
        Text(item.subtitle)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_secondary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(item.tag)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_primary'))
        .padding({
          left: $r('sys.float.padding_level3'),
          right: $r('sys.float.padding_level3'),
          top: 4,
          bottom: 4
        })
        .backgroundColor($r('sys.color.comp_background_secondary'))
        .borderRadius($r('sys.float.corner_radius_level8'))
    }
    .alignItems(VerticalAlign.Center)
    .padding({
      top: $r('sys.float.padding_level4'),
      bottom: $r('sys.float.padding_level4')
    })
    .border({
      width: {
        bottom: isLast ? 0 : 1
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private sectionCard(section: CheckInFlowSection) {
    Column({ space: $r('sys.float.padding_level2') }) {
      this.sectionHeader(section.title, section.description)
      Column() {
        Repeat(section.items)
          .each((repeatItem: RepeatItem<CheckInFlowItem>) => {
            this.flowItem(repeatItem.item, repeatItem.index, repeatItem.index === section.items.length - 1)
          })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius($r('sys.float.corner_radius_level16'))
  }

  build() {
    HdsNavDestination() {
      List({ space: 16 }) {
        ListItem() {
          Column({ space: $r('sys.float.padding_level3') }) {
            Row({ space: $r('sys.float.padding_level4') }) {
              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .width(72)
                  .height(72)
                  .fill('#00000000')
                SymbolGlyph($r('sys.symbol.plus'))
                  .fontSize($r('sys.float.Title_L'))
                  .fontColor([$r('sys.color.icon_primary')])
              }

              Column({ space: 4 }) {
                Text($r('app.string.mini_bar_title'))
                  .fontSize($r('sys.float.Title_S'))
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('sys.color.font_primary'))
                Text($r('app.string.mini_bar_operator'))
                  .fontSize($r('sys.float.Body_S'))
                  .fontColor($r('sys.color.font_secondary'))
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text($r('app.string.check_in_current_stage'))
                .fontSize($r('sys.float.Caption_M'))
                .fontColor($r('sys.color.font_primary'))
                .padding({
                  left: $r('sys.float.padding_level3'),
                  right: $r('sys.float.padding_level3'),
                  top: 4,
                  bottom: 4
                })
                .backgroundColor($r('sys.color.comp_background_secondary'))
                .borderRadius($r('sys.float.corner_radius_level8'))
            }

            Text($r('app.string.check_in_page_subtitle'))
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .padding($r('sys.float.padding_level6'))
          .backgroundColor($r('sys.color.comp_background_primary'))
          .borderRadius($r('sys.float.corner_radius_level16'))
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8')
        })

        ListItem() {
          this.sectionCard(this.sections[0])
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8')
        })

        ListItem() {
          this.sectionCard(this.sections[1])
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8'),
          bottom: 48
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .backgroundColor('#FFF7F8FA')
    }
    .backgroundColor('#FFF7F8FA')
    .titleBar({
      content: {
        title: {
          mainTitle: $r('app.string.check_in_page_title')
        },
        divider: {
          showType: DividerShowType.OFF
        }
      },
      style: {
        scrollEffectOpts: {
          enableScrollEffect: true,
          scrollEffectType: ScrollEffectType.GRADIENT_BLUR
        },
        systemMaterialEffect: {
          materialType: hdsMaterial.MaterialType.IMMERSIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
        }
      }
    })
    .systemTransition(NavigationSystemTransitionType.SLIDE_RIGHT)
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    .onBackPressed(() => {
      this.pathStack.pop();
      return true;
    })
    .width('100%')
    .height('100%')
  }
}
