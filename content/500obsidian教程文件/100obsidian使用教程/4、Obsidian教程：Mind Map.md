---
title: 4、Obsidian教程：Mind Map
source:
author: WangLI
created: 2026-04-25-星期六
description: mind-map是一个 Obsidian 第三方插件，将 Markdown 笔记实时渲染为交互式思维导图。
tags:
  - obsidian教程
aliases:
  - 4、Obsidian教程：Mind Map
draft: false
---

## 🎯 核心功能

### 1. 实时预览转换
- 将当前打开的 Markdown 笔记自动转换为思维导图视图
- 支持标准 Markdown 语法（标题层级、列表、链接等）
- 思维导图结构与文档大纲完全对应

### 2. 智能跟随模式
- 类似 Obsidian 自带的「本地图谱」「大纲」「反向链接」面板
- 当你切换编辑窗口时，思维导图预览会自动更新显示当前笔记
- 无需手动刷新，实现真正的双栏联动

### 3. 视图固定功能（Pin）
- 点击「更多选项」菜单中的 **Pin** 可将思维导图锁定在当前笔记
- 固定后，即使切换其他笔记，思维导图仍保持显示原内容
- 再次点击图钉图标可取消固定

### 4. 截图导出
- **Copy screenshot** 功能可将思维导图复制为 SVG 格式到剪贴板
- 可直接粘贴到 Obsidian 笔记中，或导入到 Photoshop、Figma 等图像编辑器

---

## 🖼️ 界面特征

从截图可见，思维导图具有以下视觉特点：

| 元素 | 说明 |
|------|------|
| **放射状布局** | 中心节点向外辐射，一级标题呈不同颜色分支 |
| **彩色连线** | 橙色、绿色、紫色、红色等区分不同分支 |
| **节点圆点** | 每个标题前带有可点击的圆形节点 |
| **超链接支持** | 内部链接（如 `[[Credits]]`）显示为蓝色可点击文本 |
| **深色主题适配** | 完美匹配 Obsidian 的深色模式 |

---

## ⚙️ 技术实现

- **底层引擎**：使用 [Markmap](https://markmap.js.org/) 开源库
- **渲染格式**：SVG 矢量图形，无限缩放不失真
- **兼容性**：要求 Obsidian **v0.9.7+**，当前 API 目标版本 **v0.9.20**

---

## 📥 安装方式

### 方式一：社区插件市场（推荐）
1. 打开 Obsidian 设置 → 第三方插件
2. 关闭「安全模式」
3. 浏览社区插件列表，搜索「Mind Map」
4. 点击安装并启用

### 方式二：手动安装
1. 从 [Releases](https://github.com/lynchjames/obsidian-mind-map.git) 下载最新版
2. 解压到库文件夹：`<你的库>/.obsidian/plugins/obsidian-mind-map/`
3. 重载 Obsidian 并启用插件

> **注意**：`.obsidian` 文件夹默认隐藏，`macOS `可按 `Cmd+Shift+.` 显示

---

## 🎮 使用方式

1. **打开命令面板**（默认 `Cmd/Ctrl+P`）
2. 输入 **"Mind Map"**
3. 选择 **"Mind Map: Preview the current note as a Mind Map"**
4. 思维导图面板将出现在右侧或底部

---

## 🔗 相关资源

- **VS Code 版本**：同一作者开发了 VS Code 的 Markmap 插件，可在代码编辑器中使用相同功能
- **开发贡献**：接受 Pull Request，需遵循 `CONTRIBUTING.md` 规范

---

## ⚠️ 注意事项

1. **维护状态**：该仓库最后更新于较早版本（v0.9.20 时代），可能不兼容最新版 Obsidian
2. **替代方案**：如需更现代的思维导图插件，可考虑社区中的 **Markmind** 或 **Enhancing Mindmap**
3. **功能限制**：仅支持单向预览（Markdown → 思维导图），不支持直接在思维导图中编辑反向同步到 Markdown

---

## 注意！💡 注意！💡 注意！💡 

-  **Mind-Map插件不支持markdown代码框，如果存在建议改为无序标题。**
