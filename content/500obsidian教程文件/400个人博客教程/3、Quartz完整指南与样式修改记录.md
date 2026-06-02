---
title: Quartz完整指南与样式修改记录
tags:
  - Quartz
  - 博客
  - 部署
  - GitHub
  - 样式修改
source: 适用于 Windows 环境，Quartz 版本 4.5.2+
author: WangLei
created: 2026-04-25
modified: 2026-06-01
description: 📖 Quartz 4 部署完整指南，包含安装配置、项目结构说明、样式修改记录
aliases:
  - Quartz完整指南
draft: false
---

## 目录

1. [项目结构说明](400个人博客教程/3、Quartz完整指南与样式修改记录.md#一项目结构说明)
2. [环境准备与安装](400个人博客教程/3、Quartz完整指南与样式修改记录.md#二环境准备与安装)
3. [本地配置与使用](400个人博客教程/3、Quartz完整指南与样式修改记录.md#三本地配置与使用)
4. [主题自定义](400个人博客教程/3、Quartz完整指南与样式修改记录.md#四主题自定义)
5. [部署到 GitHub Pages](400个人博客教程/3、Quartz完整指南与样式修改记录.md#五章署到-github-pages)
6. [问题排查与解决](400个人博客教程/3、Quartz完整指南与样式修改记录.md#六章题排查与解决)
7. [日常维护](400个人博客教程/3、Quartz完整指南与样式修改记录.md#七日常维护)
8. [换电脑使用](400个人博客教程/3、Quartz完整指南与样式修改记录.md#八章换电脑使用)
9. [辅助工具](400个人博客教程/3、Quartz完整指南与样式修改记录.md#九章辅助工具)
10. [样式修改记录](400个人博客教程/3、Quartz完整指南与样式修改记录.md#十章样式修改记录)

---

## 一、项目结构说明

### 1.1 根目录结构

```
C:\Users\16344\Desktop\quartz\quartz\
├── .github/              # GitHub 配置目录
├── content/              # 笔记内容目录（你的 Obsidian 笔记）
├── docs/                 # Quartz 文档
├── node_modules/         # npm 依赖包（自动生成）
├── public/               # 构建输出目录（静态网站文件）
├── quartz/               # Quartz 框架核心代码
├── .gitattributes        # Git 属性配置
├── .gitignore            # Git 忽略文件配置
├── .node-version         # Node.js 版本要求
├── .npmrc                # npm 配置
├── .prettierignore       # Prettier 忽略配置
├── .prettierrc           # Prettier 代码格式化配置
├── CODE_OF_CONDUCT.md    # 行为准则
├── Dockerfile            # Docker 配置
├── globals.d.ts          # TypeScript 全局类型定义
├── index.d.ts            # TypeScript 类型定义
├── LICENSE.txt           # 许可证
├── package.json          # npm 项目配置
├── package-lock.json     # npm 依赖锁定
├── quartz.config.ts      # ⭐ Quartz 主配置文件
├── quartz.layout.ts      # ⭐ Quartz 布局配置
├── README.md             # 项目说明
└── tsconfig.json         # TypeScript 配置
```

### 1.2 根目录文件详解

| 文件 | 作用 | 是否经常修改 |
|------|------|-------------|
| `quartz.config.ts` | 主配置文件：网站标题、URL、插件、主题颜色等 | ⭐ 是 |
| `quartz.layout.ts` | 布局配置：页面组件排列、侧边栏内容 | ⭐ 是 |
| `package.json` | npm 项目配置、依赖列表、脚本命令 | 偶尔 |
| `package-lock.json` | npm 依赖版本锁定 | 否（自动生成） |
| `tsconfig.json` | TypeScript 编译配置 | 否 |
| `.gitignore` | Git 忽略文件列表 | 偶尔 |
| `.gitattributes` | Git 文件属性（如换行符处理） | 否 |
| `.node-version` | 指定 Node.js 版本 | 否 |
| `.npmrc` | npm 配置（如镜像源） | 否 |
| `.prettierrc` | Prettier 代码格式化规则 | 否 |
| `.prettierignore` | Prettier 忽略文件 | 否 |
| `Dockerfile` | Docker 容器构建配置 | 否 |
| `globals.d.ts` | TypeScript 全局类型声明 | 否 |
| `index.d.ts` | TypeScript 模块类型声明 | 否 |
| `LICENSE.txt` | 开源许可证 | 否 |
| `CODE_OF_CONDUCT.md` | 社区行为准则 | 否 |
| `README.md` | 项目说明文档 | 否 |

---

### 1.3 .github 目录详解

**路径**：`.github/`

```
.github/
├── ISSUE_TEMPLATE/           # GitHub Issue 模板
├── workflows/                # ⭐ GitHub Actions 工作流
│   └── deploy.yml           # 部署工作流配置
├── dependabot.yml            # Dependabot 自动更新配置
├── FUNDING.yml               # 赞助信息
└── pull_request_template.md  # PR 模板
```

| 文件/目录 | 作用 |
|----------|------|
| `workflows/deploy.yml` | ⭐ GitHub Actions 自动部署配置，推送代码后自动构建和部署 |
| `ISSUE_TEMPLATE/` | GitHub Issue 模板，规范问题报告格式 |
| `dependabot.yml` | 自动检测依赖更新 |
| `FUNDING.yml` | 显示赞助按钮 |
| `pull_request_template.md` | Pull Request 模板 |

---

### 1.4 quartz 核心目录详解

**路径**：`quartz/`

```
quartz/
├── .quartz-cache/        # 构建缓存（可删除）
├── cli/                  # 命令行工具
├── components/           # ⭐ UI 组件（可自定义）
├── i18n/                 # 国际化语言包
├── plugins/              # ⭐ 插件系统
├── processors/           # 内容处理器
├── static/               # 静态资源
├── styles/               # ⭐ 全局样式（可自定义）
├── util/                 # 工具函数
├── bootstrap-cli.mjs     # CLI 启动脚本
├── bootstrap-worker.mjs  # Worker 启动脚本
├── build.ts              # 构建主脚本
├── cfg.ts                # 配置类型定义
└── worker.ts             # Worker 脚本
```

| 文件/目录 | 作用 | 是否需要修改 |
|----------|------|-------------|
| `components/` | UI 组件目录，包含所有页面元素的实现 | ⭐ 是（样式修改） |
| `plugins/` | 插件系统，处理内容转换和输出 | 偶尔（配置插件） |
| `styles/` | 全局样式文件 | ⭐ 是（自定义样式） |
| `i18n/` | 国际化翻译文件 | 否 |
| `static/` | 静态资源（图标、OG 图片等） | 偶尔 |
| `util/` | 工具函数库 | 否 |
| `processors/` | 内容处理管道 | 否 |
| `cli/` | 命令行工具实现 | 否 |
| `build.ts` | 构建流程主文件 | 否 |
| `cfg.ts` | 配置类型定义 | 否 |
| `.quartz-cache/` | 构建缓存目录 | 可删除 |

---

### 1.5 components 组件目录详解

**路径**：`quartz/components/`

```
components/
├── pages/               # 页面组件
├── scripts/             # 组件交互脚本
├── styles/              # ⭐ 组件样式文件（SCSS）
│
│   ===== 以下为组件文件 =====
│
├── ArticleTitle.tsx     # 文章标题组件
├── Backlinks.tsx        # 反向链接组件
├── Body.tsx             # 页面主体组件
├── Breadcrumbs.tsx      # 面包屑导航组件
├── Comments.tsx         # 评论组件
├── ConditionalRender.tsx # 条件渲染组件
├── ContentMeta.tsx      # 内容元数据组件
├── Darkmode.tsx         # 深色模式切换组件
├── Date.tsx             # 日期显示组件
├── DesktopOnly.tsx      # 仅桌面显示组件
├── Explorer.tsx         # ⭐ 左侧文件浏览器组件
├── Flex.tsx             # 弹性布局组件
├── Footer.tsx           # 页脚组件
├── Graph.tsx            # 关系图谱组件
├── Head.tsx             # HTML Head 组件
├── Header.tsx           # 页头组件
├── MobileOnly.tsx       # 仅移动端显示组件
├── OverflowList.tsx     # 溢出列表组件
├── PageList.tsx         # 页面列表组件
├── PageTitle.tsx        # 页面标题组件
├── ReaderMode.tsx       # 阅读模式组件
├── RecentNotes.tsx      # 最近笔记组件
├── renderPage.tsx       # 页面渲染主组件
├── Search.tsx           # 搜索组件
├── Spacer.tsx           # 间隔组件
├── TableOfContents.tsx  # ⭐ 目录组件
├── TagList.tsx          # 标签列表组件
├── index.ts             # 组件导出索引
└── types.ts             # 组件类型定义
```

#### 组件文件详解

| 文件 | 作用 | 修改频率 |
|------|------|---------|
| `Explorer.tsx` | 左侧文件浏览器，显示文件夹和文件树 | ⭐ 修改过样式 |
| `TableOfContents.tsx` | 右侧目录，显示当前页面的标题列表 | ⭐ 修改过样式 |
| `Backlinks.tsx` | 右侧反向链接，显示链接到当前页的其他页面 | ⭐ 修改过样式 |
| `Search.tsx` | 全局搜索功能 | 否 |
| `Darkmode.tsx` | 明暗模式切换按钮 | 否 |
| `Graph.tsx` | 关系图谱可视化 | 否 |
| `Breadcrumbs.tsx` | 面包屑导航，显示当前页面路径 | 否 |
| `Comments.tsx` | 评论系统（如 giscus） | 偶尔 |
| `ArticleTitle.tsx` | 文章标题显示 | 否 |
| `ContentMeta.tsx` | 显示日期、阅读时间等元信息 | 否 |
| `TagList.tsx` | 显示页面标签 | 否 |
| `Footer.tsx` | 页面底部，包含链接等 | 偶尔 |
| `PageTitle.tsx` | 网站标题 | 否 |
| `RecentNotes.tsx` | 最近修改的笔记列表 | 否 |
| `ReaderMode.tsx` | 阅读模式切换 | 否 |
| `Head.tsx` | HTML head 元素（meta、link 等） | 否 |
| `Header.tsx` | 页面头部容器 | 否 |
| `Body.tsx` | 页面主体容器 | 否 |
| `Flex.tsx` | 弹性布局容器 | 否 |
| `Spacer.tsx` | 占位间隔 | 否 |
| `DesktopOnly.tsx` | 包裹仅在桌面显示的内容 | 否 |
| `MobileOnly.tsx` | 包裹仅在移动端显示的内容 | 否 |
| `ConditionalRender.tsx` | 条件渲染包装器 | 否 |
| `OverflowList.tsx` | 处理溢出的列表 | 否 |
| `PageList.tsx` | 页面列表渲染 | 否 |
| `Date.tsx` | 日期格式化显示 | 否 |
| `renderPage.tsx` | 页面渲染主逻辑 | 否 |
| `index.ts` | 组件导出索引 | 否 |
| `types.ts` | TypeScript 类型定义 | 否 |

---

### 1.6 components/styles 样式文件详解

**路径**：`quartz/components/styles/`

```
styles/
├── backlinks.scss        # ⭐ 反向链接样式
├── breadcrumbs.scss      # 面包屑导航样式
├── clipboard.scss        # 剪贴板按钮样式
├── contentMeta.scss      # 内容元数据样式
├── darkmode.scss         # 深色模式切换按钮样式
├── explorer.scss         # ⭐ 左侧文件浏览器样式
├── footer.scss           # 页脚样式
├── graph.scss            # 关系图谱样式
├── legacyToc.scss        # 旧版目录样式
├── listPage.scss         # 列表页样式
├── mermaid.inline.scss   # Mermaid 图表样式
├── popover.scss          # 悬停卡片样式
├── readermode.scss       # 阅读模式样式
├── recentNotes.scss      # 最近笔记样式
├── search.scss           # 搜索框样式
└── toc.scss              # ⭐ 目录样式
```

#### 样式文件详解

| 文件 | 作用 | 我是否修改 |
|------|------|-----------|
| `explorer.scss` | 左侧文件浏览器：文件夹树、文件列表样式 | ⭐ **是** |
| `toc.scss` | 右侧目录：标题层级、当前项高亮样式 | ⭐ **是** |
| `backlinks.scss` | 右侧反向链接：链接列表样式 | ⭐ **是** |
| `search.scss` | 搜索框、搜索结果样式 | 否 |
| `darkmode.scss` | 明暗模式切换按钮样式 | 否 |
| `graph.scss` | 关系图谱节点、连线样式 | 否 |
| `breadcrumbs.scss` | 面包屑导航、分隔符样式 | 否 |
| `popover.scss` | 悬停预览卡片样式 | 否 |
| `footer.scss` | 页脚链接、版权信息样式 | 否 |
| `listPage.scss` | 文件夹/标签列表页样式 | 否 |
| `readermode.scss` | 阅读模式按钮样式 | 否 |
| `recentNotes.scss` | 最近笔记列表样式 | 否 |
| `clipboard.scss` | 代码复制按钮样式 | 否 |
| `contentMeta.scss` | 日期、阅读时间等元信息样式 | 否 |
| `legacyToc.scss` | 旧版目录组件样式 | 否 |
| `mermaid.inline.scss` | Mermaid 流程图、时序图等样式 | 否 |

---

### 1.7 components/scripts 脚本文件详解

**路径**：`quartz/components/scripts/`

```
scripts/
├── callout.inline.ts     # Callout 折叠交互
├── checkbox.inline.ts    # 复选框交互
├── clipboard.inline.ts   # 剪贴板复制功能
├── comments.inline.ts    # 评论系统初始化
├── darkmode.inline.ts    # 深色模式切换逻辑
├── explorer.inline.ts    # 文件浏览器展开/折叠逻辑
├── graph.inline.ts       # 关系图谱交互逻辑
├── mermaid.inline.ts     # Mermaid 图表渲染
├── popover.inline.ts     # 悬停卡片显示逻辑
├── readermode.inline.ts  # 阅读模式切换逻辑
├── search.inline.ts      # 全文搜索逻辑
├── search.test.ts        # 搜索功能测试
├── spa.inline.ts         # SPA 路由逻辑
├── toc.inline.ts         # 目录滚动高亮逻辑
└── util.ts               # 工具函数
```

#### 脚本文件详解

| 文件 | 作用 |
|------|------|
| `explorer.inline.ts` | 左侧文件浏览器的展开/折叠、文件夹点击交互 |
| `search.inline.ts` | 全文搜索实现，索引构建、搜索匹配 |
| `graph.inline.ts` | 关系图谱的节点拖拽、缩放、力导向布局 |
| `toc.inline.ts` | 目录滚动时自动高亮当前章节 |
| `darkmode.inline.ts` | 明暗模式切换、主题持久化 |
| `popover.inline.ts` | 悬停预览卡片的显示/隐藏 |
| `spa.inline.ts` | SPA 模式下的页面切换动画 |
| `clipboard.inline.ts` | 代码块一键复制功能 |
| `mermaid.inline.ts` | Mermaid 图表渲染初始化 |
| `comments.inline.ts` | giscus 等评论系统初始化 |
| `callout.inline.ts` | Callout 折叠/展开交互 |
| `checkbox.inline.ts` | 任务列表复选框交互 |
| `readermode.inline.ts` | 阅读模式切换 |
| `util.ts` | 共享工具函数 |

---

### 1.8 plugins 插件目录详解

**路径**：`quartz/plugins/`

```
plugins/
├── transformers/         # 内容转换器
├── filters/              # 内容过滤器
├── emitters/             # 输出器
├── index.ts              # 插件导出索引
├── types.ts              # 插件类型定义
└── vfile.ts              # 虚拟文件处理
```

#### transformers 转换器详解

**路径**：`quartz/plugins/transformers/`

| 文件 | 作用 | 配置示例 |
|------|------|---------|
| `frontmatter.ts` | 解析 YAML front matter | `Plugin.FrontMatter()` |
| `lastmod.ts` | 读取文件创建/修改日期 | `Plugin.CreatedModifiedDate({})` |
| `syntax.ts` | 代码语法高亮 | `Plugin.SyntaxHighlighting({})` |
| `ofm.ts` | Obsidian 风格 Markdown（内部链接、嵌入等） | `Plugin.ObsidianFlavoredMarkdown()` |
| `gfm.ts` | GitHub 风格 Markdown（表格、删除线等） | `Plugin.GitHubFlavoredMarkdown()` |
| `toc.ts` | 生成目录 | `Plugin.TableOfContents()` |
| `links.ts` | 处理链接和 CrawlLinks | `Plugin.CrawlLinks({})` |
| `description.ts` | 生成页面描述 | `Plugin.Description()` |
| `latex.ts` | LaTeX 公式渲染 | `Plugin.Latex({ renderEngine: "mathjax" })` |
| `citations.ts` | 学术引用处理 | `Plugin.Citations()` |
| `roam.ts` | Roam Research 风格导入 | `Plugin.RoamFlavoredMarkdown()` |
| `oxhugofm.ts` | OxHugo 风格导入 | `Plugin.OxHugoFlavoredMarkdown()` |
| `linebreaks.ts` | 换行符处理 | `Plugin.HardLineBreaks()` |

#### filters 过滤器详解

**路径**：`quartz/plugins/filters/`

| 文件 | 作用 | 配置示例 |
|------|------|---------|
| `draft.ts` | 过滤草稿（`draft: true` 的页面） | `Plugin.RemoveDrafts()` |
| `explicit.ts` | 仅发布显式标记的页面 | `Plugin.ExplicitPublish()` |

#### emitters 输出器详解

**路径**：`quartz/plugins/emitters/`

| 文件 | 作用 | 配置示例 |
|------|------|---------|
| `contentPage.tsx` | 生成内容页面 HTML | `Plugin.ContentPage()` |
| `folderPage.tsx` | 生成文件夹列表页 | `Plugin.FolderPage()` |
| `tagPage.tsx` | 生成标签列表页 | `Plugin.TagPage()` |
| `contentIndex.tsx` | 生成内容索引（用于搜索） | `Plugin.ContentIndex({})` |
| `aliases.ts` | 处理别名重定向 | `Plugin.AliasRedirects()` |
| `assets.ts` | 复制静态资源 | `Plugin.Assets()` |
| `static.ts` | 复制 static 目录 | `Plugin.Static()` |
| `favicon.ts` | 生成 favicon | `Plugin.Favicon()` |
| `404.tsx` | 生成 404 页面 | `Plugin.NotFoundPage()` |
| `componentResources.ts` | 注入组件资源 | `Plugin.ComponentResources()` |
| `ogImage.tsx` | 生成 Open Graph 图片 | `Plugin.CustomOgImages()` |
| `cname.ts` | 生成 CNAME 文件 | `Plugin.CNAME()` |
| `helpers.ts` | 输出器辅助函数 | 内部使用 |

---

### 1.9 styles 全局样式目录详解

**路径**：`quartz/styles/`

```
styles/
├── base.scss             # 基础样式（排版、链接、代码块等）
├── custom.scss           # ⭐ 自定义样式（推荐在此添加）
├── variables.scss        # SCSS 变量（断点、权重等）
├── syntax.scss           # 代码语法高亮样式
├── callouts.scss         # Callout/admonition 样式
└── themes/               # 预设主题目录
    └── underwater.scss   # 示例主题
```

| 文件 | 作用 | 是否修改 |
|------|------|---------|
| `base.scss` | 全局基础样式：字体、链接、表格、代码块、图片等 | ⭐ **是** |
| `custom.scss` | 用户自定义样式，会在 base.scss 后加载 | ⭐ **是** |
| `variables.scss` | SCSS 变量：响应式断点、字重、侧边栏宽度等 | 否 |
| `syntax.scss` | 代码高亮配色（Chroma/Shiki 主题） | 否 |
| `callouts.scss` | Callout 提示框样式 | 否 |

---

### 1.10 util 工具目录详解

**路径**：`quartz/util/`

```
util/
├── clone.ts              # 对象克隆
├── ctx.ts                # 构建上下文
├── emoji.ts              # Emoji 处理
├── emojimap.json         # Emoji 映射表
├── escape.ts             # HTML 转义
├── fileTrie.ts           # 文件树数据结构
├── fileTrie.test.ts      # 文件树测试
├── glob.ts               # 文件匹配
├── jsx.tsx               # JSX 辅助
├── lang.ts               # 语言处理
├── log.ts                # 日志工具
├── og.tsx                # Open Graph 图片生成
├── path.ts               # 路径处理
├── path.test.ts          # 路径测试
├── perf.ts               # 性能测量
├── random.ts             # 随机数生成
├── resources.tsx         # 资源处理
├── sourcemap.ts          # Source Map 处理
├── theme.ts              # 主题处理
└── trace.ts              # 调试追踪
```

---

### 1.11 i18n 国际化目录详解

**路径**：`quartz/i18n/`

```
i18n/
├── locales/              # 语言包目录
│   ├── en-US.ts         # 英语
│   ├── zh-CN.ts         # 简体中文
│   ├── zh-TW.ts         # 繁体中文
│   └── ...              # 其他语言
└── index.ts              # 国际化配置
```

---

### 1.12 static 静态资源目录详解

**路径**：`quartz/static/`

```
static/
├── giscus/               # Giscus 评论主题
│   ├── light.css        # 亮色主题
│   └── dark.css         # 暗色主题
├── icon.png              # 网站图标
└── og-image.png          # 默认 Open Graph 图片
```

---

### 1.13 processors 处理器目录详解

**路径**：`quartz/processors/`

```
processors/
├── parse.ts              # 解析 Markdown
├── filter.ts             # 过滤内容
└── emit.ts               # 输出处理
```

---

### 1.14 content 内容目录

**路径**：`content/`

```
content/
├── index.md              # 网站首页
├── 000learning/          # 学习笔记目录
├── 200HARDWARE/          # 硬件笔记目录
├── 0000assets/           # 图片等附件目录
└── cleanup-git.ps1       # 清理脚本
```

这是你存放 Obsidian 笔记的地方，Quartz 会读取此目录下的所有 `.md` 文件。

---

## 二、环境准备与安装

### 2.1 环境要求

| 要求 | 版本 |
|------|------|
| Node.js | 18.x 或更高 |
| Git | 任意版本 |
| npm | 随 Node.js 一起安装 |

检查安装：
```powershell
node --version   # 应该是 18.x.x 或更高
npm --version
git --version
```

### 2.2 安装步骤

```bash
# 克隆项目
git clone https://github.com/jackyzha0/quartz.git
cd quartz

# 安装依赖
npm install

# 测试运行
npx quartz build --serve
```

访问 http://localhost:8080

---

## 三、本地配置与使用

### 3.1 主配置文件 quartz.config.ts

```typescript
import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

const config: QuartzConfig = {
  configuration: {
    pageTitle: "我的数字花园",
    enableSPA: false,
    enablePopovers: true,
    locale: "zh-CN",
    baseUrl: "yourname.github.io/repo/",
    ignorePatterns: [".obsidian", ".git", "private"],
    defaultDateType: "modified",
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({}),
      Plugin.SyntaxHighlighting({}),
      Plugin.ObsidianFlavoredMarkdown(),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({}),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "mathjax" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({}),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
    ],
  },
}

export default config
```

### 3.2 布局配置 quartz.layout.ts

```typescript
import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [],
  afterBody: [],
  footer: Component.Footer({
    links: {
      GitHub: "https://github.com/yourname/repo",
    },
  }),
}

export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs(),
    Component.ArticleTitle(),
    Component.ContentMeta(),
    Component.TagList(),
  ],
  left: [
    Component.PageTitle(),
    Component.Flex({
      components: [
        { Component: Component.Search(), grow: true },
        { Component: Component.Darkmode() },
        { Component: Component.ReaderMode() },
      ],
    }),
    Component.Explorer(),
  ],
  right: [
    Component.Graph(),
    Component.TableOfContents(),
    Component.Backlinks(),
  ],
}
```

### 3.3 常用命令

```bash
# 本地开发
npx quartz build --serve

# 构建
npx quartz build

# 清理缓存
rm -rf .quartz-cache
```

---

## 四、主题自定义

### 4.1 主题配置

在 `quartz.config.ts` 中：

```typescript
theme: {
  fontOrigin: "googleFonts",
  typography: {
    header: "Lexend",
    body: "Inter",
    code: "JetBrains Mono",
  },
  colors: {
    lightMode: {
      light: "#faf4ed",
      dark: "#26233a",
      secondary: "#d7827e",
      tertiary: "#56949f",
    },
    darkMode: {
      light: "#26233a",
      dark: "#faf4ed",
      secondary: "#ebbcba",
      tertiary: "#56949f",
    },
  },
},
```

### 4.2 自定义 CSS

在 `quartz/styles/custom.scss` 中添加：

```scss
@use "./base.scss";

// 图片居中
article img {
  display: block;
  margin: 1rem auto;
}

// 行间距
article p {
  line-height: 2.2;
}
```

---

## 五、部署到 GitHub Pages

### 5.1 初始化仓库

```bash
git init
git add -A
git commit -m "Initial commit"
git checkout -b Github-Pags
git remote add origin https://github.com/用户名/仓库名.git
git push -u origin Github-Pags
```

### 5.2 GitHub Actions 工作流

创建 `.github/workflows/deploy.yml`

### 5.3 启用 GitHub Pages

仓库 → Settings → Pages → 选择分支

---

## 六、问题排查与解决

### 6.1 网站只显示欢迎页

```bash
git rm --cached content/文件夹名
git add content/文件夹名/
git commit -m "Fix submodule"
git push
```

### 6.2 图片 404

```typescript
enableSPA: false,
```

### 6.3 公式不显示

```typescript
Plugin.Latex({ renderEngine: "mathjax" }),
```

---

## 七、日常维护

```bash
git add -A
git commit -m "Update"
git push origin Github-Pags
```

---

## 八、换电脑使用

复制：`content/`、`quartz.config.ts`、`quartz.layout.ts`、`quartz/`、`package.json`

```bash
npm install
npx quartz build --serve
```

---

## 九、辅助工具

### 9.1 清理脚本

`content/cleanup-git.ps1`

### 9.2 草稿

```yaml
---
draft: true
---
```

---

## 十、样式修改记录

> 以下记录 2026-06-01 对侧边栏样式的修改

### 10.1 修改背景

网站：https://vaguedefine.github.io/WangLei/

问题：
1. 左侧文件夹浏览器字体太紧
2. 右侧目录和反向链接字号不合适
3. 整体间距不够，阅读体验差

### 10.2 修改文件列表

| 文件 | 路径 |
|------|------|
| `explorer.scss` | `quartz/components/styles/explorer.scss` |
| `toc.scss` | `quartz/components/styles/toc.scss` |
| `backlinks.scss` | `quartz/components/styles/backlinks.scss` |

### 10.3 explorer.scss 修改

| 改进项 | 原值 | 新值 |
|--------|------|------|
| 文件夹标题字号 | 0.95rem | 1rem |
| 标题字号 | 1rem | 1.1rem |
| 行高 | 1.5 | 1.8 |
| 上边距 | 0.5rem | 0.75rem |
| 缩进 | 0.8rem | 1rem |
| 边框宽度 | 1px | 2px |

### 10.4 toc.scss 修改

| 改进项 | 原值 | 新值 |
|--------|------|------|
| 标题字号 | 1rem | 1.1rem |
| 链接透明度 | 0.35 | 0.5 |
| 当前列透明度 | 0.75 | 0.85 |
| 行高 | 无 | 1.7 |

### 10.5 backlinks.scss 修改

| 改进项 | 原值 | 新值 |
|--------|------|------|
| 标题字号 | 1rem | 1.1rem |
| 行高 | 无 | 1.7 |
| 上边距 | 0.5rem | 0.75rem |

### 10.6 交互改进

- 悬停右移效果：`transform: translateX(3px)`
- 悬停背景色
- 边框悬停变色
- 过渡动画：`0.2s ease`

---

## 附录

### 附录 A：文件速查表

| 类别 | 文件 | 路径 |
|------|------|------|
| 主配置 | `quartz.config.ts` | 根目录 |
| 布局配置 | `quartz.layout.ts` | 根目录 |
| 自定义样式 | `custom.scss` | `quartz/styles/` |
| 文件浏览器样式 | `explorer.scss` | `quartz/components/styles/` |
| 目录样式 | `toc.scss` | `quartz/components/styles/` |
| 部署工作流 | `deploy.yml` | `.github/workflows/` |

### 附录 B：参考链接

- [Quartz 官方文档](https://quartz.jzhao.xyz/)
- [Quartz GitHub](https://github.com/jackyzha0/quartz)
- [Google Fonts](https://fonts.google.com/)

---

*文档版本：v4.0*
*创建时间：2026-04-25*
*最后修改：2026-06-01*
