---
title: 1、Quartz-Static-GitHub
tags:
  - Quartz
  - 博客
  - 部署
  - GitHub
source: 适用于 Windows 环境，Quartz 版本 4.5.2+
author: WangLI
created: 2026-04-25-星期六
description: 📖 本文档是 Quartz 4 部署的完整指南，包含安装、配置、主题切换、部署流程以及常见问题的解决方案。
aliases:
  - 1、Quartz-Static-GitHub
draft: false
---

## 目录

1. [环境准备与安装](400个人博客教程/1、Quartz-Static-GitHub.md#第一章环境准备与安装)
2. [本地配置与使用](400个人博客教程/1、Quartz-Static-GitHub.md#第二章本地配置与使用)
3. [主题自定义](400个人博客教程/1、Quartz-Static-GitHub.md#第三章主题自定义)
4. [部署到 GitHub Pages](400个人博客教程/1、Quartz-Static-GitHub.md#第四章部署到-github-pages)
5. [问题排查与解决](400个人博客教程/1、Quartz-Static-GitHub.md#第五章问题排查与解决)
6. [日常维护](400个人博客教程/1、Quartz-Static-GitHub.md#第六章日常维护)
7. [换电脑使用](#第七章换电脑使用)
8. [辅助工具](400个人博客教程/1、Quartz-Static-GitHub.md#第六章辅助工具)
9. [附录](400个人博客教程/1、Quartz-Static-GitHub.md#附录)

---

## 第一章：环境准备与安装

### 1.1 环境要求

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

### 1.2 安装步骤

#### 步骤 1：创建项目目录

```powershell
# 在你喜欢的位置创建目录
mkdir quartz
cd quartz
```

#### 步骤 2：克隆 Quartz 模板

```bash
# 克隆官方模板（推荐）
git clone https://github.com/jackyzha0/quartz.git

# 如果你想用特定版本
git clone https://github.com/jackyzha0/quartz.git --branch v4.5.2
```

#### 步骤 3：进入目录

```bash
cd quartz
```

#### 步骤 4：重命名配置文件

```bash
# Quartz 4 的配置文件名可能需要调整
# 如果有 cp quartz.config.ts.example quartz.config.ts 则执行
```

#### 步骤 5：安装依赖

```bash
npm install
```

#### 步骤 6：测试运行

```bash
npx quartz build --serve
```

访问 http://localhost:8080 应该能看到默认页面。

### 1.3 导入你的 Obsidian 笔记

1. 打开你的 Obsidian 仓库目录
2. 复制整个内容到 `quartz/content` 目录

```
quartz/
├── content/          # 你的笔记目录
│   ├── index.md     # 网站首页（确保有这个文件）
│   ├── 000learning/ # 学习笔记
│   └── 200HARDWARE/ # 硬件笔记
└── ...
```

---

## 第二章：本地配置与使用

### 2.1 配置文件说明

Quartz 的主配置文件是 `quartz.config.ts`，核心配置项：

```typescript
import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

const config: QuartzConfig = {
  configuration: {
    pageTitle: "我的数字花园",     // 网站标题
    pageTitleSuffix: "",          // 标题后缀
    enableSPA: false,             // 是否启用 SPA（单页应用）
    enablePopovers: true,          // 是否启用悬停卡片
    locale: "zh-CN",              // 语言
    baseUrl: "yourname.github.io/repo/",  // 网站基础 URL（部署时必须填写）
    ignorePatterns: [             // 忽略的文件/目录
      "private",
      "**/000templates",
      "**/000Excaildraw",
      ".obsidian",
      ".git",
      ".gitignore",
    ],
    defaultDateType: "modified",  // 默认日期类型
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
      Plugin.Latex({}),
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

### 2.2 常用命令

```bash
# 本地开发（带热重载）
npx quartz build --serve

# 构建静态文件
npx quartz build

# 构建并指定输出目录
npx quartz build --output public

# 清理缓存
rm -rf .quartz-cache
```

### 2.3 访问本地网站

运行 `npx quartz build --serve` 后，访问：

- http://localhost:8080
- http://127.0.0.1:8080

---

## 第三章：主题自定义

### 3.1 主题配置文件位置

主题配置在 `quartz.config.ts` 的 `theme` 部分：

```typescript
const config: QuartzConfig = {
  // ... 其他配置
  configuration: {
    // ... 其他配置
  },
  // 在这里添加 theme 配置
  theme: {
    fontOrigin: "googleFonts",  // 字体来源："googleFonts" 或 "local"
    cdnCaching: true,           // CDN 缓存
    typography: {
      header: "Lexend",          // 标题字体
      body: "Inter",             // 正文字体
      code: "JetBrains Mono",    // 代码字体
    },
    colors: {
      lightMode: {               // 亮色模式
        light: "#faf4ed",       # 背景色
        lightgray: "#cecacd",    # 边框/分割线
        gray: "#9893a5",         # 次要文字
        darkgray: "#575279",    # 主要文字
        dark: "#26233a",         # 标题
        secondary: "#d7827e",   # 链接/强调
        tertiary: "#56949f",     # hover 效果
        highlight: "rgba(223, 218, 217, 0.5)",
        textHighlight: "#cecacd",
      },
      darkMode: {               # 暗色模式
        light: "#26233a",
        lightgray: "#42404f",
        gray: "#6e6a86",
        darkgray: "#e0def4",
        dark: "#faf4ed",
        secondary: "#ebbcba",
        tertiary: "#56949f",
        highlight: "rgba(64, 61, 82, 0.5)",
        textHighlight: "#524f67",
      },
    },
  },
}
```

### 3.2 可用字体

Google Fonts 推荐：

| 用途 | 字体名称 |
|------|----------|
| 标题 | Lexend, Schibsted Grotesk, Poppins |
| 正文 | Inter, Source Sans Pro, Lora |
| 代码 | JetBrains Mono, Fira Code, IBM Plex Mono |

在 [Google Fonts](https://fonts.google.com/) 选择喜欢的字体，然后在 typography 中填写字体名称。

### 3.3 预设主题

Quartz 提供了几种预设配色方案，你可以直接使用或修改：

```typescript
// 亮色主题示例
lightMode: {
  light: "#faf8f8",      // 背景：米白色
  lightgray: "#e5e5e5",   // 边框
  gray: "#b8b8b8",        // 次要文字
  darkgray: "#4e4e4e",   // 主要文字
  dark: "#2b2b2b",       // 标题
  secondary: "#284b63",   // 链接
  tertiary: "#84a59d",   // hover
},

// 深色主题示例
darkMode: {
  light: "#161618",       // 背景：深色
  lightgray: "#393639",
  gray: "#646464",
  darkgray: "#d4d4d4",
  dark: "#ebebec",
  secondary: "#7b97aa",
  tertiary: "#84a59d",
},
```

### 3.4 自定义 CSS

如果需要更细致的样式调整，可以创建自定义 CSS：

1. 在 `quartz/` 目录下创建 `styles/` 目录（如果不存在）
2. 创建 `custom.css` 文件
3. 在 `quartz.layout.ts` 中引入

```typescript
// quartz.layout.ts
import { QuartzConfig } from "./quartz/cfg"
import { buildPage } from "./quartz/build"
import { defaultLayout } from "./quartz/layout"

// ... 在 defaultLayout 后添加自定义样式
export function load() {
  return {
    ...defaultLayout(),
    css: [...defaultLayout().css, "/styles/custom.css"],
  }
}
```

### 3.5 logo 和封面图

```typescript
configuration: {
  pageTitle: "我的网站",
  // 添加 emoji 作为 favicon
}
```

或者在 `quartz/plugins/emitters/Favicon.ts` 中配置自定义图标。

### 3.6 完整主题配置示例

```typescript
const config: QuartzConfig = {
  configuration: {
    pageTitle: "王雷的数字花园",
    pageTitleSuffix: "",
    enableSPA: false,
    enablePopovers: true,
    locale: "zh-CN",
    baseUrl: "vaguedefine.github.io/WangLei/",
    ignorePatterns: [
      "private",
      "**/000templates",
      "**/000Excaildraw",
      ".obsidian",
      ".git",
      ".gitignore",
    ],
    defaultDateType: "modified",
  },
  theme: {
    fontOrigin: "googleFonts",
    cdnCaching: true,
    typography: {
      header: "Lexend",
      body: "Inter",
      code: "JetBrains Mono",
    },
    colors: {
      lightMode: {
        light: "#faf4ed",
        lightgray: "#cecacd",
        gray: "#9893a5",
        darkgray: "#575279",
        dark: "#26233a",
        secondary: "#d7827e",
        tertiary: "#56949f",
        highlight: "rgba(223, 218, 217, 0.5)",
        textHighlight: "#cecacd",
      },
      darkMode: {
        light: "#26233a",
        lightgray: "#42404f",
        gray: "#6e6a86",
        darkgray: "#e0def4",
        dark: "#faf4ed",
        secondary: "#ebbcba",
        tertiary: "#56949f",
        highlight: "rgba(64, 61, 82, 0.5)",
        textHighlight: "#524f67",
      },
    },
  },
}
```

---

## 第四章：部署到 GitHub Pages

### 4.1 创建 GitHub 仓库

1. 打开 https://github.com
2. 点击右上角的 "+" → "New repository"
3. 填写仓库名（如 `WangLei`）
4. 选择 "Public"
5. 不要勾选任何初始化选项
6. 点击 "Create repository"

### 4.2 初始化本地仓库

```bash
cd C:/Users/16344/Desktop/quartz/quartz

# 初始化 git（如果还没有）
git init

# 添加所有文件
git add -A

# 首次提交
git commit -m "Initial commit"
```

### 4.3 创建部署分支

```bash
# 创建并切换到部署分支
git checkout -b Github-Pags

# 推送
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin Github-Pags
```

### 4.4 创建 GitHub Actions 工作流

创建 `.github/workflows/deploy.yml` 文件：

```yaml
name: Deploy Quartz site to GitHub Pages
   
on:
  push:
    branches:
      - main
      - master
      - Github-Pags
   workflow_dispatch:
   
permissions:
  contents: read
  pages: write
  id-token: write
   
concurrency:
  group: "pages"
  cancel-in-progress: false
   
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 22

      - name: Install Dependencies
        run: npm ci

      - name: Build Quartz
        run: npx quartz build --verbose

      - name: Setup Pages
        uses: actions/configure-pages@v4
        with:
          static_site: true

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: public

  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**注意**：确保 `.github/workflows/deploy.yml` 文件在 `Github-Pags` 分支中。

### 4.5 启用 GitHub Pages

1. 进入仓库 → Settings → Pages
2. Source 选择 "Deploy from a branch"
3. Branch 选择 `Github-Pags`，目录 `/ (root)`
4. 点击 Save

### 4.6 获取网站 URL

部署完成后，GitHub 会显示网站 URL，格式为：

```
https://你的用户名.github.io/仓库名/
```

例如：https://vaguedefine.github.io/WangLei/

### 4.7 配置 baseUrl

在 `quartz.config.ts` 中设置正确的 baseUrl：

```typescript
baseUrl: "vaguedefine.github.io/WangLei/",
```

**注意**：如果 URL 是 `https://vaguedefine.github.io/WangLei/`，则 baseUrl 应该是 `/WangLei/` 或者 `vaguedefine.github.io/WangLei/`（带或者不带斜杠都可以，Quartz 会自动处理）。

---

## 第五章：问题排查与解决

### 5.1 问题：网站只显示欢迎页，内容不显示

#### 问题描述
构建成功，但网站只显示 index.md 的内容，子文件夹（如 `000learning`、`200HARDWARE`）中的笔记不显示。

#### 排查 1：检查 GitHub API

```
https://api.github.com/repos/你的用户名/仓库名/contents/content/文件夹名
```

如果返回 `"type": "submodule"`，说明文件夹是作为 git 子模块存储的。

#### 排查 2：检查 Git 树结构

```bash
git ls-tree -r HEAD content/
```

如果看到 `160000` 模式，说明是子模块。

#### 解决方案：修复 Git Submodule 问题

```bash
cd C:/Users/16344/Desktop/quartz/quartz

# 1. 从 git 索引移除子模块
git rm --cached content/000learning
git rm --cached content/200HARDWARE

# 2. 重新添加为普通文件
git add content/000learning/ content/200HARDWARE/

# 3. 验证本地构建
npx quartz build

# 4. 提交
git add -A
git commit -m "Fix: Convert submodules to regular directories"

# 5. 推送
git push origin Github-Pags
```

---

### 5.2 问题：push 后 workflow 不自动运行

#### 原因
workflow 配置没有包含你的部署分支。

#### 解决方案

编辑 `.github/workflows/deploy.yml`：

```yaml
on:
  push:
    branches:
      - main
      - master
      - Github-Pags  # 添加你的分支
```

---

### 5.3 问题：图片显示 404

#### 问题描述
构建后图片显示不出来，请求路径是 `/0000assets/...` 返回 404，但文件已经复制到 public 目录。

#### 解决方案

**方案一（推荐）**：关闭 SPA（单页应用）

Quartz 默认启用 SPA，但在静态部署时 SPA 的路径解析可能出现问题。关闭 SPA 可以让图片使用传统的相对路径解析：

```typescript
// quartz.config.ts
enableSPA: false,
```

**方案二**：使用相对路径

在 Markdown 中使用标准的相对路径引用图片（Quartz 会自动处理路径解析）：

```markdown
![](0000assets/filename.png)
```

或者使用Obsidian附件文件夹语法：

```markdown
![](file.jpg)
```

#### 原因分析
当启用 SPA 时，Quartz 使用 JavaScript 进行客户端路由和路径计算。如果文件结构和 slug 结构不完全匹配，相对路径计算会出错，导致 404。关闭 SPA 后，图片使用传统的 HTML 相对路径解析，能够正常工作。

---

### 5.4 问题：公式不显示 / 显示为原始代码

#### 问题描述
LaTeX 公式不渲染，显示为原始代码。

#### 解决方案

**方案一（推荐）**：切换到 MathJax 渲染引擎

```typescript
// quartz.config.ts
Plugin.Latex({ renderEngine: "mathjax" }),
```

**方案二**：删除所有 `\tag{}` 命令

```latex
# 错误示例
$$F_{clock} = 1/T_{clock}\tag{1}$$

# 正确示例
$$F_{clock} = 1/T_{clock}$$
```

**方案三：**[行内和独立公式](100obsidian使用教程/6、Obsidian教程：行内和独立公式.md)

**问题原因**：
- `\tag{}` 是 LaTeX 的 AMS 数学包功能，用于给公式添加编号
- KaTeX 对 `\tag{}` 支持不完整，在行间公式中使用会报错导致整个公式渲染失败
- MathJax 对 `\tag{}` 支持更好

---

### 5.5 问题：CustomOgImages 错误

#### 问题描述
构建时报错：`codepoint 31-20e3 not found in map`

#### 解决方案

在 `quartz.config.ts` 中禁用 CustomOgImages 插件：

```typescript
// Comment out CustomOgImages to speed up build time
// Plugin.CustomOgImages(),
```

---

### 5.6 问题：页面显示旧内容

#### 解决方案

1. **等待几分钟**：GitHub Pages 有缓存
2. **清除浏览器缓存**：使用 Ctrl+Shift+R 或无痕模式
3. **重新触发构建**：推送一个空提交

```bash
git commit --allow-empty -m "Trigger rebuild"
git push origin Github-Pags
```

---

### 5.7 缓存目录

Quartz 的缓存目录位于：`quartz/.quartz-cache/`

清理缓存：
```bash
rm -rf .quartz-cache
```

---

## 第六章：日常维护

### 6.1 更新笔记后自动部署

```bash
cd C:/Users/16344/Desktop/quartz/quartz

# 添加更改
git add -A

# 提交
git commit -m "Update: 添加新笔记"

# 推送（会自动触发 workflow）
git push origin Github-Pags
```

### 6.2 手动触发部署

1. 打开仓库的 Actions 页面
2. 点击 "Deploy Quartz site to GitHub Pages"
3. 点击 "Run workflow" → "Run workflow"

### 6.3 回滚版本

```bash
# 查看历史
git log --oneline

# 回滚到特定版本
git reset --hard 提交的SHA

# 强制推送
git push --force origin Github-Pags
```

---

## 第七章：换电脑使用

### 7.1 需要复制的文件

复制以下文件夹/文件到新电脑：

| 文件/目录 | 是否必须 | 说明 |
|---------|---------|------|
| `content/` | ✅ 必须 | 你的笔记内容 |
| `quartz.config.ts` | ✅ 必须 | 配置文件 |
| `.github/workflows/deploy.yml` | ✅ 必须 | 部署工作流 |
| `quartz/` | ✅ 必须 | Quartz 框架代码 |
| `package.json` | ✅ 必须 | 依赖配置 |
| `package-lock.json` | ✅ 必须 | 依赖锁定 |
| `tsconfig.json` | 建议 | TypeScript 配置 |
| `quartz.layout.ts` | 建议 | 布局配置 |
| `node_modules/` | ❌ 可选 | npm install 会自动下载 |
| `public/` | ❌ 可选 | 可以删除重新构建 |
| `.quartz-cache/` | ❌ 可选 | 可以删除重新生成 |

### 7.2 不需要复制的文件

以下文件/目录可以在新电脑重新生成，不需要复制：

- `node_modules/` - 运行 `npm install` 自动下载
- `public/` - 运行 `npx quartz build` 重新生成
- `.quartz-cache/` - 运行时会自动生成

### 7.3 新电脑操作步骤

#### 步骤 1：安装 Node.js

下载并安装 Node.js：https://nodejs.org

要求：18.x 或更高版本

检查安装：
```powershell
node --version   # 应该是 18.x.x 或更高
npm --version
```

#### 步骤 2：复制文件

将以下文件夹/文件复制到新电脑：
- `content/`
- `quartz.config.ts`
- `.github/workflows/deploy.yml`
- `quartz/`
- `package.json`
- `package-lock.json`
- `tsconfig.json`
- `quartz.layout.ts`
- 其他配置文件

#### 步骤 3：安装依赖

```bash
cd quartz/quartz
npm install
```

#### 步骤 4：运行

```bash
npx quartz build --serve
```

访问 http://localhost:8080 查看网站。

### 7.4 建议的 .gitignore

```
node_modules/
public/
.quartz-cache/
.DS_Store
*.log
```

---

## 第六章：辅助工具

### 6.1 清理脚本 cleanup-git.ps1

在 `content/` 目录下提供一个清理脚本，用于复制文件并清理不需要的 `.git`、`.obsidian` 等文件夹。

#### 脚本位置

`content/cleanup-git.ps1`

```powershell
param(

    [string]$SourcePath = "",

    [switch]$CleanOnly

)

  

# If -CleanOnly flag is used, skip copy

if ($CleanOnly) {

    Write-Host "Clean only mode..."

} else {

    # If no path provided, prompt for input

    if ($SourcePath -eq "") {

        Write-Host "Enter source folder path:" -NoNewline

        $SourcePath = Read-Host

    }

  

    # If still empty, skip copy

    if ($SourcePath -eq "") {

        Write-Host "No source path provided. Skipping copy."

    } else {

        # Verify source exists

        if (-not (Test-Path $SourcePath)) {

            Write-Host "Error: Source folder not found: $SourcePath" -ForegroundColor Red

            exit 1

        }

  

        # Get absolute path

        $SourcePath = (Resolve-Path $SourcePath).Path

        $CurrentFolder = $PWD.Path

  

        Write-Host "Source: $SourcePath"

        Write-Host "Target: $CurrentFolder"

  

        # Copy files (preserve directory structure)

        $CopiedCount = 0

        Get-ChildItem -Path $SourcePath -Recurse -File | ForEach-Object {

            $RelativePath = $_.FullName.Substring($SourcePath.Length).TrimStart('\')

            $DestPath = Join-Path $CurrentFolder $RelativePath

  

            $DestDir = Split-Path $DestPath -Parent

            if (-not (Test-Path $DestDir)) {

                New-Item -ItemType Directory -Path $DestDir -Force | Out-Null

            }

  

            Copy-Item -Path $_.FullName -Destination $DestPath -Force

            $CopiedCount++

        }

  

        Write-Host "Done! Copied $CopiedCount files"

    }

}

  

# Clean .git folders

Get-ChildItem -Path . -Recurse -Directory -Filter ".git" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter ".obsidian" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter ".trash" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter "000Excaildraw" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter "000templates" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter "main" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -Directory -Filter "ExportDocument" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

  
  

Get-ChildItem -Path . -Recurse -File -Filter ".gitignore" -Force | Remove-Item -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path . -Recurse -File -Filter ".gitattributes" -Force | Remove-Item -Force -ErrorAction SilentlyContinue

  

Write-Host "Cleanup done!"
```
#### 功能

1. 复制文件：从指定路径复制文件或文件夹到当前目录
2. 清理：删除 `.git`、`.obsidian`、`.trash`、`000Excaildraw`、`00templates` 等文件夹
3. 清理：删除 `.gitignore`、`.gitattributes` 文件

#### 使用方法

```powershell
# 方式1：复制整个文件夹，然后清理
.\cleanup-git.ps1 "D:\Obsidian笔记\备份"

# 方式2：复制单个文件，然后清理
.\cleanup-git.ps1 D:\Obsidian笔记\500obsidian教程文件\400个人博客教程\1、Quartz-Static-GitHub.md

# 方式3：仅清理，不复制
.\cleanup-git.ps1 -CleanOnly

# 方式4：运行后手动输入路径（不要加双引号）
.\cleanup-git.ps1
```

#### 参数说明

| 参数 | 说明 |
|------|------|
| `path` | 要复制的文件或文件夹路径（不要加引号） |
| `-CleanOnly` | 仅清理，不复制文件 |

#### 使用场景

1. **从另一个笔记库复制内容**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content\200HARDWARE
   .\cleanup-git.ps1 D:\Obsidian笔记\重要笔记
   ```

2. **仅清理当前目录**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content\200HARDWARE
   .\cleanup-git.ps1 -CleanOnly
   ```

3. **复制后自动发布**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content
   .\cleanup-git.ps1 D:\Obsidian笔记\新笔记
   git add -A
   git commit -m "Add new notes"
   git push origin Github-Pags
   ```

### 6.2 草稿与发布 (draft)

Quartz 可以通过 front matter 中的 `draft` 字段控制笔记是否发布。

#### 设置草稿

在笔记开头的 front matter 中添加 `draft: true`：

```yaml
---
title: 我的笔记
tags:
  - 笔记
draft: true
---
```

#### 发布笔记

将 `draft` 改为 `false` 或删除该行：

```yaml
---
title: 我的笔记
tags:
  - 笔记
draft: false
---
```

或者直接删除 `draft` 行：

```yaml
---
title: 我的笔记
tags:
  - 笔记
---
```

#### 注意事项

- `draft: true` 的笔记 **不会** 在构建时发布到网站
- `draft: false` 或没有 `draft` 字段的笔记 **会** 发布
- 草稿笔记在本地 Obsidian 中仍然可以正常查看和编辑
- 建议将未完成的笔记设置为草稿，避免发布未完成内容

#### 批量查看草稿

```powershell
# 搜索所有草稿笔记
Get-ChildItem -Path content -Recurse -File -Filter "*.md" | ForEach-Object {
    if (Select-String -Path $_.FullName -Pattern "draft: true" -Quiet) {
        Write-Host $_.FullName
    }
}
```

---

## 附录

### 附录 A：关键文件位置

| 文件/目录 | 说明 |
|-----------|------|
| `quartz.config.ts` | 主配置文件 |
| `quartz.layout.ts` | 布局配置 |
| `quartz/plugins/` | 插件目录 |
| `content/` | 笔记目录 |
| `public/` | 构建输出目录 |
| `.quartz-cache/` | 缓存目录 |
| `.github/workflows/deploy.yml` | GitHub Actions 配置 |

### 附录 B：常用命令速查

```bash
# 本地开发
npx quartz build --serve

# 构建
npx quartz build

# 清理缓存
rm -rf .quartz-cache

# 提交更新
git add -A && git commit -m "Update" && git push origin Github-Pags
```

### 附录 C：常见问题速查表

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 网站只显示欢迎页 | 内容文件夹是 git submodule | `git rm --cached` + `git add` |
| GitHub 上文件夹显示 "submodule" | 同上 | 同上 |
| push 后 workflow 不运行 | workflow 没监听该分支 | 添加分支名到 workflow |
| 图片 404 | 图片路径显示问题 | 使用 `!` 前缀绝对路径 |
| 公式不显示 | KaTeX 不支持 `\tag{}` | 切换到 MathJax |
| CustomOgImages 错误 | 插件兼容问题 | 禁用该插件 |
| 页面显示旧内容 | 缓存问题 | 等待或手动触发构建 |

### 附录 D：辅助工具

### D.1 清理脚本 cleanup-git.ps1

在 `content/` 目录下提供一个清理脚本，用于复制文件并清理不需要的 `.git`、`.obsidian` 等文件夹。

#### 脚本位置

`content/cleanup-git.ps1`

#### 功能

1. 复制文件：从指定路径复制文件或文件夹到当前目录
2. 清理：删除 `.git`、`.obsidian`、`.trash`、`000Excaildraw`、`00templates` 等文件夹
3. 清理：删除 `.gitignore`、`.gitattributes` 文件

#### 使用方法

```powershell
# 方式1：复制整个文件夹，然后清理
.\cleanup-git.ps1 "D:\Obsidian笔记\备份"

# 方式1：复制整个文件夹，然后清理
.\cleanup-git.ps1 D:\Obsidian笔记\备份

# 方式2：复制单个文件，然后清理
.\cleanup-git.ps1 D:\Obsidian笔记\500obsidian教程文件\400个人博客教程\1、Quartz-Static-GitHub.md

# 方式3：仅清理，不复制
.\cleanup-git.ps1 -CleanOnly

# 方式4：运行后手动输入路径
.\cleanup-git.ps1
```

#### 参数说明

| 参数 | 说明 |
|------|------|
| `path` | 要复制的文件或文件夹路径（不要加引号） |
| `-CleanOnly` | 仅清理，不复制文件 |

#### 使用场景

1. **从另一个笔记库复制内容**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content\200HARDWARE
   .\cleanup-git.ps1 D:\Obsidian笔记\重要笔记
   ```

2. **仅清理当前目录**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content\200HARDWARE
   .\cleanup-git.ps1 -CleanOnly
   ```

3. **复制后自动发布**：
   ```powershell
   cd C:\Users\16344\Desktop\quartz\quartz\content
   .\cleanup-git.ps1 "D:\Obsidian笔记\新笔记"
   git add -A
   git commit -m "Add new notes"
   git push origin Github-Pags
   ```

### D.2 草稿与发布 (draft)

Quartz 可以通过 front matter 中的 `draft` 字段控制笔记是否发布。

#### 设置草稿

在笔记开头的 front matter 中添加 `draft: true`：

```yaml
---
title: 我的笔记
tags:
  - 笔记
draft: true
---
```

#### 发布笔记

将 `draft` 改为 `false` 或删除该行：

```yaml
---
title: 我的笔记
tags:
  - 笔记
draft: false
---
```

或者直接删除 `draft` 行：

```yaml
---
title: 我的笔记
tags:
  - 笔记
---
```

#### 注意事项

- `draft: true` 的笔记 **不会** 在构建时发布到网站
- `draft: false` 或没有 `draft` 字段的笔记 **会** 发布
- 草稿笔记在本地 Obsidian 中仍然可以正常查看和编辑
- 建议将未完成的笔记设置为草稿，避免发布未完成内容

#### 批量查看草稿

```powershell
# 搜索所有草稿笔记
Get-ChildItem -Path content -Recurse -File -Filter "*.md" | ForEach-Object {
    if (Select-String -Path $_.FullName -Pattern "draft: true" -Quiet) {
        Write-Host $_.FullName
    }
}
```

## 附录

- [Quartz 官方文档](https://quartz.jzhao.xyz/)
- [Quartz GitHub 仓库](https://github.com/jackyzha0/quartz)
- [Google Fonts](https://fonts.google.com/)

---

*文档版本：v2.0*
*更新时间：2026-04-25*
*Quartz 版本：4.5.2+*