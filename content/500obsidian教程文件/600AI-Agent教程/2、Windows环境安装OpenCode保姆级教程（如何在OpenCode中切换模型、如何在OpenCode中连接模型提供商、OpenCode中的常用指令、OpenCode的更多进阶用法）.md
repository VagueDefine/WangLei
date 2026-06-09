---
title: 2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）
source: https://blog.csdn.net/m0_62128476/article/details/157857984
author: WangLei
published: 2026-02-13
created: "[object Object]"
description: Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）_opencode windows
tags:
  - opencode
  - ai
  - agent
  - 
aliases:
  - opencode
  - 
draft: false
---
[Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）_opencode windows-CSDN博客](https://blog.csdn.net/m0_62128476/article/details/157857984)
#### 文章目录

- [1\. 什么是OpenCode](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#1_OpenCode_1)
- - [1.1 OpenCode的官网](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#11_OpenCode_7)
		- [1.2 OpenCode的GitHub地址](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#12_OpenCodeGitHub_18)
- [2\. OpenCode和ClaudeCode有什么区别](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#2_OpenCodeClaudeCode_32)
- - [2.1 开源性与生态](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#21__34)
		- [2.2 模型提供商支持](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#22__39)
- [3\. 安装OpenCode](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#3_OpenCode_44)
- - [3.1 下载Node.js](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#31_Nodejs_46)
		- - [3.1.1 通过安装包安装Node.js（适合普通用户）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#311_Nodejs_48)
				- [3.1.2 通过NVM安装Node.js（适合开发人员）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#312_NVMNodejs_96)
		- [3.2 下载OpenCode](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#32_OpenCode_100)
		- - [3.2.1 使用cmd下载](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#321_cmd_102)
				- [3.2.2 使用powershell下载](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#322_powershell_120)
		- [3.3 验证OpenCode是否成功安装](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#33_OpenCode_137)
		- [3.4 使用powershell下载OpenCode时可能遇到的问题](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#34_powershellOpenCode_155)
		- - [3.4.1 问题一：npm : 无法加载文件 D:\\Nvm\\nodejs\\npm.ps1，因为在此系统上禁止运行脚本。](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#341_npm___DNvmnodejsnpmps1_157)
				- [3.4.2 问题二：opencode : 无法加载文件 D:\\Nvm\\nodejs\\opencode.ps1，因为在此系统上禁止运行脚本。](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#342_opencode___DNvmnodejsopencodeps1_168)
				- [3.4.3 两个问题产生的原因：Windows本身的安全防护机制，与npm/Node.js 无关](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#343_WindowsnpmNodejs__178)
				- [3.4.4 解决方法：以普通用户身份修改PowerShell的执行策略](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#344_PowerShell_182)
		- [3.5 更新OpenCode到最新版本](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#35_OpenCode_213)
- [4\. 如何在OpenCode中切换模型](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#4_OpenCode_235)
- [5\. 如何在OpenCode中连接模型提供商](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#5_OpenCode_258)
- - [5.1 连接第三方模型提供商（以阿里云为例）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#51__260)
		- - [5.1.1 在阿里云百炼创建Api Key](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#511_Api_Key_264)
				- [5.1.2 在阿里云百炼中查看模型用量](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#512__341)
		- [5.2 连接本地部署的大模型（以LM Studio为例）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#52_LM_Studio_393)
		- - [5.2.1 在OpenCode中连接通过LM Studio部署的大模型](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#521_OpenCodeLM_Studio_395)
				- [5.2.2 解决本地部署的多模态大模型无法识别图片的问题](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#522__466)
		- [5.3 OpenCode提供的免费模型](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#53_OpenCode_532)
		- - [5.3.1 查看OpenCode提供的免费模型](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#531_OpenCode_536)
				- [5.3.2 在OpenCode中使用免费模型](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#532_OpenCode_558)
- [6\. OpenCode内置的两个Agent（Build和Plan）有什么区别](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#6_OpenCodeAgentBuildPlan_583)
- - [6.1 两个Agent的核心定位与视角](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#61_Agent_590)
		- [6.2 两个Agent在工作方式上的区别](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#62_Agent_598)
		- [6.3 两个Agent的使用流程与最佳实践](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#63_Agent_607)
- [7\. OpenCode中的常用指令](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#7_OpenCode_619)
- - [7.1 /compact（压缩上下文）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#71_compact_621)
		- [7.2 /connect（连接模型提供商）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#72_connect_625)
		- [7.3 /export（导出对话）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#73_export_629)
		- [7.4 /fork（创建对话分支）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#74_fork_633)
		- [7.5 /init（初始化项目）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#75_init_637)
		- [7.6 /models（查看/切换模型）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#76_models_641)
		- [7.7 /new（新建会话）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#77_new_645)
		- [7.8 /sessions（会话管理）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#78_sessions_649)
		- [7.9 /share（分享会话）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#79_share_653)
		- [7.10 /themes（更换主题）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#710_themes_657)
		- [7.11 切换到Shell模式](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#711_Shell_662)
		- [7.12 @explore（探索模式） + @（文件引用）](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#712_explore___670)
- [8\. 参考视频](2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）.md#8__701)

## 1\. 什么是OpenCode

OpenCode 是一款开源的、在终端中运行的 AI 编程智能体

OpenCode 本质上是一个强大的“模型调度层”，不绑定特定 AI，支持接入 GPT、DeepSeek 等 75+ 种模型

### 1.1 OpenCode的官网

OpenCode 的官网：[https://opencode.ai/](https://opencode.ai/)

```url
https://opencode.ai/
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520536.jpg)

### 1.2 OpenCode的GitHub地址

OpenCode 的 GitHub 地址：[https://github.com/anomalyco/opencode](https://github.com/anomalyco/opencode)

```url
https://github.com/anomalyco/opencode
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520538.jpg)

如果无法正常访问 GitHub，可以参考我的另一篇博文：[GitHub的使用技巧（加速访问GitHub、查看GitHub的热门项目、查看GitHub推荐的项目、Fork、Issue、快速找到项目的安装包、GitHub的各种快捷键）](https://blog.csdn.net/m0_62128476/article/details/145234074)

## 2\. OpenCode和ClaudeCode有什么区别

### 2.1 开源性与生态

- **OpenCode**：100%开源（MIT许可证），代码完全透明可审计，400+ 贡献者持续维护。作为一个开源项目，它由社区驱动，任何人都可以查看、修改和分发其代码
- **Claude Code**：商业闭源产品，由 Anthropic 官方开发维护。Anthropic 对其拥有完全的控制权，从底层模型优化到上层功能实现，都经过精心打磨，以确保稳定、流畅的用户体验

### 2.2 模型提供商支持

- **OpenCode**：支持 75+ 模型提供商（Claude、GPT、Gemini、智谱AI、DeepSeek等），可以自由切换模型提供商，甚至可以使用本地模型(Ollama 和 LM Studio)
- **Claude Code**：Claude Code原生仅支持 Anthropic 的 Claude 系列模型，通过配置可扩展支持 75+ 模型提供商，包括国产大模型和 GPT 系列

## 3\. 安装OpenCode

### 3.1 下载Node.js

#### 3.1.1 通过安装包安装Node.js（适合普通用户）

下载地址：[https://nodejs.org/zh-cn/download](https://nodejs.org/zh-cn/download)

```url
https://nodejs.org/zh-cn/download
```

在下拉列表中选择最新的长期支持的版本（带有 LTS 后缀的版本）后，点击左下角的 `Windows 安装程序(.msi)` 按钮开始下载

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520535.jpg)

下载完成后，双击 `node-v24.13.0-x64.msi` 文件，一路点击 Next 就可以了

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520543.jpg)

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520542.jpg)

---

更改安装路径后点击 Next 按钮

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520541.jpg)

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520540%201.jpg)

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520540.jpg)

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520539.jpg)

#### 3.1.2 通过NVM安装Node.js（适合开发人员）

参考我的另一篇博文：[Windows环境使用NVM高效管理多个Node.js版本（NVM的完整安装流程、NVM相关配置、NVM的常用命令、使用NVM时可能遇到的问题、NVM管理多个Node.js版本的原理）](https://blog.csdn.net/m0_62128476/article/details/147378717)

### 3.2 下载OpenCode

#### 3.2.1 使用cmd下载

按下 `Win + R` 快捷键，输入 `cmd` 打开终端

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520537.jpg)

输入 npm i -g opencode-ai 指令下载 OpenCode

```bash
npm i -g opencode-ai
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520536%201.jpg)

#### 3.2.2 使用powershell下载

按下 win + x 快捷键，打开 powershell 窗口

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520534.jpg)

输入 npm i -g opencode-ai 指令下载 OpenCode

```bash
npm i -g opencode-ai
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520533.jpg)

### 3.3 验证OpenCode是否成功安装

在终端中输入 `opencode` 指令

```bash
opencode
```

如果能看到以下界面，说明 OpenCode 安装成功了

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520532%201.jpg)

我们简单地跟 OpenCode 聊个天

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520532.jpg)

### 3.4 使用powershell下载OpenCode时可能遇到的问题

#### 3.4.1 问题一：npm : 无法加载文件 D:\\Nvm\\nodejs\\npm.ps1，因为在此系统上禁止运行脚本。

PS C:\\Users\\NieKeYi> npm i -g opencode-ai  
npm : 无法加载文件 D:\\Nvm\\nodejs\\npm.ps1，因为在此系统上禁止运行脚本。有关详细信息，请参阅 https:/go.microsoft.com/fwli  
nk/?LinkID=135170 中的 about\_Execution\_Policies。

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520531.jpg)

#### 3.4.2 问题二：opencode : 无法加载文件 D:\\Nvm\\nodejs\\opencode.ps1，因为在此系统上禁止运行脚本。

opencode : 无法加载文件 D:\\Nvm\\nodejs\\opencode.ps1，因为在此系统上禁止运行脚本。有关详细信息，请参阅 https:/go.microsof  
t.com/fwlink/?LinkID=135170 中的 about\_Execution\_Policies。

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520530.jpg)

#### 3.4.3 两个问题产生的原因：Windows本身的安全防护机制，与npm/Node.js 无关

PowerShell 默认执行策略为 `Restricted`，会主动拦截所有 `.ps1` 脚本（包括 Node.js 生成的 `npm.ps1`），属于 Windows 本身的安全防护机制，与 npm/Node.js 无关

#### 3.4.4 解决方法：以普通用户身份修改PowerShell的执行策略

复制以下指令，粘贴到 PowerShell 中执行

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```
- **`RemoteSigned`**：允许运行本地脚本（如 npm.ps1），仅要求网络下载脚本需签名
- **`-Scope CurrentUser`**：仅影响当前用户，安全无风险
- **`-Force`**：跳过确认提示（避免卡在 Y/N 选择）

---

执行完 `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force` 指令后，我们验证指令是否生效

```powershell
Get-ExecutionPolicy -Scope CurrentUser
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520528%201.jpg)

再次输入与 npm 有关的指令

```bash
npm -v
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520528.jpg)

### 3.5 更新OpenCode到最新版本

> - **OpenCode 版本迭代十分迅速，几乎每天都有小更新，使用前可以先更新**
> - **更新 OpenCode 前最好先关闭正在运行的实例，否则可能会导致更新失败**

按下 `Win + R` 快捷键，输入 `cmd` 打开终端

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520537.jpg)

在终端中输入 npm update -g opencode-ai 指令更新 OpenCode 到最新版本

```bash
npm update -g opencode-ai
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520527.jpg)

## 4\. 如何在OpenCode中切换模型

在 OpenCode 中输入 /models 指令后按下回车

```bash
/models
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520526.jpg)

使用键盘上的 ↑、↓、←、→ 键选取模型，选择完成后按下回车（也可以使用鼠标选取模型）

---

如果模型右边带有 Free 关键字，说明该模型有一定的免费额度，我们可以薅一波羊毛

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520525.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520524.jpg)

## 5\. 如何在OpenCode中连接模型提供商

### 5.1 连接第三方模型提供商（以阿里云为例）

我们以阿里云为例，演示如何连接第三方模型提供商

#### 5.1.1 在阿里云百炼创建Api Key

阿里云提供了 Coding Plan 套餐，如果需要长期使用，建议购买 Coding Plan 套餐：[Coding Plan](https://www.aliyun.com/benefit/scene/codingplan?userCode=cb3vgkf5)

```url
https://www.aliyun.com/benefit/scene/codingplan?userCode=cb3vgkf5
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520522.jpg)

---

首先，我们打开阿里云百炼的模型广场：[https://bailian.console.aliyun.com/cn-beijing/?tab=model#/model-market](https://bailian.console.aliyun.com/cn-beijing/?tab=model#/model-market)

```url
https://bailian.console.aliyun.com/cn-beijing/?tab=model#/model-market
```

点击左下角的 `API Key` 选项

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520523.jpg)

---

创建一个 API Key

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520520.jpg)

---

填入描述后点击确定按钮

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520513.jpg)

---

在 OpenCode 中输入 /connect 指令

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520512.jpg)

在输入框中搜索 Alibaba 关键字，选择 Alibaba (China) 选项

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520511.jpg)

把刚才创建好的 API Key 粘贴到输入框内，按下回车键

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520510.jpg)

输入 API Key 后会弹出模型列表让你选择，在输入框中可以搜索模型

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520509.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520508.jpg)

选择好模型后就可以正常开始对话了

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520507.jpg)

#### 5.1.2 在阿里云百炼中查看模型用量

阿里云百炼开通后 90 天内会赠送一定的免费额度，在模型用量中可以看到每个模型的免费额度剩余量

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520499.jpg)

主流的国产模型（qwen3.6-plus、glm-5.1、kimi-k2.5）都有一百万的免费额度

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520473.jpg)

---

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520471.jpg)

---

我们可以选择免费额度用完即停

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520472.jpg)

> - **只要买过一次包月或者包季，下一次买任何一个套餐将不会有折扣，所以首次购买可以选择优惠力度比较大的且量大的套餐，**
> - **如果使用量比较大，建议购买 Coding Plan 套餐（在可以模型差距不大的情况下，哪个云厂商的 Coding Plan 便宜就买哪个）**

如果是首次购买，还可以享受优惠：[https://www.aliyun.com/benefit/scene/ai-discount](https://www.aliyun.com/benefit/scene/ai-discount)

```url
https://www.aliyun.com/benefit/scene/ai-discount
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520470.jpg)

首次包季低至 4.5 折（非广告）

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520469.jpg)

模型调用计费规则：[模型调用计费](https://bailian.console.aliyun.com/cn-beijing/?tab=doc#/doc/?type=model&url=2987148)

```url
https://bailian.console.aliyun.com/cn-beijing/?tab=doc#/doc/?type=model&url=2987148
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520467.jpg)

---

### 5.2 连接本地部署的大模型（以LM Studio为例）

#### 5.2.1 在OpenCode中连接通过LM Studio部署的大模型

首先，我们在 LM Studio 内查看模型的 ID 值（点击按钮可以复制）

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520466.jpg)

接着在 `C:\Users\NieKeYi\.config\opencode` 目录（其中 NieKeYi 改成你的用户名）下找到 opencode.json 文件（如果没有就手动创建一个）

```url
C:\Users\NieKeYi\.config\opencode
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520462.jpg)

在 opencode.json 文件中添加以下内容，将 qwen/qwen3.5-9b 改成 LM Studio 中模型的 ID 值

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520457.jpg)

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "lmstudio": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "LM Studio",
      "options": {
        "baseURL": "http://localhost:1234/v1"
      },
      "models": {
        "qwen/qwen3.5-9b": {
          "name": "qwen/qwen3.5-9b"
        }
      }
    }
  }
}
```

**保存 opencode.json 文件需要重启 OpenCode 才能生效**

---

重启 OpenCode 后，输入 /connect 指令

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520461.jpg)

找到 LM Studio 分组

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520458.jpg)

输入 API Key 后按下回车（如果没有 LM Studio 没有设置 API Key 的话，输入一个空格后按下回车）

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520459.jpg)

选择我们在 LM Studio 中部署的模型

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520454.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520460.jpg)

#### 5.2.2 解决本地部署的多模态大模型无法识别图片的问题

> - **多模态大模型，可以理解为能够直接识图的大模型，无需借助 OCR 工具，例如 qwen3.5 模型**
> - **可以直接复制图粘贴到 OpenCode 的聊天框中，也可以将图片文件拖进到聊天窗口**

发送图片给本地部署的多模态大模型时，大模型会说无法直接处理图片

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520455.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520456.jpg)

通常不是因为模型本身不支持，而是 OpenCode 的配置文件中没有明确说明“这个模型可以处理图片”

即使使用的本地模型（如 Qwen3.5）具备多模态能力，OpenCode 默认也可能只把它当作一个纯文本模型来使用，我们需要通过配置来“解锁”多模态大模型的图像识别功能

---

我们在 opencode.json 文件中添加以下配置，“解锁”多模态大模型的图像识别功能

```json
"modalities": {
  "input": ["text", "image"],
  "output": ["text"]
}
```
```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "lmstudio": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "LM Studio",
      "options": {
        "baseURL": "http://localhost:1234/v1"
      },
      "models": {
        "qwen/qwen3.5-9b": {
          "name": "qwen/qwen3.5-9b",
		  "modalities": {
            "input": ["text", "image"],
            "output": ["text"]
          }
        }
      }
    }
}
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520438.jpg)

---

**保存 opencode.json 文件后重启 OpenCode，发送图片给 OpenCode 测试，发现模型已经能够正常处理图片了**

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520449.jpg)

我们在 LM Studio 中的控制台中可以看到，图片是以 Base64 的方式传输的

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520440.jpg)

### 5.3 OpenCode提供的免费模型

**使用 OpenCode 提供的免费模型时偶尔会出现发送消息后迟迟不回复的情况，大概率是因为“薅羊毛”的人太多，导致算力资源供不应求，请求只能在后台排队处理**

#### 5.3.1 查看OpenCode提供的免费模型

> **一些模型刚发布时，OpenCode 可能会限时免费提供，例如之前小米发布的 MiMo V2 Pro 模型**

在 OpenCode 的官网可以查看 OpenCode 提供哪些免费模型：[https://opencode.ai/docs/zh-cn/zen](https://opencode.ai/docs/zh-cn/zen)

```url
https://opencode.ai/docs/zh-cn/zen
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520452.jpg)

值得注意的是，如果使用免费的模型，你的数据是有可能会被模型提供商收集用来改进模型的，说白了就是，你免费用它的模型，它免费用你的数据，具体可以参考 OpenCode 官网：[隐私](https://opencode.ai/docs/zh-cn/zen#%E9%9A%90%E7%A7%81)

```url
https://opencode.ai/docs/zh-cn/zen#%E9%9A%90%E7%A7%81
```

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520435.jpg)

#### 5.3.2 在OpenCode中使用免费模型

OpenCode 提供了一个名为 **OpenCode Zen** 的精选模型列表，列表里的模型可以免费使用

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520453.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520436.jpg)

因为是免费模型，所以我们无需获取 API Key，输入空格后按下回车就可以了

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520451.jpg)

我们选择刚出的小米大模型（社区反馈 Big Pickle 模型的效果不错，可以试一下）

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520439.jpg)

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520434.jpg)

## 6\. OpenCode内置的两个Agent（Build和Plan）有什么区别

OpenCode 内置内置了 Build 和 Plan 两个 Agent，按下 Tab 键可以切换

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520448.jpg)

### 6.1 两个Agent的核心定位与视角

| 特性 | Plan Agent（规划模式） | Build Agent（构建模式） |
| --- | --- | --- |
| **角色定位** | 架构师视角 | 工程师视角 |
| **主要功能** | 项目结构设计、技术选型建议、任务拆解等宏观规划 | 代码补全、函数生成、语法修复等即时操作 |
| **权限级别** | 只读Agent，拒绝文件编辑 | 全权限Agent，可直接修改文件 |

### 6.2 两个Agent在工作方式上的区别

| 方面 | Plan Agent | Build Agent |
| --- | --- | --- |
| **输出形式** | 生成自然语言形式的实施计划和设计文档 | 生成实际代码并执行文件修改 |
| **操作权限** | 默认拒绝文件编辑，运行bash命令前会请求权限 | 可直接执行文件修改和终端命令 |
| **适用场景** | 探索陌生代码库、规划变更、分析依赖关系 | 日常开发工作、代码生成与修改 |
| **安全级别** | 高（只读模式） | 中（全权限模式） |

### 6.3 两个Agent的使用流程与最佳实践

OpenCode 推荐的标准化操作路径：

1. **启动与规划**：在终端输入需求后，默认进入Plan模式，AI分析代码库并提出修改建议
2. **模式切换**：确认计划无误后，按下`Tab`键或输入`/build`，将上下文切换至执行状态
3. **代码落地**：AI 开始生成 Diff 并写入文件

---

根据社区测试数据，采用"先Plan后Build"策略的复杂重构任务，**代码一次性通过率提升了约40%**

## 7\. OpenCode中的常用指令

### 7.1 /compact（压缩上下文）

对话内容过多时压缩上下文

### 7.2 /connect（连接模型提供商）

切换 API 提供商，配置模型连接

### 7.3 /export（导出对话）

导出对话记录（导出的文件默认会存放在当前用户的家目录下，例如 C:\\Users\\NieKeYi 目录）

### 7.4 /fork（创建对话分支）

复制当前对话上下文，创建一个独立的分支，在不影响原对话的情况下尝试新的思路或修改

### 7.5 /init（初始化项目）

在项目根目录创建 AGENTS.md 文件，分析项目结构

### 7.6 /models（查看/切换模型）

查看可用模型列表并切换当前使用的模型

### 7.7 /new（新建会话）

创建新的对话会话

### 7.8 /sessions（会话管理）

查看并切换历史会话

### 7.9 /share（分享会话）

生成分享链接

### 7.10 /themes（更换主题）

更换 OpenCode 的界面主题

### 7.11 切换到Shell模式

> **按下 ESC 键可以退出 Shell 模式**

在 OpenCode 的输入框中输入感叹号 `!`，会切换到 Shell 模式，**Shell 命令的输出结果会作为上下文返回**

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520446.jpg)

### 7.12 @explore（探索模式） + @（文件引用）

- @explore：调用探索型子代理，适合快速理解陌生仓库结构、查找相关代码模块或搜索特定关键词，侧重于侦察而非修改
- @（文件引用）：先输入 `@explore` 指令，再输入 `@` 符号，引用特定文件或文件夹进入上下文，让 AI 精准关注指定代码内容

---

如果想快速让 OpenCode 理解整个项目的结构，可以直接在聊天框中发送 `@explore` 指令

OpenCode 收到 `@explore` 指令后会扫描当前工作目录，分析项目中的文件、文件夹及其依赖关系，迅速掌握项目的整体脉络、模块划分以及核心文件的位置，生成一份结构化的项目概览，为后续的代码生成、重构或问题定位打下基础

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520442.jpg)

**可以在 Shell 模式下输入 pwd 指令查看当前的工作目录，工作目录仅与 cmd 窗口 powershell 窗口的启动目录有关，即使后续使用了 cd 指令改变目录，工作目录也不会改变**

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520444.jpg)

如果只是想引用某个文件，输入 @explore 指令之后，先删除聊天框的 @explore 内容，再次输入 @ 就能引用文件或文件夹了

![在这里插入图片描述](0000assets/2、Windows环境安装OpenCode保姆级教程（如何在OpenCode中切换模型、如何在OpenCode中连接模型提供商、OpenCode中的常用指令、OpenCode的更多进阶用法）/file-20260608110520443.jpg)

## 8\. 参考视频

- [OpenCode 是近期热度最高的AI编程工具。 它的最大优势是有开箱即用的免费模型，通过简单配置，还能免费接入Gemini3 Pro，Claude 4.5 Opus等顶级编程模型。OpenCode 可以看作是一个开源版的Claude Code，几乎具备Claude Code一切功能。非常适合小白上手AI编程，可以随便造随便玩，可以用它练习 Agent Skills，MCP，Subagnet 等高级特性。 本期视频是一个OpenCode的完整教程。](https://www.douyin.com/video/7596320684435983659)
- [第7集 | opencode 里面的 big pickle 模型是哪一家的？效果还不错，仅次于这个 GPT5 nano，可以作为一个备份，优于 MINIMax M2.5](https://www.douyin.com/video/7626757735572426026)
- [第9集 | AI 编程还能开源无限制？opencode 封神！ 它是 100% 开源的 AI 编码代理，支持 Claude、OpenAI 等多模型，终端和桌面端都能用！#GitHub #github优质项目 #程序员 #ai #青年创作者成长计划](https://www.douyin.com/video/7599879021190597888)
- [OpenCode保姆级教程第2期，白嫖Claude模型 上期根据文档，手把手带大家安装了OpenCode，相信很多朋友已经感受到了它的强大，本期是opencode的第二期，主要带你完成三件事：1. 免费接入最强编程模型Gemini 3 pro 与Claude 4.5 opus; 2.教你安装Skills与MCP; 3.安装超级增强插件 oh-my-opencode](https://www.douyin.com/video/7602423338950020395)