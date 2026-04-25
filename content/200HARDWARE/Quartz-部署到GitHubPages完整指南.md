---
title: Quartz 部署到 GitHub Pages 完整指南
tags:
  - Quartz
  - 博客
  - 部署
  - GitHub
---

> 本文档是 Quartz 部署的完整指南，包含安装、配置、部署流程，以及常见问题的解决方案。
> 适用于 Windows 环境，Quartz 版本 4.5.2。

---

## 第一部分：Quartz 基础

### 1.1 什么是 Quartz

Quartz 是一个基于 Obsidian 笔记库的静态网站生成器，可以将你的 Obsidian 笔记发布为个人网站、数字花园或博客。

### 1.2 环境要求

- **Node.js**: 18.x 或更高版本
- **Git**: 用于版本控制
- **Obsidian**: 笔记库（可选，本地编辑用）

### 1.3 安装步骤

#### 1.3.1 克隆 Quartz 模板

```bash
# 创建存放目录
mkdir quartz
cd quartz

# 克隆 Quartz 官方模板
git clone https://github.com/jackyzha0/quartz.git

# 进入目录
cd quartz

# 安装依赖
npm install
```

#### 1.3.2 配置笔记库

将你的 Obsidian 笔记库复制到 `content` 目录：

```
quartz/
├── content/          # 你的笔记目录（复制你的 Obsidian 库）
│   ├── index.md      # 网站首页
│   ├── 000learning/ # 学习笔记
│   └── 200HARDWARE/ # 硬件笔记
├── quartz.config.ts  # 配置文件
├── quartz.layout.ts # 布局配置
└── ...
```

#### 1.3.3 配置文件说明

`quartz.config.ts` 是主配置文件，核心配置项：

```typescript
const config: QuartzConfig = {
  configuration: {
    pageTitle: "我的数字花园",     // 网站标题
    pageTitleSuffix: "",
    enableSPA: false,            // 是否启用 SPA
    enablePopovers: true,        // 是否启用弹出卡片
    baseUrl: "yourname.github.io/repo/",  // 网站基础 URL
    ignorePatterns: [             // 忽略的文件/目录
      "private",
      "**/000templates",
      "**/000Excaildraw",
      ".obsidian",
      ".git",
    ],
  },
  plugins: {
    // 插件配置
  },
};
```

---

## 第二部分：本地使用

### 2.1 本地开发

```bash
cd C:/Users/16344/Desktop/quartz/quartz
npx quartz build --serve
```

访问 http://localhost:8080 查看本地网站。

### 2.2 构建静态文件

```bash
npx quartz build --output public
```

生成的文件在 `public/` 目录。

### 2.3 清理缓存

```bash
rm -rf .quartz-cache
# 或
rmdir /s /q .quartz-cache
```

---

## 第三部分：部署到 GitHub Pages

### 3.1 创建 GitHub 仓库

1. 登录 https://github.com
2. 点击 "New repository"
3. 填写仓库名（如 `WangLei`）
4. 选择 "Public"
5. 点击 "Create repository"

### 3.2 创建部署分支

```bash
cd C:/Users/16344/Desktop/quartz/quartz

# 初始化 git（如果还没有）
git init
git add -A
git commit -m "Initial commit"

# 创建并切换到部署分支
git checkout -b Github-Pags

# 添加远程仓库
git remote add origin https://github.com/你的用户名/仓库名.git

# 推送到远程
git push origin Github-Pags
```

### 3.3 配置 GitHub Actions

创建 `.github/workflows/deploy.yml`：

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

### 3.4 启用 GitHub Pages

1. 进入仓库设置 → Pages
2. Source 选择 "Deploy from a branch"
3. Branch 选择 `Github-Pags`，目录 `/ (root)`
4. 点击 Save

### 3.5 获取网站 URL

部署完成后，GitHub 会提供网站 URL，格式为：`https://用户名.github.io/仓库名/`

---

## 第四部分：问题排查与解决

### 4.1 问题：网站只显示欢迎页，内容不显示

#### 问题描述
构建成功，但网站只显示 index.md 的内容，子文件夹（如 `000learning`、`200HARDWARE`）中的笔记不显示。

#### 排查步骤

1. **检查 GitHub API**：
   ```
   https://api.github.com/repos/你的仓库/contents/content/文件夹名
   ```

2. **检查 Git 树结构**：
   ```bash
   git ls-tree -r HEAD content/
   ```

#### 4.1.1 解决方案：修复 Git Submodule 问题

**原因**：文件夹原本是独立 Git 仓库，被存储为 git submodule（`160000` 模式）。

**症状**：GitHub API 返回 `"type": "submodule"`

**解决步骤**：

```bash
cd C:/Users/16344/Desktop/quartz/quartz

# 1. 从 git 索引移除子模块
git rm --cached content/000learning
git rm --cached content/200HARDWARE

# 2. 重新添加为普通文件
git add content/000learning/ content/200HARDWARE/

# 3. 验证本地构建
npx quartz build --output public

# 4. 提交
git commit -m "Fix: Convert submodules to regular directories"

# 5. 推送
git push origin Github-Pags
```

### 4.2 问题：push 后 workflow 不自动运行

#### 原因
workflow 文件的 `branches` 配置没有包含你的部署分支。

#### 解决
在 workflow 文件中添加你的分支：

```yaml
on:
  push:
    branches:
      - main
      - master
      - Github-Pags  # 添加这一行
```

### 4.3 图片显示 404

#### 问题描述
构建后图片显示不出来，请求路径是 `/0000assets/...` 返回 404。

#### 解决方案
使用绝对路径，并关闭 SPA：

```typescript
// quartz.config.ts
enableSPA: false,
```

在 Markdown 中使用：
```markdown
![](!0000assets/filename.png)
```

### 4.4 公式不显示 / 显示为原始代码

#### 解决方案

**方案一（推荐）**：切换到 MathJax

```typescript
// quartz.config.ts
Plugin.Latex({ renderEngine: "mathjax" }),
```

**方案二**：删除 `\tag{}` 命令

```latex
# 错误
$$F_{clock} = 1/T_{clock}\tag{1}$$

# 正确
$$F_{clock} = 1/T_{clock}$$
```

### 4.5 CustomOgImages 错误

#### 问题描述
构建时报错：`codepoint 31-20e3 not found in map`

#### 解决方案
禁用 CustomOgImages 插件：

```typescript
// quartz.config.ts
// Comment out CustomOgImages to speed up build time
// Plugin.CustomOgImages(),
```

---

## 第五部分：主题配置

### 5.1 配置位置

`quartz.config.ts` 中的 `theme` 部分：

```typescript
theme: {
  fontOrigin: "googleFonts",  // 字体来源
  cdnCaching: true,            // CDN 缓存
  typography: {
    header: "Lexend",         // 标题字体
    body: "Inter",            // 正文字体
    code: "JetBrains Mono",    // ���码��体
  },
  colors: {
    lightMode: {
      light: "#faf4ed",        // 背景
      lightgray: "#cecacd",    // 边框
      gray: "#9893a5",         // 次要文字
      darkgray: "#575279",     // 主要文字
      dark: "#26233a",         // 标题
      secondary: "#d7827e",    // 链接/强调
      tertiary: "#56949f",    // hover
    },
    darkMode: {
      light: "#26233a",
      lightgray: "#42404f",
      gray: "#6e6a86",
      darkgray: "#e0def4",
      dark: "#faf4ed",
      secondary: "#ebbcba",
      tertiary: "#56949f",
    },
  },
},
```

---

## 第六部分：部署到 Vercel（可选）

如果不想用 GitHub Pages，也可以部署到 Vercel：

### 6.1 创建 vercel.json

```json
{
  "cleanUrls": true
}
```

### 6.2 Vercel 控制台配置

- Framework Preset: Other
- Build Command: `npx quartz build`

---

## 第七部分：日常维护

### 7.1 更新笔记

```bash
cd C:/Users/16344/Desktop/quartz/quartz
git add -A
git commit -m "Update notes"
git push origin Github-Pags
```

### 7.2 手动触发部署

1. 访问仓库的 Actions 页面
2. 点击 "Deploy Quartz site to GitHub Pages"
3. 点击 "Run workflow"

---

## 附录：关键文件位置

| 文件 | 说明 |
|------|------|
| `quartz.config.ts` | 主配置文件 |
| `quartz.layout.ts` | 布局配置 |
| `content/` | 笔记目录 |
| `public/` | 构建输出目录 |
| `.quartz-cache/` | Quartz 缓存目录 |
| `.github/workflows/deploy.yml` | GitHub Actions 配置 |

---

## 常见问题速查表

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 网站只显示欢迎页 | 内容文件夹是 git submodule | `git rm --cached` + `git add` 重做 |
| GitHub 上文件夹显示 "submodule" | 同上 | 同上 |
| push 后 workflow 不运行 | workflow 没监听该分支 | 添加分支名到 workflow |
| 图片 404 | 路径问题 | 使用 `!` 前缀绝对路径 |
| 公式不显示 | KaTeX 不支持 `\tag{}` | 切换到 MathJax 或删除 `\tag{}` |
| CustomOgImages 错误 | 插件兼容问题 | 禁用该插件 |

---

*整理时间：2026-04-25*
*Quartz 版本：4.5.2*
*参考文档：https://quartz.jzhao.xyz/*