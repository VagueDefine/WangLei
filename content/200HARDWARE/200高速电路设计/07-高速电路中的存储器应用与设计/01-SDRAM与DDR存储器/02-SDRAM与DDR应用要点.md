---
title: 02-SDRAM 与 DDR 应用要点
source: "[高速电路设计实践 (王剑宇, 苏颖) (Z-Library)](../../资料/高速电路设计实践%20(王剑宇,%20苏颖)%20(Z-Library).pdf)"
author: WangLI
created: 2026-05-29-星期五
description: SDRAM/DDR 存储器应用完整指南，涵盖 DDR 演变、时序参数、拓扑、PCB 设计等要点
tags:
  - 高速电路设计
  - 存储器
  - SDRAM
aliases:
  - SDRAM应用
  - DDR Design
  - 存储器设计
draft: false
---

## 一、SDRAM 到 DDR5

| 代次 | 速率(MT/s) | 电压(V) | 特点 |
|------|-----------|---------|------|
| SDRAM | 66-133 | 3.3 | 单沿采样 |
| DDR | 200-400 | 2.5 | 双沿采样，DLL |
| DDR2 | 400-800 | 1.8 | 片内 ODT，Posted CAS |
| DDR3 | 800-2133 | 1.5 | Fly-by，Write Leveling |
| DDR4 | 1600-3200 | 1.2 | VPP，DBI |
| DDR5 | 3200-6400+ | 1.1 | 双通道，片上 ECC |

## 二、关键时序参数

### 2.1 写入时序
- $t_{DS}$：DQ 相对于 DQS 的建立时间
- $t_{DH}$：DQ 相对于 DQS 的保持时间
- DQ 以 DQS 为中心对齐

### 2.2 读取时序
- DDR 输出 DQ 和 DQS 边沿对齐
- 接收端将 DQS 延迟 90° 后采样 DQ

### 2.3 命令/地址时序
- $t_{IS}$：命令/地址相对于 CK 的建立时间
- $t_{IH}$：命令/地址相对于 CK 的保持时间

## 三、拓扑选择

| 拓扑 | 适用 | 特点 |
|------|------|------|
| 菊花链 | DDR2 以前 | 末端端接 |
| Fly-by | DDR3+ | 阻抗连续，需 Leveling |
| T 型 | 双 Rank | 阻抗不连续，低速 |

## 四、端接

| 信号 | 端接 | 说明 |
|------|------|------|
| DQ/DQS | ODT（片内） | DDR 颗粒内部可选 |
| 地址/命令 | VTT 端接 | 40-60Ω 到 VDD/2 |
| CK | 100Ω 差分 | - |

## 五、PCB 要点（DDR3-1600 参考）

- DQ 组内等长：±10mil
- DQS 到 DQ：±20mil
- 地址/命令：±50mil
- 单端阻抗：40-60Ω
- 差分阻抗：80-100Ω

## 六、设计 checklist

- [ ] 拓扑选择正确（DDR3+ 用 Fly-by）？
- [ ] 阻抗控制目标明确？
- [ ] 各信号组等长要求定义？
- [ ] ODT 值设置合理？
- [ ] Write/Read Leveling 已规划？
- [ ] Vref 低噪声设计？
