---
title: 1、解决 GitHub 文件大小限制
source:
author: WangLI
created: 2026-04-25-星期六
description: "{{description}}"
tags:
  - GitHub教程
aliases:
  - 解决 GitHub 文件大小限制
  - 1、解决 GitHub 文件大小限制
draft: false
---


## 大文件错误

### 1. 报错日志
```bash
remote: error: File Obsidian-1.12.7.exe is 281.84 MB; this exceeds GitHub's file size limit of 100.00 MB remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com. ! [remote rejected] main -> main (pre-receive hook declined) error: failed to push some refs
```

![报错图片](0000assets/1、解决%20GitHub%20文件大小限制/file-20260404190816459.jpg)
### 2. 报错原因

- GitHub 单文件上传硬性限制：**≤100MB**；
- 仓库内混入 `Obsidian-1.12.7.exe`（281.84MB）安装包，超出限制；
- 安装包不属于笔记仓库核心文件，冗余且违规。

---

## 解决步骤

### 1. 取消Git对大文件的追踪（**不删除你电脑上的文件**）

```Bash

git rm --cached Obsidian-1.12.7.exe
```

### 2. 创建忽略文件，永久禁止提交这类大安装包

```Bash

# 创建.gitignore（Git忽略规则文件）
touch .gitignore
# 把exe安装包加入忽略列表
echo "*.exe" >> .gitignore
```

### 3. 撤销包含大文件的本地提交（关键！）

因为你已经把这个大文件提交到本地了，直接推送还是会失败，执行这个命令回退一次提交：

```Bash

git reset --mixed HEAD~1
```

![重新提交](0000assets/1、解决%20GitHub%20文件大小限制/file-20260404190816459%201.jpg)
### 4. 重新提交+推送（只上传你的笔记文件）

```Bash

# 提交所有笔记文件（已自动排除exe）
git add .
git commit -m "提交笔记文件，移除超大安装包"
# 重新推送
git push origin main
```

---

## 补充说明

1. **执行后效果**

    - 你的本地笔记文件完好无损

    - 超大exe安装包仍在你电脑上，但**不会再被Git上传到GitHub**

    - 以后所有`.exe`文件都会被自动忽略，不会再触发报错

2. **仓库使用建议**

你的仓库是存**Obsidian笔记/配置**的，只需要提交：

- `.md` 笔记文件

- 仓库配置文件

软件安装包、压缩包、视频等大文件**一律不要提交**。

### 总结

1. 超标文件：`Obsidian-1.12.7.exe` 281MB＞100MB限制

2. 核心操作：取消追踪+添加忽略+回退提交

3. 重新推送后即可成功上传笔记文件
