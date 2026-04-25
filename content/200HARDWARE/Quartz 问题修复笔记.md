---
title: Quartz 问题修复笔记
tags:
  - Quartz
  - 博客
  - 部署
---

## 1. 图片显示 404 问题

### 问题描述
构建后图片显示不出来，请求路径是 `/0000assets/...` 返回 404，但文件已经复制到 public 目录。

### 解决方案
在 Markdown 中使用绝对路径引用图片：`![](!0000assets/...`

在 `quartz.config.ts` 中关闭 SPA 路由：
```typescript
enableSPA: false,
```

### 原因分析
当使用 `0000assets/...` 这种相对路径且文件结构和 slug 结构不完全匹配时，Quartz 生成的相对路径计算错误。使用 `!` 前缀表示从内容根目录开始，能正确解析路径。

---

## 2. 公式不显示 / 显示为原始代码

### 问题描述
LaTeX 公式不渲染，显示为原始代码。

### 解决方案
**方案一（推荐）**：切换到 MathJax 渲染引擎

```typescript
// quartz.config.ts
Plugin.Latex({ renderEngine: "mathjax" }),
```

**方案二**：删除所有 `\tag{}` 命令

```latex
// 错误示例
$$F_{clock} = 1/T_{clock}\tag{1}$$

// 正确示例
$$F_{clock} = 1/T_{clock}$$
```

### 问题原因
- `\tag{}` 是 LaTeX 的 AMS 数学包功能，用于给公式添加编号
- KaTeX 对 `\tag{}` 支持不完整，在行间公式中使用会报错导致整个公式渲染失败
- MathJax 对 `\tag{}` 支持更好

---

## 3. CustomOgImages 错误

### 问题描述
构建时报错：`codepoint 31-20e3 not found in map`

### 解决方案
在 `quartz.config.ts` 中禁用 CustomOgImages 插件：

```typescript
// Comment out CustomOgImages to speed up build time
// Plugin.CustomOgImages(),
```

---

## 4. 主题配置

### 配置文件位置
`quartz/config.ts` 中的 `theme` 部分

### 配置项说明

```typescript
theme: {
  fontOrigin: "googleFonts",  // 字体来源
  cdnCaching: true,        // CDN 缓存
  typography: {
    header: "Schibsted Grotesk",   // 标题字体
    body: "Source Sans Pro",        // 正文字体
    code: "IBM Plex Mono",        // 代码字体
  },
  colors: {
    lightMode: {    // 亮色模式
      light: "#faf8f8",        // 背景
      lightgray: "#e5e5e5",    // 边框
      gray: "#b8b8b8",        // 次要文字
      darkgray: "#4e4e4e",     // 主要文字
      dark: "#2b2b2b",        // 标题
      secondary: "#284b63",     // 链接/强调
      tertiary: "#84a59d",     // hover
      highlight: "rgba(143, 159, 169, 0.15)",
      textHighlight: "#fff23688",
    },
    darkMode: {      // 暗色模式
      light: "#161618",
      lightgray: "#393639",
      gray: "#646464",
      darkgray: "#d4d4d4",
      dark: "#ebebec",
      secondary: "#7b97aa",
      tertiary: "#84a59d",
      highlight: "rgba(143, 159, 169, 0.15)",
      textHighlight: "#b3aa0288",
    },
  },
},
```

---

## 5. 常用命令

### 本地开发
```bash
cd C:/Users/16344/Desktop/quartz/quartz
npx quartz build --serve
```

### 部署到 Vercel
1. 创建 `vercel.json`：
```json
{
  "cleanUrls": true
}
```
2. 在 Vercel 控制台配置：
   - Framework Preset: Other
   - Build Command: `npx quartz build`

---

## 6. 缓存目录

Quartz 的缓存目录位于：`quartz/.quartz-cache/`

清理缓存：
```bash
rm -rf .quartz-cache
```

---

## 7. 相关配置文件

- `quartz.config.ts` - 主配置文件
- `quartz.layout.ts` - 布局配置
- `content/` - 笔记目录
- `public/` - 构建输出目录