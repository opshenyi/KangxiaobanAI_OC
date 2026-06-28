# 多设备即时通讯界面

## 项目简介

基于自适应和响应式布局，实现一次开发、多端部署-即时通讯。

## 效果预览

| 阔折叠（小屏幕）                                           | 直板机                                                | 双折叠                                               |
|----------------------------------------------------|----------------------------------------------------|---------------------------------------------------|
| <img src='screenshots/device/purax.png' width=160> | <img src='screenshots/device/phone.png' width=180> | <img src='screenshots/device/fold.png' width=330> |

| 平板                                               | 电脑                                              |
|--------------------------------------------------|-------------------------------------------------|
| <img src='screenshots/device/pad.png' width=480> | <img src='screenshots/device/pc.png' width=620> |

## 使用说明

1. 分别在直板机、双折叠、阔折叠、平板、PC安装并打开应用，不同设备的应用页面通过响应式布局和自适应布局呈现不同的效果。
2. 点击消息列表页跳跳转到消息详情页，点击消息详情页头像，跳转到个人主页。
3. 点击通讯路列表页跳转到个人主页。
4. 点击朋友圈，跳转到朋友圈列表页。
5. 在底部标签页来回切换，每次点击消息/通讯录按钮，如果是在双折叠展开/pad/PC/2in1这些设备下，默认加载列表第一条内容的详情。
6. 当在双折叠折叠状态下，选中消息/通讯录列表页，展开折叠机，默认加载列表第一条内容的详情。

## 工程目录

```
├──common
│  └──commonmultidevicecommunication                                     
│     └──src/main
│        ├──ets
│        │  ├──constants                      // 公共常量定义
│        │  ├──model                          // 公共model定义
│        │  ├──utils                          // 工具类
│        │  └──view                           // feature公共业务组件
│        └──resources                         // 公共资源
├──features                                   
│  ├──commonui                                // product公共业务组件模块
│  │  └──src/main
│  │     ├──ets
│  │     │  └──view                           // product公共业务组件
│  │     └──resources                         // 静态路由表资源
│  ├──message                                 // 消息模块
│  │  └──src/main
│  │     ├──ets
│  │     │  ├──model                          // 消息模块数据模型
│  │     │  ├──view                           // 消息模块组件
│  │     │  └──viewmodel                      // 消息模块视图模型
│  │     └──resources                         // 消息模块资源
│  ├──social                                  // 社交模块
│  │  └──src/main
│  │     ├──ets
│  │     │  ├──model                          // 社交模块数据模型
│  │     │  ├──view                           // 社交模块组件
│  │     │  └──viewmodel                      // 社交模块视图模型
│  │     └──resources                         // 社交模块资源
│  └──user                                    // 个人主页模块
│     └──src/main
│        ├──ets
│        │  ├──model                          // 个人主页模块数据模型
│        │  ├──view                           // 个人主页模块组件
│        │  └──viewmodel                      // 个人主页模块视图模型
│        └──resources                         // 个人主页模块资源
├──products                                  
│  ├──default                                 // 手机/平板设备
│  │  └──src/main
│  │     ├──ets
│  │     │  ├──entryability                   // 入口类
│  │     │  ├──entrybackupability             // 应用数据备份恢复自定义拓展类
│  │     │  └──pages                          // 入口页面
│  │     └──resources                         // 资源文件
│  └──pc                                      // PC设备
│     └──src/main
│        ├──ets
│        │  ├──pages                          // 入口页面
│        │  ├──pcability                      // 入口类
│        │  └──pcbackupability                // 应用数据备份恢复自定义拓展类
│        └──resources                         // 资源文件
└──oh-package.json5                           // 工程依赖声明

```

## 具体实现

1. 页面结构

|6.0.2(22)| 6.1.0(23)                                        |
|-|--------------------------------------------------|
|根容器Navigation嵌套Tabs，1个NavPathStack管理整套页面路由| 根容器HdsNavigation嵌套HdsTabs，1个NavPathStack管理整套页面路由 |

2. 通过@Env(SystemProperties.BREAK\_POINT)监听系统断点变化，动态适配UI、动态改变Navigation单栏/分栏的效果。
3. 采用安全区域拓展方式expandSageArea适配沉浸式。

## 相关权限

不涉及

## 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：直板机、双折叠（Mate X系列）、阔折叠、三折叠、平板、PC/2in1。
2. HarmonyOS系统：HarmonyOS 6.0.2 Release及以上。
3. DevEco Studio版本：DevEco Studio 6.1.0 Release及以上。
4. HarmonyOS SDK版本：HarmonyOS 6.1.0 Release SDK及以上。

