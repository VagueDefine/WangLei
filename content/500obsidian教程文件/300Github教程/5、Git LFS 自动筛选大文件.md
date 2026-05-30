---
title: 5、Git LFS 自动筛选大文件
source:
author: WangLI
created: 2026-04-25-星期六
description: GitHub 对单文件大小有限制（>100MB 会推送失败），但 Git LFS 默认需要手动指定文件类型。本方案实现**自动检测**：提交时自动将大于 100MB 的文件转用 LFS 管理。
tags:
  - GitHub教程
aliases:
  - 5、Git LFS 自动筛选大文件
draft: false
---

# Git LFS 自动筛选大文件配置指南

## 问题背景

GitHub 对单文件大小有限制（>100MB 会推送失败），但 Git LFS 默认需要手动指定文件类型。本方案实现**自动检测**：提交时自动将大于 100MB 的文件转用 LFS 管理。

## 核心原理

利用 Git 的 `pre-commit` 钩子，在提交前自动检查暂存区文件大小，超过阈值则自动执行 `git lfs track`。

> [!info] 注意
> Git LFS 本身基于**路径模式匹配**，不支持直接按文件大小筛选。必须通过钩子实现。

---

## 快速开始（新电脑一键配置）

如果你已经按照本指南配置了仓库，在新电脑上只需：

```bash
# 1. 克隆仓库
git clone https://github.com/VagueDefine/Note-Obsidian-Valut.git

# 2. 进入目录
cd Note-Obsidian-Valut

# 3. 运行配置脚本（自动设置全局钩子）
./setup-git-hooks.sh
```

输出示例：
```
✅ Git LFS 全局钩子配置完成
   Hooks 路径: /c/Users/用户名/.config/git/hooks
```

![自动配置全局hooks](300Github%E6%95%99%E7%A8%8B/0000assets/5%E3%80%81Git%20LFS%20%E8%87%AA%E5%8A%A8%E7%AD%9B%E9%80%89%E5%A4%A7%E6%96%87%E4%BB%B6/52f9d4e34aef0233c8c8a00745c68c3a_MD5.jpg)

---

## 完整配置步骤（首次设置）

### 第一步：创建配置脚本

在你的 Obsidian 仓库根目录执行：

```bash
cat > setup-git-hooks.sh << 'EOF'
#!/bin/bash
# Git LFS 全局钩子配置脚本

HOOK_DIR="$HOME/.config/git/hooks"
mkdir -p "$HOOK_DIR"

cat > "$HOOK_DIR/pre-commit" << 'HOOK'
#!/bin/sh
THRESHOLD=104857600

if ! command -v git-lfs >/dev/null 2>&1; then
    printf >&2 "\n❌ Git LFS 未安装\n"
    exit 1
fi

flag_file=$(mktemp)

git diff --cached --name-only --diff-filter=ACM -z | while IFS= read -r -d '' file; do
    [ "$file" = ".gitattributes" ] && continue
    [ -d "$file" ] && continue
    [ -f "$file" ] || continue
    
    size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null || echo "0")
    case "$size" in ''|*[!0-9]*) continue ;; esac
    
    if [ "$size" -gt "$THRESHOLD" ]; then
        if git check-attr filter -- "$file" 2>/dev/null | grep -q "lfs$"; then continue; fi
        
        printf "⚠️  大文件: %s (%dMB) -> 转LFS\n" "$file" "$((size/1024/1024))"
        git reset HEAD -- "$file" >/dev/null 2>&1
        git lfs track "$file" >/dev/null 2>&1
        git add -- "$file" .gitattributes
        printf "   ✅ 已转换\n"
        echo 1 > "$flag_file"
    fi
done

if [ -s "$flag_file" ]; then
    rm -f "$flag_file"
    printf "\n📝 文件已转LFS，请重新执行 git commit\n"
    exit 1
fi
rm -f "$flag_file"
exit 0
HOOK

chmod +x "$HOOK_DIR/pre-commit"
git config --global core.hooksPath "$HOOK_DIR"

echo "✅ Git LFS 全局钩子配置完成"
echo "   Hooks 路径: $HOOK_DIR"
EOF
```

![创建setup-git-hooks.sh文件](300Github%E6%95%99%E7%A8%8B/0000assets/5%E3%80%81Git%20LFS%20%E8%87%AA%E5%8A%A8%E7%AD%9B%E9%80%89%E5%A4%A7%E6%96%87%E4%BB%B6/96d55ca0528a0f9bbc9adae081a72187_MD5.jpg)
### 第二步：赋予执行权限并提交

```bash
chmod +x setup-git-hooks.sh
git add setup-git-hooks.sh
git commit -m "添加 Git LFS 全局钩子配置脚本"
git push
```

---

## 使用示例

```bash
# 添加一个大文件（如 123MB 的 PDF）
git add "信号完整性与电源完整性分析 第3版.pdf"

# 提交（钩子自动检测并转换）
git commit -m "添加教材"

# 输出示例：
# ⚠️  大文件: 信号完整性与电源完整性分析 第3版.pdf (123MB) -> 转 LFS
#    ✅ 已转换
# 📝 文件已转 LFS，请重新执行 git commit

# 再次提交（已完成转换，直接通过）
git commit -m "添加教材"
git push
```

---

## 验证 LFS 是否生效

```bash
# 查看 .gitattributes
cat .gitattributes
# 输出: 信号完整性与电源完整性分析 第3版.pdf filter=lfs diff=lfs merge=lfs -text

# 查看文件是否为 LFS 指针
git show HEAD:"信号完整性与电源完整性分析 第3版.pdf" | head -3
# 输出应为:
# version https://git-lfs.github.com/spec/v1
# oid sha256:8d1848aee294c7c0b81438f5f9e1737f2d77c31e6760687362621121dac7082f
# size 128462769
```

---

## 迁移旧仓库到全局钩子

如果之前在某个仓库用过本地 pre-commit，现在改用全局：

```bash
# 进入旧仓库
cd /d/Obsidian笔记/main

# 删除本地 pre-commit（现在用全局的）
rm .git/hooks/pre-commit

# 验证全局钩子生效
git config core.hooksPath
# 应输出: ~/.config/git/hooks 或空（空表示使用默认路径）
```

---

## 常见问题

### Q: 如何修改阈值（如改为 50MB）？

编辑全局钩子：
```bash
notepad ~/.config/git/hooks/pre-commit
```

修改 `THRESHOLD` 变量：
```bash
THRESHOLD=52428800  # 50MB
```

### Q: 某个仓库想禁用全局钩子？

```bash
# 进入该仓库，恢复本地 hooks
git config --local core.hooksPath .git/hooks

# 或完全禁用 hooks
git config --local core.hooksPath /dev/null
```

### Q: 已有大文件在历史记录中？

```bash
# 迁移历史记录中的大文件到 LFS
git lfs migrate import --include="*.pdf" --include="*.zip" --everything

# 强制推送到远程（会重写历史，团队协作需谨慎）
git push --force
```

### Q: Windows 下路径问题？

Windows Git Bash 中 `~` 自动映射到 `C:\Users\用户名`，无需修改。

### Q: 换电脑后脚本会同步吗？

会！`setup-git-hooks.sh` 已提交到 Git 仓库，克隆后运行即可恢复配置。这是**方案一**的核心优势。

---

## 补充：常见大文件类型预设

如果希望按文件类型批量管理，可在仓库 `.gitattributes` 中添加：

```gitattributes
# 压缩包
*.zip filter=lfs diff=lfs merge=lfs -text
*.tar.gz filter=lfs diff=lfs merge=lfs -text
*.7z filter=lfs diff=lfs merge=lfs -text

# 媒体文件
*.psd filter=lfs diff=lfs merge=lfs -text
*.mp4 filter=lfs diff=lfs merge=lfs -text
*.mov filter=lfs diff=lfs merge=lfs -text

# 模型/数据文件
*.pth filter=lfs diff=lfs merge=lfs -text
*.h5 filter=lfs diff=lfs merge=lfs -text
*.onnx filter=lfs diff=lfs merge=lfs -text
```

> [!tip] 建议
> 全局钩子（按大小）+ 仓库 `.gitattributes`（按类型）配合使用，覆盖更全面。

---

## 参考链接

- [Git LFS 官方文档](https://git-lfs.github.com/)
- [Git Hooks 文档](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
