---
title: 1、PanDoc问题
source: "{{url}}"
author: WangLI
created: 2026-04-25-星期六
description: 本地文件导出和pandoc的使用
tags:
  - obsidian本地软件
aliases:
  - 1、PanDoc问题
draft: false
---


## 问题一，导出时附件路径有问题

![](0000assets/1、PanDoc问题/file-20260402223536918.jpg)
显示找不到附件路径。对于这个问题常常出现在导入的文档命名时并没有重新命名刷一下，此时附件命名不是配置的那种，就会出现找不到文件路径
**消除办法为，给笔记重新命名然后再改回去，此时附件名字就会你被重新刷新然后命名就对了，就可以导出了**

## 注意

1. 对于`pandoc`的使用，本笔记的所有导出都采用`Enhancing Export` 插件，但是对于这个插件需要有`pandoc.exe` 对于此需要单独下载安装然后配置才能使用

![](0000assets/1、PanDoc问题/file-20260402223536919%201.jpg)

![](0000assets/1、PanDoc问题/file-20260402223536919.jpg)


## Pandoc建议添加到系统路径

1. 复制pandoc可执行文件路径

	![pandoc路径](200%E9%97%AE%E9%A2%98%E5%92%8C%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B/0000assets/1%E3%80%81PanDoc%E9%97%AE%E9%A2%98/4954db40b3c0424e587d842dcdf4e077_MD5.jpg)
2. 打开编辑系统环境
	![](200%E9%97%AE%E9%A2%98%E5%92%8C%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B/0000assets/1%E3%80%81PanDoc%E9%97%AE%E9%A2%98/46040b9cdab5749e242f0f433394ac2d_MD5.jpg)
3. 添加到系统路径，通过`pandoc -v`验证

	![添加到系统路径](200%E9%97%AE%E9%A2%98%E5%92%8C%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B/0000assets/1%E3%80%81PanDoc%E9%97%AE%E9%A2%98/696d5618002156e2505d2b27b0717490_MD5.jpg)
	![终端验证](200%E9%97%AE%E9%A2%98%E5%92%8C%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B/0000assets/1%E3%80%81PanDoc%E9%97%AE%E9%A2%98/94ea4b7599e44a8fdf27fbfecf527a41_MD5.jpg)