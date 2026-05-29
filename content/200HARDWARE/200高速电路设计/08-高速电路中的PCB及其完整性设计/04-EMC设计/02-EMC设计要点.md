---
title: 02-EMC 设计要点
source: "[高速电路设计实践 (王剑宇, 苏颖) (Z-Library)](../../资料/高速电路设计实践%20(王剑宇,%20苏颖)%20(Z-Library).pdf)"
author: WangLI
created: 2026-05-29-星期五
description: PCB EMC 设计完整指南
tags:
  - 高速电路设计
  - EMC
aliases:
  - EMC指南
  - EMC Design Guide
draft: false
---

## 一、三要素
干扰源 + 耦合路径 + 敏感设备

## 二、共模辐射（主要问题）
$$E = \frac{1.26 \times f \times I_{CM} \times L}{d}$$

## 三、屏蔽
- 接地过孔间距 < 1/20 波长
- 屏蔽层低阻抗接地

## 四、滤波

| 类型 | 位置 | 器件 |
|------|------|------|
| 电源输入 | 端口 | CMC + X + Y |
| I/O 信号 | 连接器 | 共模扼流圈 |
| 时钟 | 输出 | RC/磁珠 |

## 五、PCB EMC 规则
- 高速信号走内层
- 时钟加地屏蔽
- I/O 滤波靠连接器
- SW 节点最小化
- 展频时钟降低峰值

## 六、设计 checklist

- [ ] 电源输入有 CMC + X/Y？
- [ ] I/O 滤波靠连接器？
- [ ] 高速信号走内层？
- [ ] 时钟有屏蔽？
- [ ] 屏蔽罩接地 < 1/20λ？
- [ ] 展频时钟考虑？
