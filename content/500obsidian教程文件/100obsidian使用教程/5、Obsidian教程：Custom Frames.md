---
title: 5、Obsidian教程：Custom Frames
source: https://github.com/Ellpeck/ObsidianCustomFrames
author: WangLI
created: 2026-04-25-星期六
description: 核心功能是将任意网页应用通过 iframe 嵌入到 Obsidian 中，作为可自定义样式的独立面板（Pane）使用
tags:
  - obsidian教程
aliases:
  - 5、Obsidian教程：Custom Frames
draft:
  - "false"
---
 我来详细分析这个 Obsidian 插件。让我先获取仓库的完整信息。
根据 GitHub 仓库信息，我为你详细分析这个 Obsidian 插件：

---

## 📋 插件概述

**Obsidian Custom Frames** 是由开发者 **Ellpeck**（Ellpeck Games）创建的一款 Obsidian 第三方插件。它的核心功能是将**任意网页应用**通过 iframe 嵌入到 Obsidian 中，作为可自定义样式的独立面板（Pane）使用。

---

## 🎯 核心功能详解

### 1. 双模式嵌入系统

该插件提供两种使用模式，适应不同场景：

| 模式 | 说明 | 适用场景 |
|------|------|----------|
| **🪟 Pane Mode（面板模式）** | 将网页作为独立标签页/侧边栏打开 | 常驻工具（日历、待办、笔记） |
| **🗒️ Markdown Mode（文档模式）** | 通过代码块在笔记中嵌入网页 | 上下文相关的网页引用 |

### 2. 深度自定义样式

每个 iframe 都支持精细的 CSS 控制：

- **Additional CSS（附加 CSS）**：直接注入自定义样式覆盖原网页
- **URL Suffix（URL 后缀）**：动态修改加载的页面路径
- **Minimum Width（最小宽度）**：自动调整面板尺寸
- **Style 属性**：在 Markdown 模式中可设置高度等样式

### 3. 内置预设（Presets）

插件开箱即带多个优化预设，省去手动配置：

| 预设名称 | 优化内容 |
|---------|---------|
| **Google Keep** | 移除菜单栏和 Logo，适配窄边栏 |
| **Google Calendar** | 移除部分按钮，左侧边栏可折叠 |
| **Todoist** | 精简边距和按钮，适配半高侧边栏 |
| **Notion** | 建议使用时关闭 Notion 侧边栏 |
| **Twitter** | 标准嵌入 |
| **Readwise Daily Review** | 阅读摘要每日回顾 |
| **Obsidian Forum** | 官方论坛 |

---

## 🛠️ 配置界面详解

从截图可见的设置面板包含以下字段：

```
┌─────────────────────────────────────┐
│  Display Name（显示名称）            │
│  → 面板上显示的标签名，如"Google Keep" │
├─────────────────────────────────────┤
│  URL（网址）                         │
│  → 嵌入的完整网址，如 https://keep.google.com │
├─────────────────────────────────────┤
│  Minimum Width（最小宽度）           │
│  → 370（像素），设为 0 则禁用自动调整 │
├─────────────────────────────────────┤
│  Additional CSS（附加 CSS）          │
│  → 自定义样式代码片段，如：           │
│    /* 隐藏菜单栏和 Keep 标志 */      │
│    .PvRhyb-qAWA2, .gb_2d.gb_Zc {    │
│        display: none !important;    │
│    }                                │
├─────────────────────────────────────┤
│  [Remove Frame]（删除框架）          │
│  [Custom ▼] [Add Frame]（添加框架）  │
└─────────────────────────────────────┘
```

---

## 📝 Markdown 模式语法

在笔记中通过特殊代码块嵌入网页：

**基础语法：**
````markdown
```custom-frames
frame: Google Keep
```
````

**高级用法（带参数）：**
````markdown
```custom-frames
frame: Google Keep
style: height: 1000px;
urlSuffix: #reminders
```
````

| 参数 | 作用 |
|------|------|
| `frame` | 指定预设或自定义框架的名称（**必需**） |
| `style` | 内联 CSS 样式，如调整高度 |
| `urlSuffix` | 追加到 URL 的片段，如直接打开特定标签页 |

---

## 🖼️ 界面展示分析

从截图可见三种典型布局：

### 布局 1：侧边栏窄面板（Google Keep）
- 位于右侧边栏，宽度约 370px
- 显示多个 Keep 笔记卡片
- 顶部有「Take a note...」输入框
- 底部显示「Close」按钮

### 布局 2：中央全屏面板（Google Calendar）
- 占据主编辑区
- 完整显示日历界面
- 左侧文件列表显示「Open Google Calendar」快捷方式
- 右侧迷你日历（德语界面：Apr. 2022）

### 布局 3：设置配置界面
- 深色主题适配
- 表单式配置界面
- 实时预览 CSS 效果

---

## ⚠️ 平台限制与注意事项

### 桌面端 vs 移动端

| 特性 | 桌面端 | 移动端 |
|------|--------|--------|
| **支持状态** | ✅ 完全支持 | ⚠️ 有限支持 |
| **技术原因** | 基于 Electron，iframe 限制少 | 非 Electron 环境，CORS/ Cookie 限制严格 |
| **登录功能** | 正常 | 多数网站无法登录 |
| **解决方案** | — | 启用「Disable on Mobile」隐藏桌面专用框架 |

### 已知问题（Known Issues）

1. **弹窗跳转问题**
   - 默认情况下，弹窗和新标签页会在系统浏览器打开
   - 影响：使用外部登录（OAuth）的网站可能无法正常登录
   - **解决**：启用 Obsidian 自带的 **Web Viewer 核心插件**，共享会话信息

2. **链接打开问题**
   - 某些链接无法从 iframe 内部打开（Obsidian 1.3.7 之前版本更严重）

---

## 🗺️ 开发路线图（Roadmap）

已完成功能 ~~删除线~~，计划中功能：

- ~~自定义图标~~
- ~~Markdown 代码块嵌入~~
- ~~Ribbon 按钮快速打开~~
- ~~自定义 JavaScript 执行~~（已探索安全性）
- ~~弹窗在 Obsidian 内打开~~（通过 Web Viewer 实现）

待开发：
- 外部链接直接打开到 Custom Frame
- Markdown 模式添加前进/后退按钮
- 文本提取功能（类似 Note composer 插件）

---

## 🔧 技术实现细节

- **核心技术**：iframe 嵌入 + CSS 注入
- **框架**：Obsidian 插件 API
- **依赖**：Electron（桌面端）的 webview 能力
- **样式隔离**：通过附加 CSS 实现，不影响原网站

---

## 💡 典型使用场景

1. **GTD 工作流**：右侧固定 Google Keep/Todoist，随时记录灵感
2. **时间管理**：中央打开 Google Calendar，边写笔记边查看日程
3. **知识管理**：在笔记中嵌入特定 Notion 页面或 Readwise 回顾
4. **社交监控**：侧边栏固定 Twitter，关注行业动态
5. **学习辅助**：在笔记中嵌入在线词典或翻译工具

---

## 📥 安装方式

1. 打开 Obsidian 设置 → 社区插件
2. 关闭安全模式
3. 搜索「Custom Frames」
4. 安装并启用
5. 进入设置配置框架或使用预设

---

这款插件的核心价值在于**打破 Obsidian 与外部网页工具的边界**，让你无需离开笔记环境即可使用各类 Web 应用，实现真正的一体化工作空间。