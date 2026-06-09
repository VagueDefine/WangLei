---
title: 1、Claude Code 最新版安装教程
source: https://daheiai.com/cc-install.html
author: WangLei
created: 2026-06-08T11:09:00
modified: 2026-06-08T11:09:00
description:
tags:
  - ClaudeCode
  - ai
  - agent
  - 
aliases:
  - ClaudeCode
  - Claude
  - 
draft: false
---

# Claude Code 最新版安装教程

面向普通用户的 Claude Code 安装与模型接入指南。

Up: **人工大黑** | [视频版](https://www.bilibili.com/video/BV1J1dqBkEMu)

---

## 📖 目录

1. [安装 Git Bash（仅 Windows）](1、Claude%20Code%20最新版安装教程.md#安装-git-bash仅-windows)
2. [安装 Claude Code 本体](1、Claude%20Code%20最新版安装教程.md#安装-claude-code-本体)
3. [配置环境变量 PATH](1、Claude%20Code%20最新版安装教程.md#配置环境变量-path)
4. [安装 cc-switch，接入更多模型](1、Claude%20Code%20最新版安装教程.md#安装-cc-switch接入更多模型)
5. [Claude Code 基础使用](1、Claude%20Code%20最新版安装教程.md#claude-code-基础使用)
6. [常见问题](1、Claude%20Code%20最新版安装教程.md#常见问题)

---

## 安装 Git Bash（仅 Windows）

> Mac / Linux 用户请跳过此步骤。

Claude Code 原生是为 Linux / macOS 设计的，而 Windows 系统命令不同，所以需要装 Git 来进行一个准备工作。

下载安装包，安装时狂点下一步就行。

### 下载 Git for Windows

| 版本 | 下载 | 提取码 |
|------|------|--------|
| 📥 **64-bit**（适用于绝大多数 Windows 电脑） | [蓝奏云下载](https://wwayc.lanzoub.com/iSdog3n29ung) | `67no` |
| 📥 **ARM64**（适用于 ARM 处理器的 Windows 电脑） | [蓝奏云下载](https://wwayc.lanzoub.com/ioqPy3n29vmb) | `f3m1` |

备用：也可从 [Git 官网](https://git-scm.com/download/win) 下载

---

## 安装 Claude Code 本体

打开终端（Windows 用 PowerShell，Mac/Linux 用 Terminal），粘贴命令即可：

### Windows

```powershell
irm https://daheiai.com/cc.ps1 | iex
```

安装 2.1.153 老版本命令：

```powershell
& ([scriptblock]::Create((irm https://daheiai.com/cc.ps1))) 2.1.153
```

备用：官方原版命令 `irm https://claude.ai/install.ps1 | iex`

### Mac / Linux

```bash
curl -fsSL https://daheiai.com/cc.sh | sh
```

安装 2.1.153 老版本命令：

```bash
curl -fsSL https://daheiai.com/cc.sh | sh -s -- 2.1.153
```

备用：官方原版命令 `curl -fsSL https://claude.ai/install.sh | sh`

> [!NOTE] 版本说明
> 因为 2.1.156 版本使用第三方 API 存在兼容性问题，建议回退 153 版本。
>
> 整个过程会下载一个 200+MB 的软件，取决于个人的网络状态，时间可能**会很长**。

> [!WARNING] 重要声明
> 本页面提供的 **Claude Code Windows 安装脚本（cc.ps1）** 用于自动化安装流程。作者不提供代理、中转或文件托管服务。具体的脚本内容已开源，放在 [GitHub](https://github.com/daheiai/claude-code-install-scripts) 上面可公开查看。
>
> - 脚本会获取官方版本信息（`latest` / `manifest.json`），并在本地执行安装。
> - **所有二进制文件（claude.exe）均由用户电脑直接从 Anthropic 官方 Google Cloud Storage 存储桶下载。**
> - 使用前请确认当前网络环境能够正常访问 `storage.googleapis.com` 及相关官方地址。
> - 本项目与 **Anthropic, Inc.**、**Google LLC** 均无关联、合作或授权关系。
>
> **使用本脚本即表示您已阅读并同意：** 请自行评估网络、系统与数据环境，并遵守所在地法律法规。使用过程中产生的设备、数据、账号或其他结果，由使用者自行承担。

---

## 配置环境变量 PATH

把 `C:\Users\你的用户名\.local\bin\` 加到用户级 PATH。

### Windows 操作

> [!TIP] 具体操作
> 点开开始菜单，输入环境变量，点"编辑系统环境变量"。
>
> 在窗口下面点"环境变量"，在系统环境变量里找到 `Path`，双击它。
>
> 新建一条，把 `C:\Users\你的用户名\.local\bin\` 复制进去。

### Mac / Linux

> [!TIP] 通常不需要手动配置
> Mac / Linux 的安装脚本一般会自动配置 PATH。
>
> 先试试关掉当前终端，重开一个新的输入 `claude`。
>
> 如果还是找不到命令，手动把以下内容加到你的 shell 配置文件中：

```bash
export PATH="$HOME/.local/bin:$PATH"
```

加到 `~/.bashrc` 或 `~/.zshrc`，然后执行 `source ~/.zshrc` 生效。

---

## 安装 cc-switch，接入更多模型

软件装好了，但还没有 AI 模型可用。这时候需要 **cc-switch**，它可以切换不同的 AI 模型提供商。

> [!TIP] cc-switch 支持的模型
> [智谱 GLM](https://www.bigmodel.cn/glm-coding?ic=VF3QVUP0OZ)、[MiniMax](https://platform.minimaxi.com/subscribe/token-plan?code=FwZQHdpVR1&source=link)、[Kimi](https://www.kimi.com/membership/pricing)、[DeepSeek](https://platform.deepseek.com) 等
>
> Claude、GPT 等模型可通过 [API 服务](https://api.daheiai.com/) 接入。

### 下载 cc-switch

| 平台 | 下载 | 提取码 |
|------|------|--------|
| 📦 **Windows** | [蓝奏云下载](https://wwayc.lanzoub.com/iiHKV3n29yhe) | `cxjy` |
| 📦 **macOS** | [蓝奏云下载](https://wwayc.lanzoub.com/i9hKz3n29uxg) | `cxjy` |

新版本发布时可从 [GitHub Releases](https://github.com/farion1231/cc-switch/releases) 获取更新

### cc-switch 添加渠道示意图

![](0000assets/1、Claude%20Code%20最新版安装教程/file-20260608102713005.jpg)

安装完成后，以智谱 GLM 为例，在 cc-switch 选择 Claude 图标（默认是第一个），然后添加渠道，填入密钥，指定模型名称，最后启用。回到终端输入 `claude` 就可以直接开始对话了。

### 安装后仍然报错的一种情况

![](0000assets/1、Claude%20Code%20最新版安装教程/file-20260608102713006.jpg)

> [!FAQ]- 如果你出现了上图这种情况，点这里查看处理方式
>
> **原因：** CC Switch 的作用就是一键修改 Claude Code 的配置文件，但 Claude Code 在首次运行时如果没有通过检测，会直接忽略你自定义的 API 地址，还是会去强行连接官方做登录检查。
>
> **方法一：通过命令的方式来跳过**
>
> 直接在终端运行以下命令，向 `.claude.json` 写入"已完成初始化"的标识：
>
> macOS / Linux：
> ```bash
> echo '{"hasCompletedOnboarding": true}' > ~/.claude.json
> ```
>
> Windows：
> ```powershell
> echo '{"hasCompletedOnboarding": true}' > $env:USERPROFILE\.claude.json
> ```
>
> **方法二：手动修改一个文件**
>
> 打开这个文件，比如 `C:\Users\admin\.claude.json`。这个路径里的用户名部分每个人都不一样，看你自己的用户名是什么。
>
> 它默认可能是隐藏的，你需要在文件管理器上面勾选一下显示隐藏的文件。如果你的电脑上直接没有这个文件，那就新建一个也可以。
>
> 然后把这个内容复制进去：`"hasCompletedOnboarding": true,`
>
> 保存文件，确保 CC Switch 已经切换到你自己的渠道后，重启你的 Claude Code。如果你的格式会报错，比如多了一个引号、括号或句号，可以把文件里的内容全选复制，发给任意一个网页版 AI，让它只修复格式、保留原有内容，然后把结果重新粘贴回来。
>
> ![](0000assets/1、Claude%20Code%20最新版安装教程/file-20260608102713004.jpg)

---

## Claude Code 基础使用

#### 怎么启动 Claude Code？

先进入你要工作的文件夹，再输入 `claude`。右键文件夹用终端打开最快；如果右键没有，就先打开终端，再用 `cd + 文件夹路径` 进入工作目录。

#### 下次回来怎么接着聊？

用同样的方式回到这个工作目录，仍然先启动 `claude`，然后在对话框内输入 `/resume`，就可以选择曾经在这个工作目录中的各种历史会话，回车即可恢复选中的会话了。

#### 对话太长怎么办？

聊满的时候，Claude Code 会自动压缩；随时可以输入 `/context` 来查看当前会话的上下文占用情况。或者你担心自动压缩来得猝不及防，你也可以手动输入 `/compact`。压缩次数越多，越早期的内容越容易失真。

#### 为什么要在终端里用它？

因为终端里的输入和输出都是文字，AI 处理文字最快。它可以直接读文件、改文件、运行命令，所以你可以用它写代码、排查问题、处理项目文件。

---

## 常见问题

### 如何卸载 Claude Code？

官方目前更推荐原生安装方式，本教程采用的也是这种方式。**正常卸载方式：打开设置 > 应用 > 已安装的应用，搜索"Claude Code"，点击三个点，然后选择卸载。**

> [!FAQ]- 系统应用列表里找不到 Claude Code 时，展开查看手动清理方式
>
> **1. 卸载核心程序**
>
> 以管理员身份打开 PowerShell（普通 PowerShell 也可以），逐行运行：
>
> ```powershell
> # 删除 claude 可执行文件
> Remove-Item -Path "$env:USERPROFILE\.local\bin\claude.exe" -Force
>
> # 删除 Claude Code 的版本和共享文件
> Remove-Item -Path "$env:USERPROFILE\.local\share\claude" -Recurse -Force
> ```
>
> **2. 完全清理**
>
> 继续运行以下命令，删除用户配置目录，防止残留配置影响重装：
>
> ```powershell
> # 删除主配置文件夹（包含设置、工具、历史记录等）
> Remove-Item -Path "$env:USERPROFILE\.claude" -Recurse -Force
>
> # 删除配置文件（如果存在）
> Remove-Item -Path "$env:USERPROFILE\.claude.json" -Force
> ```
>
> > [!CAUTION] 注意
> > 删除 `~/.claude` 会清除所有 Claude Code 的设置、自定义工具、MCP 服务器和会话历史。以后还想继续使用这些内容，建议先备份这个文件夹。
>
> **3. 验证是否卸载干净**
>
> 运行下面命令检查：
>
> ```powershell
> claude --version
> ```
>
> 如果提示「command not found」或类似错误，就说明已经卸载成功。也可以用 `where claude` 查看是否还有残留路径。

### 如何更新 Claude Code？

当前版本采用手动更新方式。想更新时，重新运行一次安装命令即可。

---

*来源：[daheiai.com](https://daheiai.com/) · 由 [人工大黑](https://daheiai.com/) 整理*
