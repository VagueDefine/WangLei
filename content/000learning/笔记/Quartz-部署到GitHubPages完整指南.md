# Quartz 部署到 GitHub Pages 完整指南

> 本文记录了将 Obsidian 笔记库（包含 `000learning` 和 `200HARDWARE` 文件夹）部署到 GitHub Pages 的完整流程，以及遇到的坑和解决方案。
> 适用于新手小白，环境为 Windows。

## 一、环境信息

- **本地笔记库位置**: `C:\Users\16344\Desktop\quartz\quartz`
- **GitHub 仓库**: https://github.com/VagueDefine/WangLei
- **部署分支**: `Github-Pags`
- **网站 URL**: https://vaguedefine.github.io/WangLei/
- **Quartz 版本**: 4.5.2

## 二、部署后的初始状态

部署完成后，发现以下问题：

1. ✅ GitHub Actions workflow 运行成功（有绿色 ✅ 标记）
2. ❌ 网站只显示欢迎页面，笔记内容不显示
3. ❌ GitHub 仓库中 `000learning` 和 `200HARDWARE` 文件夹显示异常

## 三、问题排查过程

### 3.1 检查 GitHub API

访问 GitHub API 查看文件夹状态：

```
https://api.github.com/repos/VagueDefine/WangLei/contents/content/200HARDWARE
```

返回结果：
```json
{
  "name": "200HARDWARE",
  "type": "submodule",
  "submodule_git_url": null,
  ...
}
```

**发现问题**：文件夹类型显示为 `"type": "submodule"`，而不是 `"dir"`（目录）。

### 3.2 检查 Git 树结构

```bash
cd "C:\Users\16344\Desktop\quartz\quartz"
git ls-tree -r HEAD content/
```

返回结果：
```
160000 commit xxx content/000learning  (git submodule模式)
160000 commit xxx content/200HARDWARE (git submodule模式)
```

**问题确认**：文件夹以 `160000` 模式存储，这是 git submodule 的标志。

### 3.3 根因分析

1. **`000learning` 和 `200HARDWARE` 文件夹内部原本是独立的 Git 仓库**（从 Obsidian 仓库克隆）
2. 当把这些文件夹复制到 Quartz 项目时，保留了 `.git` 文件夹（或这些文件夹被作为 git submodule 添加）
3. Git 将其存储为子模块 (`160000` mode)，导致文件内容无法正确显示

### 3.4 检查 workflow 配置

```yaml
# .github/workflows/deploy.yml
on:
  push:
    branches:
      - main
      - master
  workflow_dispatch:
```

**发现问题**：workflow 只监听 `main` 和 `master` 分支，但我们使用的是 `Github-Pags` 分支，所以手动 push 不会触发自动构建。

## 四、解决方案

### 4.1 修复 Git 子模块问题

**核心思路**：将子模块从 git 索引中移除，然后重新添加为普通文件。

```bash
# 1. 进入项目目录
cd "C:\Users\16344\Desktop\quartz\quartz"

# 2. 从 git 索引移除子模块（仅移除索引记录，不删除实际文件）
git rm --cached content/000learning
git rm --cached content/200HARDWARE

# 3. 重新添加为普通内容（这时文件会变成普通 blob 存储）
git add content/000learning/ content/200HARDWARE/

# 4. 检查状态，确认文件已正确添加
git status

# 5. 提交
git commit -m "Fix: Convert content folders from submodules to regular directories"

# 6. 推送到远程
git push origin Github-Pags
```

**关键点**：
- `git rm --cached` 只删除索引中的引用，不删除实际文件
- 重新 `git add` 后，文件会以普通 blob 形式存储（100644 模式）
- 执行 `npx quartz build` 验证本地构建是否正常：
  ```bash
  npx quartz build --output public
  ```
  成功输出：`Parsed 137 Markdown files` + `Emitted 466 files to public`

### 4.2 修复 Workflow 触发问题

编辑 `.github/workflows/deploy.yml`：

```yaml
# 原始配置
on:
  push:
    branches:
      - main
      - master

# 修改后
on:
  push:
    branches:
      - main
      - master
      - Github-Pags   # 添加自定义部署分支
  workflow_dispatch:  # 允许手动触发
```

**完整 workflow 文件**：

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

提交并推送：
```bash
git add .github/workflows/deploy.yml
git commit -m "Fix: Add Github-Pags branch trigger"
git push origin Github-Pags
```

## 五、部署验证

### 5.1 检查 Workflow 状态

访问：https://github.com/VagueDefine/WangLei/actions

或 API：
```bash
https://api.github.com/repos/VagueDefine/WangLei/actions/runs?status=in_progress
```

### 5.2 确认内容显示

部署完成后，访问网站：
- 主页：https://vaguedefine.github.io/WangLei/
- 200HARDWARE 文件夹：https://vaguedefine.github.io/WangLei/200HARDWARE/
- 000learning 文件夹：https://vaguedefine.github.io/WangLei/000learning/

## 六、常见问题速查

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 网站只显示欢迎页，内容不显示 | 内容文件夹是 git submodule | 执行 `git rm --cached` + `git add` 重做 |
| GitHub 上文件夹显示为 "submodule" | 同上 | 同上 |
| push 后 workflow 不自动运行 | workflow 没监听该分支 | 在 workflow 的 `branches` 中添加分支名 |
| 部署完成但内容空白 | 可能是缓存问题 | 等待几分钟后刷新，或使用无痕模式 |

## 七、日常维护

### 7.1 更新笔记后的流程

```bash
cd "C:\Users\16344\Desktop\quartz\quartz"

# 添加更改
git add -A

# 提交
git commit -m "Update notes"

# 推送（会自动触发 workflow）
git push origin Github-Pags
```

### 7.2 手动触发部署

如果 workflow 没有自动触发，可以手动运行：

1. 访问 https://github.com/VagueDefine/WangLei/actions
2. 点击 "Deploy Quartz site to GitHub Pages"
3. 点击右侧 "Run workflow" → "Run workflow"

## 八、关键文件位置

- **Quartz 配置**: `C:\Users\16344\Desktop\quartz\quartz\quartz.config.ts`
- **内容目录**: `C:\Users\16344\Desktop\quartz\quartz\content\`
- **Workflow 文件**: `C:\Users\16344\Desktop\quartz\quartz\.github\workflows\deploy.yml`
- **清理脚本**: `C:\Users\16344\Desktop\quartz\quartz\content\cleanup-git.ps1`

## 九、总结

本次部署遇到的两个核心问题：

1. **Git Submodule 问题**：子模块是历史遗留问题，需要清除缓存后重新添加
2. **Workflow 触发问题**：需要明确指定要监听的分支

最终部署成功，网站正常显示。

---

*整理时间：2026-04-25*
*Quartz 版本：4.5.2*
*参考文档：https://quartz.jzhao.xyz/*