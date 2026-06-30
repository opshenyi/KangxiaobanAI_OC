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

import { AppStorageV2, SymbolGlyphModifier } from '@kit.ArkUI';
import {
  HdsListItemCard,
  IconSize,
  PrefixIcon,
  SuffixArrow,
  SuffixButton,
  SuffixText
} from '@kit.UIDesignKit';
import { StorageKey } from '../common/CommonConstants';
import { GlobalInfoModel } from '../model/GlobalInfoModel';
import { PageKeyEnum, PAGE_SCROLLER_MAP } from '../model/TabsBarModel';
import { TabPageConfig } from '../model/TabPageModel';
import { BreakpointType } from '../util/BreakpointSystem';

interface MetricTileData {
  label: string;
  value: string;
  note: string;
  toneBackground: ResourceColor;
  toneColor: ResourceColor;
}

interface InsightData {
  title: string;
  tag: string;
  detail: string;
  extra: string;
}

interface ProgressData {
  label: string;
  valueText: string;
  percent: number;
  color: ResourceColor;
}

interface RoomData {
  name: string;
  occupied: string;
  status: string;
  detail: string;
}

interface ResidentData {
  name: string;
  room: string;
  level: string;
  status: string;
  detail: string;
  nextStep: string;
}

interface ElderRoomData {
  name: string;
  floor: string;
  occupied: string;
  capacity: string;
  status: string;
  detail: string;
  devices: RoomDeviceData[];
}

interface RoomDeviceData {
  name: string;
  type: string;
  status: string;
  online: boolean;
  detail: string;
}

interface TaskData {
  time: string;
  title: string;
  detail: string;
  owner: string;
}

interface TaskLaneData {
  title: string;
  badge: string;
  detail: string;
  items: TaskData[];
}

interface AiFeedbackData {
  elder: string;
  room: string;
  type: string;
  summary: string;
  suggestedAction: string;
  priority: string;
}

interface ElderRequestData {
  time: string;
  elder: string;
  room: string;
  type: string;
  detail: string;
  status: string;
}

interface SimpleInfoRow {
  label: string;
  value: string;
  note: string;
}

interface QuickActionData {
  icon: Resource;
  label: string;
  subLabel?: string;
  badge?: string;
}

interface SettingItemData {
  icon: Resource;
  label: string;
  value?: string;
  showArrow: boolean;
}

interface SettingGroupData {
  title: string;
  items: SettingItemData[];
}

interface ProfileSheetItem {
  label: string;
  value?: string;
  isAvatar?: boolean;
  tag?: string;
}

interface MoodData {
  name: string;
  room: string;
  level: string;
  mood: string;
  detail: string;
  trend: 'up' | 'down' | 'stable';
}

interface DeviceData {
  name: string;
  room: string;
  type: string;
  status: string;
  detail: string;
  online: boolean;
}

@ComponentV2
export struct TabPageView {
  @Param @Require currentTabIndex: number;
  @Param @Require pageKey: PageKeyEnum;
  @Param @Require config: TabPageConfig;
  @Local globalInfoModel: GlobalInfoModel =
    AppStorageV2.connect(GlobalInfoModel, StorageKey.GLOBAL_INFO) ?? new GlobalInfoModel();
  @Local isProfileSheetOpen: boolean = false;

  private topPadding(): number {
    return this.globalInfoModel.statusBarHeight + 68;
  }

  private currentScroller(): Scroller | undefined {
    return PAGE_SCROLLER_MAP.get(this.pageKey)?.[this.currentTabIndex];
  }

  private isWideLayout(): boolean {
    const widthBreakpoint: WidthBreakpoint = this.globalInfoModel.widthBreakpoint;
    return widthBreakpoint === WidthBreakpoint.WIDTH_MD ||
      widthBreakpoint === WidthBreakpoint.WIDTH_LG ||
      widthBreakpoint === WidthBreakpoint.WIDTH_XL;
  }

  private isExtraWideLayout(): boolean {
    const widthBreakpoint: WidthBreakpoint = this.globalInfoModel.widthBreakpoint;
    return widthBreakpoint === WidthBreakpoint.WIDTH_LG || widthBreakpoint === WidthBreakpoint.WIDTH_XL;
  }

  private pagePadding(): number {
    return new BreakpointType<number>({
      sm: 16,
      md: 24,
      lg: 28,
      xl: 32
    }).getValue(this.globalInfoModel.widthBreakpoint);
  }

  private bottomPadding(): number {
    return this.isWideLayout() ? 36 : 124;
  }

  private cardRadius(): number {
    return this.isWideLayout() ? 16 : 14;
  }

  private pageBackgroundColor(): ResourceColor {
    return $r('sys.color.background_secondary');
  }

  private dashboardMetrics(): MetricTileData[] {
    return [
      {
        label: '待闭环任务',
        value: '18',
        note: '其中 6 项需 30 分钟内响应',
        toneBackground: '#EAF1FD',
        toneColor: '#1D63ED'
      },
      {
        label: '重点观察长者',
        value: '06',
        note: '涉及情绪、睡眠和离床异常',
        toneBackground: '#FDEFD8',
        toneColor: '#B7791F'
      },
      {
        label: '入住办理',
        value: '03',
        note: '2 位待资料核验，1 位待床位确认',
        toneBackground: '#E9F7F1',
        toneColor: '#0F766E'
      },
      {
        label: '家属回访',
        value: '05',
        note: '今日 17:30 前需完成 3 条反馈',
        toneBackground: '#F9E8EC',
        toneColor: '#B33A5B'
      }
    ];
  }

  private homeInsights(): InsightData[] {
    return [
      {
        title: '情绪主动关怀',
        tag: '高优先',
        detail: '3F-302 肖爷爷今日活动量下降 41%，语音柔性关怀后仍建议人工跟进。',
        extra: '建议由熟悉护工在 15 分钟内二次陪聊，并同步给护理站。'
      },
      {
        title: '夜间安全预警',
        tag: '待复核',
        detail: '2F 东区两位长者近三晚起夜次数增加，床垫与毫米波均提示睡眠片段化。',
        extra: '今晚值班需重点查看离床轨迹与药物服用时间。'
      },
      {
        title: '家属沟通缺口',
        tag: '需联系',
        detail: '今日有 3 位长者家属电话未接通，系统已整理陪伴摘要待回访。',
        extra: '建议晚饭后优先安排视频沟通，降低情绪持续下沉风险。'
      }
    ];
  }

  private homeProgress(): ProgressData[] {
    return [
      {
        label: '班次闭环效率',
        valueText: '92%',
        percent: 92,
        color: '#1D63ED'
      },
      {
        label: '风险提前拦截',
        valueText: '81%',
        percent: 81,
        color: '#0F766E'
      },
      {
        label: '家属反馈完成率',
        valueText: '68%',
        percent: 68,
        color: '#B7791F'
      }
    ];
  }

  private moodCoverage(): MoodData[] {
    return [
      {
        name: '肖爷爷',
        room: '3F-302',
        level: 'A 级关注',
        mood: '低落',
        detail: '今日活动量下降 41%，AI 语音关怀后仍建议人工陪伴。',
        trend: 'down'
      },
      {
        name: '周奶奶',
        room: '2F-215',
        level: '睡眠观察',
        mood: '焦虑',
        detail: '家属电话未接通，午后持续静坐。',
        trend: 'down'
      },
      {
        name: '林爷爷',
        room: '3F-306',
        level: '关系风险',
        mood: '回避',
        detail: '近两日与室友互动减少，语气波动明显。',
        trend: 'stable'
      }
    ];
  }

  private deviceCoverage(): DeviceData[] {
    return [
      {
        name: '智能床垫',
        room: '2F-东区',
        type: '睡眠体征',
        status: '在线',
        detail: '36 床在线，2 床需更换电池。',
        online: true
      },
      {
        name: '毫米波雷达',
        room: '3F-西区',
        type: '离床跌倒',
        status: '异常',
        detail: '1 台离线，已生成巡检任务。',
        online: false
      },
      {
        name: '紧急呼叫器',
        room: '康复单元',
        type: '主动求助',
        status: '在线',
        detail: '18 台在线，今日触发 3 次。',
        online: true
      }
    ];
  }

  private roomCoverage(): RoomData[] {
    return [
      {
        name: '2F 东区',
        occupied: '32 / 36',
        status: '稳定',
        detail: '午间用药已完成，1 位长者待血糖复核。'
      },
      {
        name: '3F 西区',
        occupied: '28 / 32',
        status: '关注',
        detail: '2 位长者需情绪干预，1 位待家属回访。'
      },
      {
        name: '康复单元',
        occupied: '16 / 18',
        status: '排程中',
        detail: '下午两组康复训练与晚餐前复查已排入班次。'
      }
    ];
  }

  private elderResidents(): ResidentData[] {
    return [
      {
        name: '肖爷爷',
        room: '3F-302',
        level: 'A 级关注',
        status: '情绪低落',
        detail: '今日两次联系家属未接通，午后持续静坐，AI 建议人工陪伴接手。',
        nextStep: '15:10 进行二次沟通并记录情绪摘要'
      },
      {
        name: '周奶奶',
        room: '2F-215',
        level: '睡眠观察',
        status: '夜间离床增加',
        detail: '连续三晚起夜增多，深睡时长下降，需确认疼痛与焦虑因素。',
        nextStep: '晚班重点巡房并同步睡眠计划'
      },
      {
        name: '林爷爷',
        room: '3F-306',
        level: '关系风险',
        status: '社交回避',
        detail: '近两日与室友互动减少，语气波动明显，需柔性介入。',
        nextStep: '调整活动搭配并观察晚间情绪波动'
      }
    ];
  }

  private elderGroups(): SimpleInfoRow[] {
    return [
      {
        label: '稳定观察',
        value: '116',
        note: '已完成早巡，可按区域批量复核'
      },
      {
        label: '情绪关怀',
        value: '05',
        note: '包含低落、孤独和家属联络缺口'
      },
      {
        label: '健康风险',
        value: '07',
        note: '主要集中在睡眠、步态和离床异常'
      },
      {
        label: '社交关系',
        value: '03',
        note: '建议关注宿舍匹配和活动参与'
      }
    ];
  }

  private elderActions(): InsightData[] {
    return [
      {
        title: '饮食建议更新',
        tag: '自动生成',
        detail: '根据近期对话和护理记录，4 位长者今日点餐优先推荐低盐高蛋白。',
        extra: '晚餐端提醒已下发到点餐终端。'
      },
      {
        title: '活动陪伴编组',
        tag: '可执行',
        detail: '系统建议将棋牌、书法和花园散步重新编组，提升低社交长者参与度。',
        extra: '建议 16:00 前完成活动确认并安排护工陪同。'
      }
    ];
  }

  private elderRooms(): ElderRoomData[] {
    return [
      {
        name: '2F-215',
        floor: '2F 东区',
        occupied: '4 / 4',
        capacity: '四人间',
        status: '稳定',
        detail: '周奶奶夜间离床增加，床垫与毫米波在线。',
        devices: [
          { name: '智能床垫', type: '睡眠体征', status: '在线', online: true, detail: '深睡、心率、呼吸监测正常' },
          { name: '毫米波雷达', type: '离床跌倒', status: '在线', online: true, detail: '起夜轨迹已记录' },
          { name: '紧急呼叫器', type: '主动求助', status: '在线', online: true, detail: '床头固定，电量 78%' }
        ]
      },
      {
        name: '3F-302',
        floor: '3F 西区',
        occupied: '2 / 4',
        capacity: '双人间',
        status: '关注',
        detail: '肖爷爷情绪低落，需人工陪伴接手。',
        devices: [
          { name: '智能床垫', type: '睡眠体征', status: '在线', online: true, detail: '活动量下降 41%' },
          { name: '毫米波雷达', type: '离床跌倒', status: '在线', online: true, detail: '午后持续静坐' },
          { name: '紧急呼叫器', type: '主动求助', status: '低电', online: true, detail: '电量 12%，建议今日更换' }
        ]
      },
      {
        name: '3F-306',
        floor: '3F 西区',
        occupied: '3 / 4',
        capacity: '四人间',
        status: '关注',
        detail: '林爷爷社交回避，室友互动减少。',
        devices: [
          { name: '智能床垫', type: '睡眠体征', status: '在线', online: true, detail: '睡眠片段化' },
          { name: '毫米波雷达', type: '离床跌倒', status: '离线', online: false, detail: '14:20 离线，已派巡检' },
          { name: '紧急呼叫器', type: '主动求助', status: '在线', online: true, detail: '电量 54%' }
        ]
      }
    ];
  }

  private taskLanes(): TaskLaneData[] {
    return [
      {
        title: '立即执行',
        badge: '04',
        detail: '本班次必须立刻接手的任务',
        items: [
          {
            time: '现在',
            title: '进入 3F-302 情绪安抚',
            detail: '阅读 AI 摘要后由熟悉护工接手，避免重复询问。',
            owner: '责任护工 刘婷'
          },
          {
            time: '10 分钟内',
            title: '复核 2F 东区午间用药',
            detail: '6 位长者需统一确认并同步护理站记录。',
            owner: '责任护工 王倩'
          }
        ]
      },
      {
        title: '今日排程',
        badge: '06',
        detail: '围绕入住、活动和回访的时段计划',
        items: [
          {
            time: '14:20',
            title: '完成新入住初评',
            detail: '录入生命体征、陪护需求与房间偏好。',
            owner: '接待护工 陈薇'
          },
          {
            time: '15:40',
            title: '组织小组活动签到',
            detail: '棋牌室和书法角各保留 1 名陪同护工。',
            owner: '活动护工 赵晨'
          }
        ]
      },
      {
        title: '交接闭环',
        badge: '03',
        detail: '班次结束前需要收口的项目',
        items: [
          {
            time: '17:00',
            title: '更新风险预测摘要',
            detail: '沉淀步态、睡眠和情绪异常人群的明日观察名单。',
            owner: '值班组长'
          },
          {
            time: '17:30',
            title: '整理交接班材料',
            detail: '补齐来访、用药与异常情况，形成值班摘要。',
            owner: '全班次协同'
          }
        ]
      }
    ];
  }

  private taskPredictions(): InsightData[] {
    return [
      {
        title: '若肖爷爷今日继续拒绝交流',
        tag: '24h 预测',
        detail: '情绪继续下沉概率升高，建议增加人工陪伴和家属联系频次。',
        extra: '优先安排熟悉护工于晚饭后再次回访。'
      },
      {
        title: '若林爷爷今晚未按时服药',
        tag: '10 天趋势',
        detail: '结合近期步态和心率波动，跌倒风险将明显升高。',
        extra: '需要在今晚交接中单独提醒夜班。'
      }
    ];
  }

  private aiFeedbacks(): AiFeedbackData[] {
    return [
      {
        elder: '肖爷爷',
        room: '3F-302',
        type: '情绪低落',
        summary: '今日两次与 AI 对话时语调低沉，活动量下降 41%，语音柔性关怀后仍建议人工接手。',
        suggestedAction: '由熟悉护工在 15 分钟内二次陪聊，并同步护理站。',
        priority: '高优先'
      },
      {
        elder: '周奶奶',
        room: '2F-215',
        type: '睡眠异常',
        summary: '连续三晚起夜增多，深睡时长下降，床垫与毫米波均提示睡眠片段化。',
        suggestedAction: '晚班重点巡房，确认疼痛与焦虑因素并同步睡眠计划。',
        priority: '需复核'
      },
      {
        elder: '林爷爷',
        room: '3F-306',
        type: '社交回避',
        summary: '近两日与室友互动减少，语气波动明显，AI 建议柔性介入并调整活动搭配。',
        suggestedAction: '调整活动编组并观察晚间情绪波动。',
        priority: '可执行'
      }
    ];
  }

  private elderRequests(): ElderRequestData[] {
    return [
      {
        time: '10:24',
        elder: '肖爷爷',
        room: '3F-302',
        type: '情绪陪伴',
        detail: '通过床头呼叫器表达想找人聊聊，AI 已进行首轮语音安抚。',
        status: '待接手'
      },
      {
        time: '09:46',
        elder: '周奶奶',
        room: '2F-215',
        type: '夜间不适',
        detail: '呼叫器反馈昨晚没睡好，希望今天安排午休和疼痛评估。',
        status: '已排程'
      },
      {
        time: '09:12',
        elder: '林爷爷',
        room: '3F-306',
        type: '活动报名',
        detail: '主动要求参加书法角活动，希望有人陪同前往。',
        status: '已确认'
      }
    ];
  }

  @Builder
  private tag(text: string, backgroundColor: ResourceColor, fontColor: ResourceColor = $r('sys.color.font_secondary')) {
    Text(text)
      .fontSize($r('sys.float.Caption_M'))
      .fontColor(fontColor)
      .padding({
        left: $r('sys.float.padding_level3'),
        right: $r('sys.float.padding_level3'),
        top: 4,
        bottom: 4
      })
      .backgroundColor(backgroundColor)
      .borderRadius(10)
  }

  @Builder
  private sectionTitle(eyebrow: string, title: string, detail: string) {
    Column({ space: 4 }) {
      Text(eyebrow)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))
      Text(title)
        .fontSize($r('sys.float.Subtitle_S'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.font_primary'))
      Text(detail)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_secondary'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private metricTile(item: MetricTileData) {
    Column({ space: 8 }) {
      Row() {
        Text(item.label)
          .fontSize($r('sys.float.Body_S'))
          .fontColor($r('sys.color.font_secondary'))
        Blank()
        Text(item.value)
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor(item.toneColor)
      }
      .width('100%')

      Text(item.note)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_secondary'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .padding($r('sys.float.padding_level5'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private insightCard(item: InsightData) {
    Column({ space: 12 }) {
      Row() {
        Text(item.title)
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
          .layoutWeight(1)
        this.tag(item.tag, $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Text(item.detail)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_secondary'))
      Divider()
        .strokeWidth(0.5)
        .color($r('sys.color.comp_divider'))
      Text(item.extra)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_tertiary'))
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private progressRow(item: ProgressData) {
    Column({ space: 8 }) {
      Row() {
        Text(item.label)
          .fontSize($r('sys.float.Body_S'))
          .fontColor($r('sys.color.font_primary'))
        Blank()
        Text(item.valueText)
          .fontSize($r('sys.float.Body_S'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
      }
      .width('100%')
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(6)
          .backgroundColor($r('sys.color.comp_background_secondary'))
          .borderRadius(3)
        Row()
          .width(`${item.percent}%`)
          .height(6)
          .backgroundColor(item.color)
          .borderRadius(3)
      }
      .width('100%')
    }
  }

  @Builder
  private roomRow(item: RoomData, isLast: boolean) {
    HdsListItemCard({
      textItem: {
        primaryText: { text: item.name },
        secondaryText: { text: item.detail }
      },
      suffixItem: new SuffixText({ text: `${item.occupied} · ${item.status}` }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 52,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private moodRow(item: MoodData, isLast: boolean) {
    HdsListItemCard({
      textItem: {
        primaryText: { text: `${item.name} · ${item.room}` },
        secondaryText: { text: item.detail }
      },
      suffixItem: new SuffixText({ text: item.mood }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 64,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private deviceRow(item: DeviceData, isLast: boolean) {
    HdsListItemCard({
      textItem: {
        primaryText: { text: `${item.name} · ${item.room}` },
        secondaryText: { text: item.detail }
      },
      suffixItem: new SuffixText({ text: `${item.status}` }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 64,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private residentCard(item: ResidentData) {
    Column({ space: 12 }) {
      Row() {
        Blank()
          .width(4)
          .height(34)
          .backgroundColor($r('sys.color.icon_emphasize'))
          .borderRadius(2)
          .margin({ right: 10 })
        Column({ space: 4 }) {
          Text(item.name)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text(`${item.room} · ${item.level}`)
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        this.tag(item.status, $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }

      Text(item.detail)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_primary'))
      Divider()
        .strokeWidth(0.5)
        .color($r('sys.color.comp_divider'))
      Text(item.nextStep)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private roomDeviceRow(item: RoomDeviceData, isLast: boolean) {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: new SymbolGlyphModifier(item.online ? $r('sys.symbol.checkmark_circle') : $r('sys.symbol.exclamationmark_circle'))
            .fontColor([item.online ? Color.Green : Color.Orange])
        }
      }),
      textItem: {
        primaryText: { text: item.name },
        secondaryText: { text: `${item.type} · ${item.detail}` }
      },
      suffixItem: new SuffixText({ text: item.status }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 52,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private roomCard(item: ElderRoomData) {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 4 }) {
          Text(item.name)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text(`${item.floor} · ${item.capacity}`)
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        this.tag(item.status, $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Row() {
        Text('入住')
          .fontSize($r('sys.float.Body_S'))
          .fontColor($r('sys.color.font_secondary'))
        Blank()
        Text(item.occupied)
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })

      Text(item.detail)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_secondary'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Divider()
        .strokeWidth(0.5)
        .color($r('sys.color.comp_divider'))
        .margin({ top: 12, bottom: 4 })

      Column({ space: 0 }) {
        Repeat(item.devices)
          .each((repeatItem: RepeatItem<RoomDeviceData>) => {
            this.roomDeviceRow(repeatItem.item, repeatItem.index === item.devices.length - 1)
          })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private infoRow(item: SimpleInfoRow, isLast: boolean) {
    Row() {
      Column({ space: 2 }) {
        Text(item.label)
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
        Text(item.note)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_secondary'))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Text(item.value)
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
    }
    .padding({
      top: 12,
      bottom: 12
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private taskRow(item: TaskData, isLast: boolean) {
    Row({ space: 12 }) {
      Text(item.time)
        .width(72)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))

      Column({ space: 6 }) {
        Text(item.title)
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
        Text(item.detail)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_secondary'))
        Text(item.owner)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_tertiary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding({
      top: 12,
      bottom: 12
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private taskLaneCard(item: TaskLaneData) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(item.title)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text(item.detail)
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        this.tag(item.badge, $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Column() {
        Repeat(item.items)
          .each((repeatItem: RepeatItem<TaskData>) => {
            this.taskRow(repeatItem.item, repeatItem.index === item.items.length - 1)
          })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private aiFeedbackCard(item: AiFeedbackData) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(`${item.elder} · ${item.room}`)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text(item.type)
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        this.tag(item.priority, $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Text(item.summary)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_primary'))
      Divider()
        .strokeWidth(0.5)
        .color($r('sys.color.comp_divider'))
      Text(item.suggestedAction)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private elderRequestRow(item: ElderRequestData, isLast: boolean) {
    HdsListItemCard({
      textItem: {
        primaryText: { text: `${item.time} · ${item.elder} · ${item.room}` },
        secondaryText: { text: `${item.type} · ${item.detail}` }
      },
      suffixItem: new SuffixText({ text: item.status }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 64,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private homeHero() {
    Column({ space: 18 }) {
      Row() {
        Column({ space: 6 }) {
          Text('首页')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
          Text('养老院主动服务总览')
            .fontSize($r('sys.float.Title_M'))
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.font_primary'))
          Text('把任务闭环、风险预警、家属沟通和入住办理收拢到同一套值班视图里。')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
            .maxLines(2)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        this.tag('服务稳定 96%', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Row({ space: 14 }) {
        this.homeHeroStat('128', '在院长者')
        this.homeHeroStat('18', '待闭环任务')
        this.homeHeroStat('12', '可用床位')
      }
      .width('100%')

      Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row }) {
        this.tag('情绪关注 3', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
        this.tag('离床异常 2', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
        this.tag('未接来电 5', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
        this.tag('今日入住 3', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private homeHeroStat(value: string, label: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize($r('sys.float.Title_L'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.font_primary'))
      Text(label)
        .fontSize($r('sys.float.Caption_M'))
        .fontColor($r('sys.color.font_secondary'))
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private homeConsole() {
    Column({ space: 14 }) {
      this.sectionTitle('值班指挥台', '任务 SLA', '更偏运营面板的当班视角，适合主管和总值班快速扫读。')

      Column({ space: 12 }) {
        Repeat(this.homeProgress())
          .each((repeatItem: RepeatItem<ProgressData>) => {
            this.progressRow(repeatItem.item)
          })
      }

      Divider()
        .strokeWidth(0.5)
        .color($r('sys.color.comp_divider'))

      Row({ space: 12 }) {
        this.homeHeroStat('17:30', '交接截止')
        this.homeHeroStat('03', '主管待批')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private homePage() {
    List({
      scroller: this.currentScroller(),
      space: 16
    }) {
      ListItem() {
        if (this.isWideLayout()) {
          Row({ space: 16 }) {
            this.homeHero()
            Column() {
              this.homeConsole()
            }
            .width(this.isExtraWideLayout() ? 360 : 320)
          }
        } else {
          Column({ space: 16 }) {
            this.homeHero()
            this.homeConsole()
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        top: this.topPadding()
      })

      ListItem() {
        Column({ space: 12 }) {
          this.sectionTitle('工作总览', '机器负责发现问题', '把情绪、健康、社交与夜间风险整理成护工真正能执行的动作。')

          if (this.isWideLayout()) {
            Row({ space: 12 }) {
              this.metricTile(this.dashboardMetrics()[0])
              this.metricTile(this.dashboardMetrics()[1])
            }
            Row({ space: 12 }) {
              this.metricTile(this.dashboardMetrics()[2])
              this.metricTile(this.dashboardMetrics()[3])
            }
          } else {
            Column({ space: 12 }) {
              Repeat(this.dashboardMetrics())
                .each((repeatItem: RepeatItem<MetricTileData>) => {
                  this.metricTile(repeatItem.item)
                })
            }
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding()
      })

      ListItem() {
        if (this.isWideLayout()) {
          Row({ space: 16 }) {
            Column({ space: 12 }) {
              this.sectionTitle('重点事项', '优先接管', '先处理那些需要人工温度和快速闭环的事项。')
              Column({ space: 12 }) {
                Repeat(this.homeInsights())
                  .each((repeatItem: RepeatItem<InsightData>) => {
                    this.insightCard(repeatItem.item)
                  })
              }
            }
            .layoutWeight(1)

            Column({ space: 12 }) {
              this.sectionTitle('区域覆盖', '床位与楼层', '看每个区域当前的占用、风险和执行状态。')
              Column() {
                Repeat(this.roomCoverage())
                  .each((repeatItem: RepeatItem<RoomData>) => {
                    this.roomRow(repeatItem.item, repeatItem.index === this.roomCoverage().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })

              this.sectionTitle('心情情况', '情绪雷达', '识别需要人工陪伴和情绪干预的长者。')
              Column() {
                Repeat(this.moodCoverage())
                  .each((repeatItem: RepeatItem<MoodData>) => {
                    this.moodRow(repeatItem.item, repeatItem.index === this.moodCoverage().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })

              this.sectionTitle('设备情况', '物联健康', '床垫、毫米波、呼叫器等设备在线与异常状态。')
              Column() {
                Repeat(this.deviceCoverage())
                  .each((repeatItem: RepeatItem<DeviceData>) => {
                    this.deviceRow(repeatItem.item, repeatItem.index === this.deviceCoverage().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })
            }
            .width(this.isExtraWideLayout() ? 360 : 320)
          }
        } else {
          Column({ space: 12 }) {
            this.sectionTitle('重点事项', '优先接管', '先处理那些需要人工温度和快速闭环的事项。')
            Repeat(this.homeInsights())
              .each((repeatItem: RepeatItem<InsightData>) => {
                this.insightCard(repeatItem.item)
              })
            this.sectionTitle('区域覆盖', '床位与楼层', '看每个区域当前的占用、风险和执行状态。')
            Column() {
              Repeat(this.roomCoverage())
                .each((repeatItem: RepeatItem<RoomData>) => {
                  this.roomRow(repeatItem.item, repeatItem.index === this.roomCoverage().length - 1)
                })
            }
            .padding($r('sys.float.padding_level6'))
            .backgroundColor($r('sys.color.comp_background_primary'))
            .borderRadius(this.cardRadius())
            .border({
              width: 0.5,
              color: $r('sys.color.comp_divider')
            })

            this.sectionTitle('心情情况', '情绪雷达', '识别需要人工陪伴和情绪干预的长者。')
            Column() {
              Repeat(this.moodCoverage())
                .each((repeatItem: RepeatItem<MoodData>) => {
                  this.moodRow(repeatItem.item, repeatItem.index === this.moodCoverage().length - 1)
                })
            }
            .padding($r('sys.float.padding_level6'))
            .backgroundColor($r('sys.color.comp_background_primary'))
            .borderRadius(this.cardRadius())
            .border({
              width: 0.5,
              color: $r('sys.color.comp_divider')
            })

            this.sectionTitle('设备情况', '物联健康', '床垫、毫米波、呼叫器等设备在线与异常状态。')
            Column() {
              Repeat(this.deviceCoverage())
                .each((repeatItem: RepeatItem<DeviceData>) => {
                  this.deviceRow(repeatItem.item, repeatItem.index === this.deviceCoverage().length - 1)
                })
            }
            .padding($r('sys.float.padding_level6'))
            .backgroundColor($r('sys.color.comp_background_primary'))
            .borderRadius(this.cardRadius())
            .border({
              width: 0.5,
              color: $r('sys.color.comp_divider')
            })
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        bottom: this.bottomPadding()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackgroundColor())
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  private elderHero() {
    Column({ space: 18 }) {
      Row() {
        Column({ space: 4 }) {
          Text('长者')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
          Text('长者画像与风险分层')
            .fontSize($r('sys.float.Title_M'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text('更偏“照护判断”的页面，把个体状态、人群分层和下一步建议放在同一块。')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        this.tag('重点关注 06', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Column({ space: 10 }) {
        Row() {
          Text('稳定观察')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
          Blank()
          Text('116')
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
        }
        .width('100%')
        Row() {
          Text('风险观察')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
          Blank()
          Text('12')
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
        }
        .width('100%')
        Row() {
          Text('社交低活跃')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
          Blank()
          Text('08')
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
        }
        .width('100%')
      }
      .padding($r('sys.float.padding_level5'))
      .backgroundColor($r('sys.color.comp_background_secondary'))
      .borderRadius(14)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private elderPage() {
    List({
      scroller: this.currentScroller(),
      space: 16
    }) {
      ListItem() {
        if (this.isWideLayout()) {
          Row({ space: 16 }) {
            this.elderHero()
            Column() {
              this.sectionTitle('风险分层矩阵', '人群视图', '院内运营视角，看覆盖面和分组变化。')
              Column() {
                Repeat(this.elderGroups())
                  .each((repeatItem: RepeatItem<SimpleInfoRow>) => {
                    this.infoRow(repeatItem.item, repeatItem.index === this.elderGroups().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })
            }
            .width(this.isExtraWideLayout() ? 360 : 320)
          }
        } else {
          Column({ space: 16 }) {
            this.elderHero()
            Column({ space: 12 }) {
              this.sectionTitle('风险分层矩阵', '人群视图', '更适合主管快速看分组与覆盖情况。')
              Column() {
                Repeat(this.elderGroups())
                  .each((repeatItem: RepeatItem<SimpleInfoRow>) => {
                    this.infoRow(repeatItem.item, repeatItem.index === this.elderGroups().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })
            }
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        top: this.topPadding()
      })

      ListItem() {
        if (this.isWideLayout()) {
          Row({ space: 16 }) {
            Column({ space: 12 }) {
              this.sectionTitle('重点关怀名单', '个体视角', '左侧专门看重点长者，像护理站的重点对象面板。')
              Column({ space: 12 }) {
                Repeat(this.elderResidents())
                  .each((repeatItem: RepeatItem<ResidentData>) => {
                    this.residentCard(repeatItem.item)
                  })
              }
            }
            .layoutWeight(1)

            Column({ space: 12 }) {
              this.sectionTitle('房间与设备', '房间视角', '每个房间的入住与物联设备状态。')
              Column({ space: 12 }) {
                Repeat(this.elderRooms())
                  .each((repeatItem: RepeatItem<ElderRoomData>) => {
                    this.roomCard(repeatItem.item)
                  })
              }
            }
            .width(this.isExtraWideLayout() ? 360 : 320)
          }
        } else {
          Column({ space: 12 }) {
            this.sectionTitle('重点关怀名单', '个体视角', '先看具体长者，再看人群分层。')
            Column({ space: 12 }) {
              Repeat(this.elderResidents())
                .each((repeatItem: RepeatItem<ResidentData>) => {
                  this.residentCard(repeatItem.item)
                })
            }

            this.sectionTitle('房间与设备', '房间视角', '每个房间的入住与物联设备状态。')
            Column({ space: 12 }) {
              Repeat(this.elderRooms())
                .each((repeatItem: RepeatItem<ElderRoomData>) => {
                  this.roomCard(repeatItem.item)
                })
            }

            this.sectionTitle('个性化建议', '行动建议', '这里不再像首页的警报卡，而更像护理建议单。')
            Column({ space: 12 }) {
              Repeat(this.elderActions())
                .each((repeatItem: RepeatItem<InsightData>) => {
                  this.insightCard(repeatItem.item)
                })
            }
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        bottom: this.bottomPadding()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackgroundColor())
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  private taskHero() {
    Column({ space: 18 }) {
      Row() {
        Column({ space: 4 }) {
          Text('任务')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
          Text('班次执行看板')
            .fontSize($r('sys.float.Title_M'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text('这页不再是信息总览，而是面向执行的工作流看板。')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        this.tag('SLA 正常', $r('sys.color.comp_background_secondary'), $r('sys.color.font_secondary'))
      }
      .width('100%')

      Row({ space: 12 }) {
        Column({ space: 2 }) {
          Text('4h')
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text('本班剩余时长')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 2 }) {
          Text('18')
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text('待办事项')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 2 }) {
          Text('03')
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
          Text('主管确认')
            .fontSize($r('sys.float.Caption_M'))
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding($r('sys.float.padding_level6'))
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(this.cardRadius())
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private taskPage() {
    List({
      scroller: this.currentScroller(),
      space: 16
    }) {
      ListItem() {
        this.taskHero()
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        top: this.topPadding()
      })

      ListItem() {
        if (this.isWideLayout()) {
          Row({ space: 16 }) {
            Column({ space: 12 }) {
              this.sectionTitle('AI 反馈需求', '机器发现的问题', 'AI 根据语音、睡眠和活动数据识别出的长者异常。')
              Column({ space: 12 }) {
                Repeat(this.aiFeedbacks())
                  .each((repeatItem: RepeatItem<AiFeedbackData>) => {
                    this.aiFeedbackCard(repeatItem.item)
                  })
              }
            }
            .layoutWeight(1)

            Column({ space: 12 }) {
              this.sectionTitle('老人主动求助', '长者发起的请求', '通过呼叫器、语音助手或主动表达产生的待办事项。')
              Column() {
                Repeat(this.elderRequests())
                  .each((repeatItem: RepeatItem<ElderRequestData>) => {
                    this.elderRequestRow(repeatItem.item, repeatItem.index === this.elderRequests().length - 1)
                  })
              }
              .padding($r('sys.float.padding_level6'))
              .backgroundColor($r('sys.color.comp_background_primary'))
              .borderRadius(this.cardRadius())
              .border({
                width: 0.5,
                color: $r('sys.color.comp_divider')
              })
            }
            .width(this.isExtraWideLayout() ? 360 : 320)
          }
        } else {
          Column({ space: 12 }) {
            this.sectionTitle('AI 反馈需求', '机器发现的问题', 'AI 根据语音、睡眠和活动数据识别出的长者异常。')
            Column({ space: 12 }) {
              Repeat(this.aiFeedbacks())
                .each((repeatItem: RepeatItem<AiFeedbackData>) => {
                  this.aiFeedbackCard(repeatItem.item)
                })
            }

            this.sectionTitle('老人主动求助', '长者发起的请求', '通过呼叫器、语音助手或主动表达产生的待办事项。')
            Column() {
              Repeat(this.elderRequests())
                .each((repeatItem: RepeatItem<ElderRequestData>) => {
                  this.elderRequestRow(repeatItem.item, repeatItem.index === this.elderRequests().length - 1)
                })
            }
            .padding($r('sys.float.padding_level6'))
            .backgroundColor($r('sys.color.comp_background_primary'))
            .borderRadius(this.cardRadius())
            .border({
              width: 0.5,
              color: $r('sys.color.comp_divider')
            })
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding()
      })

      ListItem() {
        Column({ space: 12 }) {
          this.sectionTitle('班次任务', '按执行链路展开', '这页更像业务看板，而不是单纯的清单。')

          if (this.isExtraWideLayout()) {
            Row({ space: 12 }) {
              Column() {
                this.taskLaneCard(this.taskLanes()[0])
              }
              .layoutWeight(1)
              Column() {
                this.taskLaneCard(this.taskLanes()[1])
              }
              .layoutWeight(1)
              Column() {
                this.taskLaneCard(this.taskLanes()[2])
              }
              .layoutWeight(1)
            }
          } else {
            Column({ space: 12 }) {
              Repeat(this.taskLanes())
                .each((repeatItem: RepeatItem<TaskLaneData>) => {
                  this.taskLaneCard(repeatItem.item)
                })
            }
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding()
      })

      ListItem() {
        Column({ space: 12 }) {
          this.sectionTitle('AI 预演', '先看后果再安排动作', '适合值班组长提前判断哪些事情要在今天就处理。')

          if (this.isWideLayout()) {
            Row({ space: 12 }) {
              this.insightCard(this.taskPredictions()[0])
              this.insightCard(this.taskPredictions()[1])
            }
          } else {
            Column({ space: 12 }) {
              Repeat(this.taskPredictions())
                .each((repeatItem: RepeatItem<InsightData>) => {
                  this.insightCard(repeatItem.item)
                })
            }
          }
        }
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        bottom: this.bottomPadding()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackgroundColor())
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  private quickActions(): QuickActionData[] {
    return [
      { icon: $r('sys.symbol.square_and_pencil'), label: '入住登记' },
      { icon: $r('sys.symbol.person_2'), label: '我的长者' },
      { icon: $r('sys.symbol.bell'), label: '消息通知' },
      { icon: $r('sys.symbol.paintpalette'), label: '培训学习' },
      { icon: $r('sys.symbol.hand_thumbsup'), label: '我的评价' },
      { icon: $r('sys.symbol.calendar_badge_clock'), label: '排班表' },
      { icon: $r('sys.symbol.doc_text'), label: '服务记录' },
      { icon: $r('sys.symbol.questionmark_circle'), label: '帮助中心' }
    ];
  }

  private settingGroups(): SettingGroupData[] {
    return [
      {
        title: '',
        items: [
          { icon: $r('sys.symbol.lock'), label: '账号安全', value: 'L3 权限', showArrow: true },
          { icon: $r('sys.symbol.bell'), label: '通知提醒', value: '关键提醒', showArrow: true },
          { icon: $r('sys.symbol.share'), label: '登录设备', value: '2 台', showArrow: true },
          { icon: $r('sys.symbol.questionmark_circle'), label: '关于我们', showArrow: true },
          { icon: $r('sys.symbol.gearshape'), label: '通用设置', showArrow: true }
        ]
      }
    ];
  }

  @Builder
  private mineHero() {
    Column({ space: 16 }) {
      Row({ space: 14 }) {
        Stack({ alignContent: Alignment.Center }) {
          Row()
            .width(64)
            .height(64)
            .backgroundColor($r('sys.color.comp_background_secondary'))
            .borderRadius(32)
          Text('LT')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
        }

        Column({ space: 6 }) {
          Row({ space: 8 }) {
            Text('刘婷')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('sys.color.font_primary'))
            Row({ space: 2 }) {
              SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
                .fontSize(11)
                .fontColor([$r('sys.color.font_tertiary')])
              Text('L3')
                .fontSize(11)
                .fontColor($r('sys.color.font_tertiary'))
            }
            .padding({ left: 5, right: 5, top: 1, bottom: 1 })
            .backgroundColor($r('sys.color.comp_background_secondary'))
            .borderRadius(8)
          }
          .alignItems(VerticalAlign.Center)

          Text('阳光护士（2024）')
            .fontSize(14)
            .fontColor($r('sys.color.font_secondary'))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize(20)
          .fontColor([$r('sys.color.font_tertiary')])
      }
      .width('100%')

    }
    .width('100%')
    .padding(16)
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(16)
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
    .onClick(() => {
      this.isProfileSheetOpen = true;
    })
    .bindSheet(this.isProfileSheetOpen, this.profileSheetBuilder, {
      height: SheetSize.MEDIUM,
      backgroundColor: $r('sys.color.background_secondary'),
      title: { title: '个人信息' },
      showClose: true,
      dragBar: true,
      onDisappear: () => {
        this.isProfileSheetOpen = false;
      }
    })
  }

  @Builder
  private profileSheetBuilder() {
    Column({ space: 16 }) {
      this.profileSheetGroup([
        { label: '形象', value: '', isAvatar: true }
      ])

      this.profileSheetGroup([
        { label: '昵称', value: '刘婷' },
        { label: '性别', value: '女' },
        { label: '出生日期', value: '1995-08-12' }
      ])

      this.profileSheetGroup([
        { label: '手机号', value: '138****8021' },
        { label: '实名认证', value: '**婷', tag: '已实名' }
      ])
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 24 })
    .backgroundColor($r('sys.color.background_secondary'))
  }

  @Builder
  private profileSheetGroup(items: ProfileSheetItem[]) {
    Column({ space: 0 }) {
      ForEach(items, (item: ProfileSheetItem, index: number) => {
        this.profileSheetRow(item, index !== items.length - 1)
      }, (item: ProfileSheetItem, index: number) => index.toString())
    }
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(16)
    .clip(true)
    .width('100%')
  }

  @Builder
  private profileSheetRow(item: ProfileSheetItem, showDivider: boolean) {
    Row({ space: 12 }) {
      Text(item.label)
        .fontSize(16)
        .fontColor($r('sys.color.font_primary'))
        .layoutWeight(1)

      if (item.isAvatar) {
        Stack({ alignContent: Alignment.Center }) {
          Row()
            .width(56)
            .height(56)
            .backgroundColor($r('sys.color.comp_background_secondary'))
            .borderRadius(28)
          Text('LT')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
        }
      } else {
        Row({ space: 8 }) {
          Text(item.value)
            .fontSize(16)
            .fontColor($r('sys.color.font_secondary'))

          if (item.tag) {
            Text(item.tag)
              .fontSize(12)
              .fontColor($r('sys.color.font_emphasize'))
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .backgroundColor($r('sys.color.comp_background_tertiary'))
              .borderRadius(6)
          }
        }
        .alignItems(VerticalAlign.Center)
      }

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize(16)
        .fontColor([$r('sys.color.font_tertiary')])
    }
    .width('100%')
    .height(item.isAvatar ? 76 : 56)
    .padding({ left: 16, right: 16 })
    .backgroundColor($r('sys.color.comp_background_primary'))
    .border({
      width: {
        bottom: showDivider ? 0.5 : 0
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private privilegeItem(icon: Resource, label: string) {
    Row({ space: 6 }) {
      SymbolGlyph(icon)
        .fontSize(16)
        .fontColor([$r('sys.color.font_primary')])
        .opacity(0.7)
      Text(label)
        .fontSize(13)
        .fontColor($r('sys.color.font_primary'))
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private mineStatsCard() {
    Row({ space: 0 }) {
      Column({ space: 4 }) {
        Text('28')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
        Text('负责长者')
          .fontSize(12)
          .fontColor($r('sys.color.font_secondary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 4 }) {
        Text('92%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
        Text('班次完成')
          .fontSize(12)
          .fontColor($r('sys.color.font_secondary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 4 }) {
        Text('4.9')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
        Text('服务评分')
          .fontSize(12)
          .fontColor($r('sys.color.font_secondary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 4 }) {
        Text('12h')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
        Text('培训时长')
          .fontSize(12)
          .fontColor($r('sys.color.font_secondary'))
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor($r('sys.color.comp_background_primary'))
    .borderRadius(16)
    .border({
      width: 0.5,
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private quickActionItem(item: QuickActionData) {
    Column({ space: 6 }) {
      Stack({ alignContent: Alignment.TopEnd }) {
        SymbolGlyph(item.icon)
          .fontSize(26)
          .fontColor([$r('sys.color.font_primary')])
          .opacity(0.75)
        if (item.badge) {
          Text(item.badge)
            .fontSize(10)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
            .padding({ left: 4, right: 4, top: 1, bottom: 1 })
            .backgroundColor('#FF3B30')
            .borderRadius(8)
            .offset({ x: 8, y: -4 })
        }
      }

      Text(item.label)
        .fontSize(13)
        .fontColor($r('sys.color.font_primary'))

      if (item.subLabel) {
        Text(item.subLabel)
          .fontSize(11)
          .fontColor($r('sys.color.font_secondary'))
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  private settingItem(item: SettingItemData, isLast: boolean) {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: new SymbolGlyphModifier(item.icon)
            .fontColor([$r('sys.color.font_primary')])
        }
      }),
      textItem: {
        primaryText: {
          text: item.label
        }
      },
      suffixItem: item.value ?
        new SuffixText({ text: item.value }) :
        new SuffixArrow({ color: $r('sys.color.font_tertiary') }),
      cardBorderRadius: 0,
      cardBackgroundColor: 'rgba(0,0,0,0)',
      cardHeight: 52,
      cardPrefixMargin: 0,
      cardSuffixMargin: 0,
      onClick: () => {
      }
    })
    .border({
      width: {
        bottom: isLast ? 0 : 0.5
      },
      color: $r('sys.color.comp_divider')
    })
  }

  @Builder
  private settingGroup(group: SettingGroupData) {
    Column({ space: 0 }) {
      if (group.title !== '') {
        Text(group.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
          .padding({ left: 16, right: 16, top: 14, bottom: 10 })
      }

      Column({ space: 0 }) {
        Repeat(group.items)
          .each((repeatItem: RepeatItem<SettingItemData>) => {
            this.settingItem(repeatItem.item, repeatItem.index === group.items.length - 1)
          })
      }
      .width('100%')
      .backgroundColor($r('sys.color.comp_background_primary'))
      .borderRadius(16)
      .clip(true)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private minePage() {
    List({
      scroller: this.currentScroller(),
      space: 16
    }) {
      ListItem() {
        this.mineHero()
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        top: this.topPadding()
      })

      ListItem() {
        this.mineStatsCard()
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding()
      })

      ListItem() {
        Column({ space: 0 }) {
          Text('常用功能')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.font_primary'))
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16, top: 14, bottom: 10 })

          Row({ space: 0 }) {
            this.quickActionItem(this.quickActions()[0])
            this.quickActionItem(this.quickActions()[1])
            this.quickActionItem(this.quickActions()[2])
            this.quickActionItem(this.quickActions()[3])
          }
          .width('100%')

          Row({ space: 0 }) {
            this.quickActionItem(this.quickActions()[4])
            this.quickActionItem(this.quickActions()[5])
            this.quickActionItem(this.quickActions()[6])
            this.quickActionItem(this.quickActions()[7])
          }
          .width('100%')
        }
        .padding({ bottom: 6 })
        .backgroundColor($r('sys.color.comp_background_primary'))
        .borderRadius(16)
        .border({
          width: 0.5,
          color: $r('sys.color.comp_divider')
        })
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding()
      })

      ListItem() {
        this.settingGroup(this.settingGroups()[0])
      }
      .padding({
        left: this.pagePadding(),
        right: this.pagePadding(),
        bottom: this.bottomPadding()
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.background_secondary'))
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  build() {
    if (this.currentTabIndex === 0) {
      this.homePage();
    } else if (this.currentTabIndex === 1) {
      this.elderPage();
    } else if (this.currentTabIndex === 2) {
      this.taskPage();
    } else {
      this.minePage();
    }
  }
}
