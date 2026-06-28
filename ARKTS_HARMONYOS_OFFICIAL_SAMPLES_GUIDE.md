# ArkTS / ArkUI / HDS 官方示例项目学习文档

本文基于 `D:\HMOS_CODEX` 下 15 个官方示例工程的静态分析整理，面向需要辅助开发 HarmonyOS NEXT 原生应用的大模型或开发者。重点不是复述 TypeScript，而是说明 ArkTS、ArkUI 声明式 UI、HarmonyOS Ability/Kit、HDS 组件和多端适配在这些项目里是怎样落到代码里的。

## 1. 先建立整体心智模型

ArkTS 是 HarmonyOS 原生应用的主开发语言，语法接近 TypeScript，但工程运行在 OpenHarmony/HarmonyOS 的 ArkUI 声明式框架和 Ability 生命周期中。常见源码扩展名是 `.ets`。

一个典型项目由这些层组成：

- `app.json5`：应用级配置，例如 `bundleName`、图标、版本。
- `module.json5`：模块配置，声明 `entry`/`har`/`shared` 模块、Ability、ExtensionAbility、权限、设备类型、路由表。
- `build-profile.json5`、`hvigorfile.ts`、`oh-package.json5`：构建、模块依赖和包管理。
- `src/main/ets/entryability/EntryAbility.ets`：应用主窗口生命周期，常在 `onWindowStageCreate` 中 `loadContent`。
- `src/main/ets/pages`、`view`、`component`：ArkUI 页面和组件。
- `src/main/resources/base/profile/main_pages.json`：传统页面路由。
- `src/main/resources/base/profile/router_map.json`：新式命名路由，把 `name` 映射到 `pageSourceFile` 和 `buildFunction`。
- `resources/base/media`、`resources/base/element`：图片、颜色、字符串、尺寸等资源，用 `$r('app.string.xxx')` 引用。

ArkUI 的核心写法是：

```ts
@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  @Builder
  TabItem(title: Resource, index: number) {
    Text(title)
      .fontColor(this.currentIndex === index ? Color.Red : Color.Gray)
      .onClick(() => {
        this.currentIndex = index;
      })
  }

  build() {
    Column() {
      this.TabItem($r('app.string.home'), 0)
    }
    .width('100%')
    .height('100%')
  }
}
```

可以把它理解为“组件函数 + 链式属性 + 响应式状态”。`build()` 内创建 UI 树，`@State`、`@StorageLink`、`@Local` 等状态变化会驱动 UI 刷新。

## 2. ArkTS/ArkUI 语法和状态规则

### 2.1 组件、页面和 Builder

- `@Entry` 表示模块启动页面；一个 `main_pages.json` 页面通常指向带 `@Entry` 的组件。
- `@Component` 是 ArkUI V1 自定义组件。
- `@ComponentV2` 是新状态管理风格，常与 `@Local`、`@Param`、`@Event`、`@Provider`、`@Consumer`、`@Monitor`、`@ObservedV2`、`@Trace` 搭配。
- `struct Xxx { build() { ... } }` 定义 UI 组件，不是普通 class。
- `@Builder` 定义可复用 UI 片段，可传参，可作为 slot/回调传给组件。
- `@BuilderParam` 用于把外部 builder 传入组件。
- `@Reusable` 标记可复用组件，常和长列表、`LazyForEach` 结合做性能优化。

### 2.2 ArkUI V1 状态装饰器

这些项目里 V1 使用非常多：

- `@State`：组件内部状态，变化触发本组件刷新。
- `@Prop`：父传子单向传值。
- `@Link`：父子双向绑定。
- `@Provide` / `@Consume`：跨层级依赖注入。
- `@ObjectLink`：观察对象引用内的变化，常配合 `@Observed`。
- `@Observed`：让类实例可被观察。
- `@StorageProp` / `@StorageLink`：连接 `AppStorage` 全局状态，前者单向读，后者双向。
- `@LocalStorageProp` / `@LocalStorageLink`：连接页面级 `LocalStorage`。
- `PersistentStorage.persistProp()`：把状态持久化，Account Kit 示例用它模拟静默登录用户数据。

### 2.3 ArkUI V2 状态装饰器

2026 年示例中大量项目改用 V2：

- `@ComponentV2`：V2 自定义组件。
- `@Local`：组件内部响应式状态。
- `@Param`：外部参数；`@Require @Param` 表示必传。
- `@Event`：外部事件回调。
- `@Provider` / `@Consumer`：V2 依赖注入。
- `@Env(SystemProperties.BREAK_POINT)`：订阅系统环境，例如宽高断点。
- `@Monitor('state.field')`：监听状态字段变化。
- `@ObservedV2` + `@Trace`：声明可观察模型类和可追踪字段。
- `AppStorageV2.connect(ModelClass, key, factory)`：连接全局 V2 状态对象。`MusicHome` 用它保存播放队列、播放进度、全屏播放器开关和 HDS mini bar 展开状态。

### 2.4 UI 组件和链式属性

常用容器和组件：

- 布局：`Column`、`Row`、`Flex`、`Stack`、`RelativeContainer`、`GridRow`、`GridCol`。
- 列表：`List`、`ListItem`、`ListItemGroup`、`LazyForEach`、`Repeat`、`WaterFlow`、`Grid`。
- 导航：`Navigation`、`NavDestination`、`NavPathStack`、`Tabs`、`TabContent`。
- 基础控件：`Text`、`Button`、`Image`、`SymbolGlyph`、`Blank`、`Search`、`TextInput`。
- 媒体和扩展：`Video`、`Web`、`Canvas`、`XComponent`、`NodeContainer`。

链式属性用于布局和交互，例如：

- 尺寸：`.width()`、`.height()`、`.constraintSize()`、`.layoutWeight()`。
- 样式：`.fontSize()`、`.fontColor()`、`.backgroundColor()`、`.borderRadius()`、`.shadow()`。
- 安全区：`.expandSafeArea()`、`.ignoreLayoutSafeArea()`、`.clipContent(ContentClipMode.SAFE_AREA)`。
- 事件：`.onClick()`、`.onChange()`、`.onSizeChange()`、`.onBackPressed()`、`.onShown()`。
- 动效：`.animation()`、`.transition()`、`.geometryTransition()`、`animateTo()`、`.bindContentCover()`、`.bindSheet()`。

## 3. 路由和页面组织

### 3.1 传统 router

`multi-tab-navigation-master` 和 `multi-convenient-life-master` 使用：

```ts
this.getUIContext().getRouter().pushUrl({ url: 'pages/BottomTab' })
```

这种方式依赖 `main_pages.json` 中列出的页面路径，适合简单页面跳转。

### 3.2 Navigation + NavPathStack

多数新工程使用：

```ts
@Provider('NavPathStack') pageStack: NavPathStack = new NavPathStack();

Navigation(this.pageStack) {
  // root content
}
.mode(NavigationMode.Stack)
.navDestination(this.PagesMap)
```

跳转：

```ts
this.pageStack.pushPathByName('ExamplePage', null);
this.pageStack.pushPath({ name: 'DetailView', param: { currentIndex: 0 } });
```

页面映射方式有两种：

- 在组件内用 `.navDestination(this.PagesMap)` 手写 `name -> 组件`。
- 在 `router_map.json` 中声明 `name`、`pageSourceFile`、`buildFunction`，由系统动态加载。

### 3.3 HDS Navigation

`MusicHome`、`MultiDeviceCommunication`、`Spatialization`、`sample_in_harmonyos` 使用 `HdsNavigation`、`HdsTabs`、`HdsNavDestination`。它们是在 ArkUI 导航之上加了鸿蒙设计体系的标题栏、材质、悬浮 Tab、滚动联动等能力。

典型写法：

```ts
HdsNavigation(this.pathStack) {
  HdsTabs({ barPosition: BarPosition.End }) {
    TabContent() { RecommendPage() }
      .tabBar(this.TabBarItem(0, $r('app.string.tab_home'), $r('sys.symbol.house_fill')))
  }
  .barFloatingStyle({
    systemMaterialEffect: {
      materialType: hdsMaterial.MaterialType.ADAPTIVE,
      materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
    }
  })
}
.mode(NavigationMode.Stack)
.hideTitleBar(true)
```

## 4. 多端适配和窗口信息

这些示例体现了 HarmonyOS “一次开发，多端部署”的实际写法：

- `@Env(SystemProperties.BREAK_POINT)` 读取系统断点。
- `UIContext.getWindowWidthBreakpoint()`、`getWindowHeightBreakpoint()` 读取窗口宽高断点。
- `window.Window.on('windowSizeChange')` 监听窗口变化。
- `window.Window.getWindowAvoidArea()` 读取状态栏、导航条、键盘、挖孔等避让区域。
- `display.getDefaultDisplaySync()` 读取屏幕宽高和方向。
- `display.isFoldable()`、`display.getFoldStatus()`、`display.on('foldStatusChange')` 适配折叠屏。
- 工程内常封装 `WidthBreakpointType` / `BreakpointType`，按 `sm/md/lg/xl` 返回不同布局参数。

典型封装来自 `ResponsiveLayout-master`：

```ts
export class WidthBreakpointType<T> {
  constructor(public sm: T, public md: T, public lg: T, public xl: T) {}

  getValue(widthBp: WidthBreakpoint): T {
    if (widthBp === WidthBreakpoint.WIDTH_XS || widthBp === WidthBreakpoint.WIDTH_SM) {
      return this.sm;
    }
    if (widthBp === WidthBreakpoint.WIDTH_MD) {
      return this.md;
    }
    return widthBp === WidthBreakpoint.WIDTH_LG ? this.lg : this.xl;
  }
}
```

## 5. HDS 和新视觉体系

HDS 相关包在这些项目中以两种形式出现：

- `@kit.UIDesignKit`：`HdsNavigation`、`HdsTabs`、`HdsNavDestination`、`hdsMaterial`、`ScrollEffectType`。
- `@hms.hds.hdsBaseComponent`：`HdsTabs`、`HdsBarStyle` 等基础 HDS 组件。

使用 HDS 时重点关注：

- 对 API 版本做分支：`deviceInfo.distributionOSApiVersion >= 60100` 时启用更高级的悬浮 HDS Tab，否则回退到原生 `Navigation/Tabs`。
- HDS 材质通过 `systemMaterialEffect` 设置 `MaterialType.ADAPTIVE/IMMERSIVE` 和 `MaterialLevel.ADAPTIVE`。
- `barFloatingStyle` 支持 `barWidth`、`barBottomMargin`、`miniBar`，可实现音乐 mini player 和自适应悬浮底栏。
- `HdsNavigation.titleBar()` 可绑定滚动对象，做渐变模糊标题栏。

## 6. 顶层项目逐项说明

### 6.1 `account-kit-samplecode-clientdemo-for-atomicservice-arkts-master`

效果：元服务购物/我的页面，启动后尝试华为账号静默登录；个人页可通过 Account Kit 的 `FunctionalButton` 获取头像、手机号、收货地址、发票抬头；支持未成年人模式状态读取、引导开启、密码校验、公共事件联动。

实现要点：

- `Index.ets` 使用 `@Entry(storage)` 传入 `LocalStorage`。
- `PersistentStorage.persistProp('silentLoginMap', new Map<string, UserInfo>([]))` 持久化模拟静默登录数据。
- `authentication.HuaweiIDProvider().createLoginWithHuaweiIDRequest()` 创建登录请求。
- `loginRequest.forceLogin = false` 表示只做静默登录，不拉起登录 UI。
- `util.generateRandomUUID()` 生成 `state`，响应后校验防 CSRF。
- `AuthenticationController.executeRequest()` 返回 `LoginWithHuaweiIDResponse`，从 `authorizationCode` 和 `unionID` 继续业务处理。
- `minorsProtection.supportMinorsMode()` 和 `getMinorsProtectionInfoSync()` 检查未成年人模式。
- `canIUse('SystemCapability.AuthenticationServices.HuaweiID.MinorsProtection')` 做系统能力判断。
- `display.getDefaultDisplaySync()`、`.onSizeChange()`、`px2vp()` 判断横屏、Pad、Phone，切换底部/侧边导航。

关键文件：`entry/src/main/ets/pages/Index.ets`、`PersonalInfoPage.ets`、`components/Avatar.ets`、`Phone.ets`、`Address.ets`、`InvoiceTitle.ets`、`MinorsProtection.ets`、`common/CommonEventUtil.ets`。

### 6.2 `map-kit_-sample-code_-demo-arkts-master`

效果：Map Kit 功能集合，首页进入 MapController、Overlay、StaticMap、NaviDemo、AdvancedControls 五类示例，覆盖地图显示、相机移动、定位、Marker/Circle/Polyline/Polygon 覆盖物、静态图、地点搜索、路线和高级控件。

实现要点：

- `Index.ets` 在 `aboutToAppear` 中用 `abilityAccessCtrl.createAtManager().requestPermissionsFromUser()` 申请 `LOCATION` 和 `APPROXIMATELY_LOCATION`。
- 首页用 `Navigation(this.pathStack)` 和 `NavPathStack.pushPathByName()` 跳转。
- 各页面用 `NavDestination()` 承载目标页面，在 `.onReady((context: NavDestinationContext) => ...)` 中拿上下文或参数。
- 地图能力来自 `@kit.MapKit`，定位来自 `@kit.LocationKit`。
- `MapControllerDemo` 主要演示地图控制器移动相机、获取位置、开启我的位置。
- `OverlayDemo` 演示 `addMarker`、`addPolygon`、`addCircle`、`addPolyline`。
- `StaticMapDemo` 演示 `getMapImage()` 返回 `PixelMap`。
- `NaviDemo` 演示驾车、步行、骑行路线和距离矩阵。
- `AdvancedControlsDemo` 演示地点详情、位置选择、文本搜索、附近搜索、自动补全、逆地理编码。

关键文件：`entry/src/main/ets/pages/Index.ets`、`MapControllerDemo.ets`、`OverlayDemo.ets`、`StaticMapDemo.ets`、`NaviDemo.ets`、`AdvancedControlsDemo.ets`。

### 6.3 `multi-convenient-life-master`

效果：便捷生活多端页面，包含点餐列表、图文详情、生活主页三类业务页面，在直板机、折叠屏和平板上通过响应式布局呈现不同结构。

实现要点：

- 首页使用 `router.pushUrl()` 跳转到 `pages/FoodList`、`pages/GraphicText`、`pages/Living`。
- `window.getLastWindow()` + `getWindowAvoidArea()` 获取系统栏和导航指示器高度，写入 `AppStorage`。
- `@StorageLink('currentBreakpoint')`、`@StorageLink('windowTop')`、`@StorageLink('windowBottom')` 在页面和子组件之间共享断点和安全区。
- 点餐页通常由 `ShopHeader`、`ShopSideBar`、`ShopMenu`、`FoodItem` 等组件拼装，实现左侧分类、右侧菜品、详情页和评论。
- 图文页由 `GraphicTextHeader`、`GraphicTextSwiper`、`GraphicTextDescriptions`、`GraphicTextComments`、`GraphicTextFooter` 组合。
- 生活页由 `LivingHome`、`LivingComments` 等组件组合。

关键文件：`entry/src/main/ets/pages/Index.ets`、`pages/FoodList.ets`、`pages/GraphicText.ets`、`pages/Living.ets`、`components/*`。

### 6.4 `multi-tab-navigation-master`

效果：常见 Tab 导航样式集合，覆盖底部导航、舵式底部导航、视频滑动 Tab、顶部左侧 Tab、下划线 Tab、背景高亮 Tab、文字 Tab、双层嵌套 Tab、滑动更多 Tab、侧边 Tab、抽屉 Tab。

实现要点：

- 首页用 `Constants.ROUTES` 定义分组和子路由，再用 `ForEach` 渲染列表。
- 点击列表项时调用 `this.getUIContext().getRouter().pushUrl({ url: 'pages/' + itemChild.to })`。
- 各页面核心都是 `Tabs` + `TabContent`，通过 `.barPosition()`、`.vertical()`、`.barMode()`、自定义 `.tabBar()` 实现不同导航形态。
- 视频滑动等场景结合 `Swiper`、`List`、`display.getDefaultDisplaySync()` 控制内容宽度。
- 自定义图标、字体大小、选中态颜色、下划线、抽屉宽度等集中在 `Constants.ets`。

关键文件：`entry/src/main/ets/pages/Index.ets`、`common/Constants.ets`、`pages/*Tab.ets`、`view/VideoTabContent.ets`。

### 6.5 `MultiCommunityApplication-master`

效果：社区类应用多产品工程，包含主页、热门、视频、我的、社区详情、评论区、关注列表、帖子卡片等社区场景，同时提供默认产品和 PC 产品。

实现要点：

- 工程拆成 `product/default`、`product/pc`、`features/*`、`common/*`。
- `features/commoncommunityui` 提供通用 UI 组件，`features/contentcommunity` 提供内容社区，`features/socialcommunity` 提供社交社区。
- PC 端使用 `@ComponentV2`、`@Provider() pathStack`、`@Local tabs/currentIndex/navigationMode`。
- 产品入口通过 `Tabs` 或 HDS Tab 切换 `HomePage`、`HotPage`、`VideoPage`、`MinePage`。
- `NavPathStack` 注入到各 feature，详情页通过命名路由进入。
- `@kit.UIDesignKit` 和 `@ohos.arkui.observer` 用于新设计和窗口/布局观察。

关键文件：`product/default/src/main/ets/pages/Index.ets`、`product/pc/src/main/ets/pages/Index.ets`、`features/*/src/main/resources/base/profile/router_map.json`。

### 6.6 `MultiDeviceCommunication-master`

效果：多设备通信风格应用，包含消息、联系人、社交、我的四个 Tab 和消息详情、联系人列表、社交列表等页面；默认端和 PC 端布局不同。

实现要点：

- PC 端入口用 `@ComponentV2`、`@Env(SystemProperties.BREAK_POINT)`、`HdsNavigation`、`HdsTabs`。
- 当 `deviceInfo.distributionOSApiVersion >= 60100` 时启用 HDS 悬浮 Tab 和沉浸材质；低版本回退原生 `Navigation + Tabs`。
- `changeNavigationMode()` 根据当前 Tab 切换 `NavigationMode.Auto` 或 `NavigationMode.Stack`。
- `TabBarListModel().loadTabs()` 统一生成 Tab 元数据。
- `BuildDirtyDataUtil.buildDirtyData()` 构造演示数据。
- `features/message`、`features/social`、`features/user` 和 `features/commonui` 通过 HAR 依赖复用。

关键文件：`products/default/src/main/ets/pages/Index.ets`、`products/pc/src/main/ets/pages/Index.ets`、`features/*/router_map.json`、`common/commonmultidevicecommunication`。

### 6.7 `MusicHome-master`

效果：音乐专辑/音乐首页应用，覆盖 phone/default、PC、TV、watch 多产品。默认端有推荐流、沉浸式 HDS 底部 Tab、悬浮 mini player、全屏播放页；watch/TV/PC 有各自入口布局。

实现要点：

- 使用 `@ComponentV2`、`@ObservedV2`、`@Trace` 和 `AppStorageV2.connect()` 管全局播放状态。
- `MusicAppState` 保存队列、当前索引、播放进度、音量、全屏播放器开关、mini bar 展开状态。
- `aboutToAppear()` 从 `MusicDbApi` 初始化播放队列。
- `@Monitor('intentState.requestVersion')` 监听外部播放意图，调用 `dispatchShellPlaybackIntent()` 后用 `animateTo()` 打开播放器。
- API 601+ 使用 `HdsNavigation` + `HdsTabs.barFloatingStyle()` 创建自适应悬浮底栏和 mini bar；低版本回退普通 HDS Tab。
- `.bindContentCover(this.appState.isShowPlay, PlaybackPageCoverContent(), ModalTransition.NONE)` 显示全屏播放层。
- `@kit.MediaKit`、`@kit.AVSessionKit`、`@kit.ImageKit`、`@kit.ArkGraphics2D` 支撑媒体播放、会话、图片取色/背景。

关键文件：`products/default/src/main/ets/pages/Index.ets`、`common/musicbasic/src/main/ets/model/MusicAppState.ets`、`features/player`、`features/recommendation`、`features/playlist`。

### 6.8 `NavigationSettings-master`

效果：设置应用样式，多产品工程，包含 WLAN、更多连接、NFC、详情页等层级页面，PC 和默认产品各自适配。

实现要点：

- 使用 `@ComponentV2` 参数化页面：`@Param windowInfo`、`@Require @Param wlanData`、`@Event onToggle`、`@Event onSettingClick`。
- 列表页通过 `SettingsViewModel`、`WlanViewModel` 等 ViewModel 构造数据。
- `SettingsView` 中调用 `pageStack.pushPathByName('WlanPage', null)`、`pushPathByName('multisettingDetailPage', item.title)` 进入二级页面。
- 通过 `WindowInfo`、标题栏空白高度和 `Scroller` 做不同设备上的详情/列表布局。
- `@kit.UIDesignKit` 负责 HDS 风格导航和系统视觉。

关键文件：`products/default/src/main/ets/pages/Index.ets`、`products/pc/src/main/ets/pages/Index.ets`、`products/pc/src/main/ets/view/*`、`common/multisettingbase`。

### 6.9 `push-kit-sample-code-clientdemo-arkts-master`

效果：Push Kit 客户端示例，演示申请 Push Token、推送通知消息、撤回消息、卡片刷新消息、TTS 消息、后台消息、实况窗消息、应用内通话消息，并带服务卡片。

实现要点：

- 首页用 `Navigation(this.pageStack)` 和 `.navDestination(this.PagesMap)` 管 `pushToken` 与 `ExamplePage`。
- `GetTokenPage` 申请 Push Token。
- `notificationManager.setBadgeNumber(0)` 清理角标。
- `EntryFormAbility` 和 `widget/pages/WidgetCard.ets` 展示服务卡片，使用 `@LocalStorageProp('formId')`、`text_key`、`image_key` 读取卡片数据。
- `@kit.PushKit`、`@kit.NotificationKit`、`@kit.FormKit`、`@kit.CallServiceKit` 分别支撑 Push、通知、卡片和通话。

关键文件：`entry/src/main/ets/pages/Index.ets`、`GetTokenPage.ets`、`ExamplePage.ets`、`entryformability/EntryFormAbility.ets`、`widget/pages/WidgetCard.ets`。

### 6.10 `ResponsiveLayout-master`

效果：一多响应式布局样板，覆盖 List、WaterFlow、Swiper、Grid、Sidebar、双栏、会话双栏、三栏、邮件三栏、日历三栏、移动布局、底部/侧边 Tabs、缩进布局。

实现要点：

- `Index.ets` 创建 `@Provide('pageInfos') pageInfos: NavPathStack`。
- `ListJumpView` 根据 `WidthBreakpointType(1, 2, 2, 2).getValue(widthBp)` 设置 `List.lanes()`。
- `WindowUtil` 封装窗口状态、窗口大小变化、避让区域、宽高断点、沉浸式、分屏、方向和窗口限制。
- 各布局页面按断点切换 `columnsTemplate`、`lanes`、`NavigationMode`、侧栏宽度、内容列数。
- `WaterFlowView` 用 `columnsTemplate(repeat(n, 1fr))` 做瀑布流列数适配。

关键文件：`entry/src/main/ets/pages/Index.ets`、`utils/WindowUtil.ets`、`utils/WidthBreakpointType.ets`、`views/*View.ets`。

### 6.11 `sample_in_harmonyos-master`

效果：HarmonyOS 示例集合应用，覆盖 phone、PC、TV、wearable 产品，包含首页、探索、开发实践、组件库、我的、服务卡片、UIExtension、快捷方式等。

实现要点：

- 多产品目录：`products/phone`、`products/pc`、`products/tv`、`products/wearable`。
- 多 feature 模块：`abilitycommon`、`commonbusiness`、`componentlibrary`、`devpractices`、`exploration`、`mine`、`widgetcommon`。
- `module.json5` 声明 `routerMap`、`EntryAbility`、`PhoneFormAbility`、`UIExtensionAbility`、权限、快捷方式、窗口最小尺寸。
- `MainPage.ets` 用 `HdsNavDestination` 承载 `HomeView`，通过 `onBackPressed` 实现双击退后台。
- `@StorageProp(StorageKey.GLOBAL_INFO)` 获取全局窗口和断点信息。
- `@Watch('handleColorModeChange')` 监听深浅色模式变化，联动状态栏颜色。
- `router_map.json` 把 `ComponentListView`、`ComponentDetailView`、`PracticesView`、`SampleDetailView`、`ExplorationView`、`ArticleDetailView` 等动态页面映射到 build function。

关键文件：`products/phone/src/main/ets/page/MainPage.ets`、`products/phone/src/main/module.json5`、`features/*/router_map.json`、`common/src/main/ets`。

### 6.12 `Spatialization-master`

效果：空间化/HDS 新视觉示例，展示首页沉浸光感、自适应悬浮导航、智能握姿交互三个场景，在直板、折叠屏、平板上呈现不同视觉。

实现要点：

- 使用 `@kit.UIDesignKit` 的 `HdsNavigation`、`hdsMaterial`、`ScrollEffectType`。
- `MainPage` 用 HDS 标题栏、渐变模糊滚动效果、系统材质和 `List.lanes()` 做响应式列表。
- `GlobalInfoModel` 通过 `AppStorageV2.connect()` 连接全局信息。
- `BreakpointType` 根据 `widthBreakpoint` 选择 padding、列表列数和间距。
- `AdaptiveTabView` 展示悬浮 Tab，`ImmersiveLightView` 展示沉浸光感，`SmartReachView` 结合 `@kit.MultimodalAwarenessKit` 做握姿/智能交互。

关键文件：`products/entry/src/main/ets/pages/MainPage.ets`、`view/AdaptiveTabView.ets`、`view/ImmersiveLightView.ets`、`view/SmartReachView.ets`、`util/BreakpointSystem.ets`。

### 6.13 `transitions-collection-master`

效果：转场动效合集，包括多模态页面转场、搜索一镜到底、卡片一镜到底、图片一镜到底、视频一镜到底、列表一镜到底、图书翻页一镜到底。

实现要点：

- 首页 `Navigation(this.pageInfos)` 配合 `customNavContentTransition()` 统一拦截导航转场。
- 通过 from/to `NavContentInfo.name` 白名单判断是否启用自定义转场。
- `CustomTransition` 单例保存不同页面注册的动画参数和交互代理。
- `NavigationAnimatedTransition` 中实现 `transition(transitionProxy)` 和 `onTransitionEnd()`。
- 搜索、列表等简单一镜到底使用 `.geometryTransition(id)` 绑定前后页面同一元素。
- 卡片、视频、图书翻页使用 `customNavContentTransition`、`componentSnapshot`、Node 迁移等高级能力。
- 多模态使用 `.bindSheet()`、`.bindContentCover()`、`TransitionEffect.asymmetric()`、`TransitionEffect.move()`。
- 图片放大/半模态使用 `NodeContainer`、`NodeController` 实现跨节点迁移。

关键文件：`entry/src/main/ets/pages/Index.ets`、`utils/customtransition/*`、`feature/*LongTakeTransition*`。

### 6.14 `visionkit-sample-code-arkts-master`

效果：Vision Kit 人脸活体检测控件，点击开始检测后拉起检测流程，返回成功/失败结果并展示。

实现要点：

- API 来自 `@kit.VisionKit`。
- `startLivenessDetection(config)` 进入活体检测控件。
- `getInteractiveLivenessResult()` 获取检测结果。
- 需要 `ohos.permission.CAMERA`。
- 页面非常小，主要用于展示异步调用、结果状态和错误处理。

关键文件：`entry/src/main/ets/pages/Index.ets`。

### 6.15 `cases-master`

效果：大型 HarmonyOS NEXT 应用开发案例集和性能案例库，顶层包括 `CommonAppDevelopment`、`docs/performance`、`test/performance`、DevEco 插件和工具 skill。

实现要点：

- `CommonAppDevelopment/feature` 下有 169 个功能案例，绝大多数都有 `README.md`、`Index.ets`、`src/main/module.json5`。
- `CommonAppDevelopment/common/routermodule` 提供动态路由基础设施。
- 很多 feature 通过 `@AppRouter({ name: 'xxx/PageName' })` 注册到案例主工程。
- `docs/performance` 是性能优化文档库，覆盖冷启动、长列表、线程、Web、动画、状态管理、AOT、SmartPerf、ArkUI Inspector 等。
- `test/performance` 放可运行的性能对比工程，例如 Web 预加载/预连接、启动导入优化、TaskPool、跨线程序列化、Native 绘制替代 Canvas、滑动白块解决等。

重要功能分类：

- UI 基础和布局：`customview`、`dynamicattributes`、`componentstack`、`multicolumndisplay`、`imagegridlayout`、`sidebaranimation`、`tabs` 相关案例。
- 导航和弹窗：`navdestinationdialog`、`navigationinterceptor`、`navigationparametertransfer`、`modalwindow`、`customdialog`、`encapsulationdialog`、`limitedheightbottomdialog`。
- 动画和手势：`clickanimation`、`cuberotateanimation`、`cardswiperanimation`、`transitionanimation`、`pageturninganimation`、`pageflip`、`waterripples`、`dragandexchange`、`dragtoswitchpictures`。
- 图片和视觉：`imageviewer`、`imagecompression`、`imagemosaic`、`palette`、`blendmode`、`backgroundblur`、`watermark`、`decodeheifimage`、`handwritingtoimage`。
- 媒体：`shortvideo`、`videocache`、`videocreategif`、`videolinkagelist`、`videolistautoplay`、`mediafullscreen`、`danmakuplayer`、`voicerecordynamiceffect`。
- Web/H5：`h5cache`、`customkeyboardtoh5`、`webcustompressmenu`、`webgetcameraimage`、`webpagesnapshot`、`webpdfviewer`。
- 文件和数据：`bigfilecopy`、`compressfile`、`decompressfile`、`multiplefilesdownload`、`databaseupgrade`、`nativerawfile`、`nativesavepictosandbox`。
- 系统能力和 Kit：`bluetooth`、`faceandfingerprintunlocking`、`vibrateeffect`、`networkstatusobserver`、`mapthumbtack`、`customscan`、`wordrecognition`、`addressrecognize`。
- 多端适配：`foldablescreencases`、`multiplescreening`、`immersive`、`keyboardavoid`、`diggingholescreen`。
- 性能：`perfermance/customreusablepool`、`perfermance/highlyloadedcomponentrender`、`perfermance/imperativedynamiclayouts`、`perfermance/operaterdbintaskpool`，以及 `test/performance/*`。

## 7. 官方实现模式总结

### 7.1 页面入口模式

简单示例：

```ts
@Entry
@Component
struct Index {
  build() {
    Column() {}
      .width('100%')
      .height('100%')
  }
}
```

多页面示例：

```ts
@Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();

Navigation(this.pageInfos) {
  // root
}
.mode(NavigationMode.Stack)
```

HAR feature 示例：

```ts
@Builder
export function MainPageBuilder() {
  MainPage()
}
```

然后在 `router_map.json` 中：

```json
{
  "name": "MainPage",
  "pageSourceFile": "src/main/ets/page/MainPage.ets",
  "buildFunction": "MainPageBuilder"
}
```

### 7.2 数据和 ViewModel 模式

官方示例倾向于：

- 用 `model/*Model.ets` 定义纯数据模型。
- 用 `viewmodel/*ViewModel.ets` 生成页面数据。
- 用 `common/*Constants.ets` 管颜色、尺寸、路由名、Tab index、动画时长。
- 不在 `build()` 里写复杂业务；复杂逻辑放私有方法或 util。
- 异步 Kit 调用用 `try/catch` 或 Promise `.catch((err: BusinessError) => ...)`。

### 7.3 权限和系统能力模式

申请权限：

```ts
const atManager = abilityAccessCtrl.createAtManager();
atManager.requestPermissionsFromUser(context, ['ohos.permission.LOCATION'])
  .catch((err: BusinessError) => {
    hilog.error(0x0000, 'TAG', `permission failed: ${err.code}, ${err.message}`);
  });
```

能力判断：

```ts
if (canIUse('SystemCapability.AuthenticationServices.HuaweiID.MinorsProtection')) {
  // safe call
}
```

`module.json5` 中还要声明 `requestPermissions`，否则运行时申请没有意义。

### 7.4 资源引用模式

- 字符串：`$r('app.string.title')`
- 图片：`$r('app.media.icon')`
- 系统符号：`$r('sys.symbol.chevron_right')`
- 系统颜色/尺寸：`$r('sys.color.font_primary')`、`$r('sys.float.padding_level8')`
- 自定义颜色：`$r('app.color.background')`

不要把多语言文本硬编码到页面，官方项目基本都通过资源系统管理。

### 7.5 性能模式

从 `cases-master/docs/performance` 和示例可提炼：

- 长列表优先用 `LazyForEach`、`Repeat`、`@Reusable`、合理 `cachedCount/cacheCount`。
- 避免在 `build()` 或高频回调中做耗时计算、I/O、同步网络、复杂 JSON。
- 列表 item 尽量拆为稳定小组件，减少状态污染和渲染范围。
- 对大任务使用 `taskpool`、`worker` 或 Native/Node API。
- Web 场景用预连接、预下载、预渲染、预启动 Web 引擎减少白屏。
- 冷启动避免冗余 import/export、避免启动阶段 HTTP 请求和重资源初始化。
- Canvas 高负载场景考虑 Native Drawing 或降低主线程压力。
- 动画使用系统 `animateTo`、属性动画、`geometryTransition`、Navigation 自定义转场，避免 JS 侧逐帧做重逻辑。

## 8. 大模型开发 ArkTS 时的工作流程

1. 先识别工程类型：单 entry demo、多 product、多 HAR feature、元服务、服务卡片、性能测试工程。
2. 读取 `module.json5`，确认 Ability、ExtensionAbility、权限、`pages`、`routerMap` 和设备类型。
3. 读取入口 `EntryAbility.ets`，确认实际 `loadContent` 的页面。
4. 读取 `main_pages.json` 和 `router_map.json`，建立页面名到源码的映射。
5. 修改 UI 前先找 `common/constants`、`model`、`viewmodel`、`utils`，复用已有模式。
6. 如果项目已有 HDS，优先用 `HdsNavigation/HdsTabs/HdsNavDestination`，不要混入完全不同的导航体系。
7. 如果项目使用 `@ComponentV2`，新组件也优先使用 V2 状态；如果项目是 V1，保持 V1。
8. 多端布局优先使用断点、`WindowUtil`、`BreakpointType`，不要只按像素硬编码。
9. Kit 调用必须检查权限、`canIUse`、错误码和 `BusinessError`。
10. 最后运行可用的构建/检查命令；如果本机没有 DevEco/Hvigor 环境，至少做静态路径和语法一致性检查。

## 9. 推荐按需求回查的源码

- 新手入门 ArkUI：`multi-tab-navigation-master/entry/src/main/ets/pages/Index.ets`
- Navigation/命名路由：`map-kit_-sample-code_-demo-arkts-master/entry/src/main/ets/pages/Index.ets`
- HDS 悬浮 Tab：`MusicHome-master/products/default/src/main/ets/pages/Index.ets`
- V2 状态管理：`MusicHome-master/common/musicbasic/src/main/ets/model/MusicAppState.ets`
- 多端窗口和避让区：`ResponsiveLayout-master/entry/src/main/ets/utils/WindowUtil.ets`
- 响应式布局：`ResponsiveLayout-master/entry/src/main/ets/views/*`
- 元服务账号：`account-kit-samplecode-clientdemo-for-atomicservice-arkts-master/entry/src/main/ets/pages/Index.ets`
- Push/卡片：`push-kit-sample-code-clientdemo-arkts-master/entry/src/main/ets/pages/Index.ets`
- 转场动画：`transitions-collection-master/entry/src/main/ets/pages/Index.ets`
- 大型样例集合路由：`sample_in_harmonyos-master/products/phone/src/main/ets/page/MainPage.ets`
- 性能案例：`cases-master/docs/performance` 和 `cases-master/test/performance`
