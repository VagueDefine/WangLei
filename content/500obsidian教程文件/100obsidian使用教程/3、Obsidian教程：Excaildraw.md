---
title: 3、Obsidian教程：Excaildraw
source:
author: WangLI
created: 2026-04-25-星期六
description: "{{description}}"
tags:
  - obsidian教程
aliases:
  - 3、Obsidian教程：Excaildraw
draft:
  - "false"
---
**建议用图片，或者再在根目录固定一个excalidraw文件**
移动笔记时直接复制所有内容
## 显示问题
1. Excaildraw绘图存在native svg样式显示不出来的问题

	![native svg显示问题](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/335102e105e466b17a1238f599eb406d_MD5.jpg)
	
	切换为SVG或者PNG即可显示
	
	![切换步骤](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/86c813214c28494e9b131ff98d6553db_MD5.jpg)

![SVG显示](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/843d2a7f427b5b256750b17fe19c9569_MD5.jpg)

## 存储问题

1. 对于EXcaildraw文件的存储

2. 打开插件基本设置，如下配置


	![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/99a85c676e0ef2dd255b1617bdce8073_MD5.jpg)

对于绘图不用点击按钮创建，不然仍然是默认文件，不在附件中

![不要点击](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/4845561a409f3b712b949527e246d69a_MD5.jpg)

通过`ctrl+p`在笔记的对应位置创建，会存储在插件`Custom Attachment Location`指定存储位置

![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/39b058568e6d7507a3115fd9cd1296e3_MD5.jpg)


![ctrl+p](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/879fb49c8f66ad96df55d1a3468ab081_MD5.jpg)

## 改名&使用问题

### excaildraw文件问题
Excaildraw文件的移动会存在问题，当文件扩展名为`.eacaioldraw.md`时，就会出现，当笔记名更改后，excaildraw附件名也更改了，但是当名字改回来后，excaildraw文件会在之前名字对应附件里，没有更改。

![文件名扩展](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/5516fe51a98cb22da75ec201f3925ca8_MD5.jpg)

![改名后](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/b4b3ae6917c1f3b497f7c9d65aae7825_MD5.jpg)

![出现问题](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/bc0e551da476f4fc08081e1c6c9e5be6_MD5.jpg)

### 正确做法一
不要用带有excaildraw后缀的文件，运用md后缀

![正确做法](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/163878c8a21e08409ee17cf5054799a6_MD5.jpg)
#### 隐藏问题

当修改名字笔记名字时，对应的png会被自动重命名，而excaildraw以md后缀的文件不会的，并且对应的附件也不会移动，这个就需要手动去移动了。这个比较复杂对设置`Custom Attachment Location `

![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/ca3c96785ae593a16b0d42be6e666117_MD5.jpg)

![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/2b1244bf6dd87323922154ee32035492_MD5.jpg)

### 正确做法二

直接不用excaildraw文件，将绘制好的图形，导出png直接当图片插入
缺点就是不能编辑修改了


## 最佳建议（符合软件特性）

根目录下创建000Excalidraw文件命名
![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/e1ab151a08fcd9ad978c886cf5fde4a2_MD5.jpg)

对于命名采用文件名＋时间+完整后缀

![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/3%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9AExcaildraw/c199dea35f6db613a29b3965adc0ab4d_MD5.jpg)