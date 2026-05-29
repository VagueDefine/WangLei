---
title: 02-SRAM、Flash 与 EEPROM 应用要点
source: "[高速电路设计实践 (王剑宇, 苏颖) (Z-Library)](../../资料/高速电路设计实践%20(王剑宇,%20苏颖)%20(Z-Library).pdf)"
author: WangLI
created: 2026-05-29-星期五
description: SRAM、Flash、EEPROM 应用完整指南
tags:
  - 高速电路设计
  - 存储器
aliases:
  - SRAM Flash应用
  - 非易失存储器设计
draft: false
---

## 一、SRAM（静态随机存储器）

### 1.1 类型
- 异步 SRAM：无时钟，地址变化触发
- 同步 SRAM（ZBT、QDRII）：时钟沿触发

### 1.2 关键参数
- $t_{AA}$：地址访问时间
- $t_{CO}$：时钟到输出（同步）
- $t_{SU}$ / $t_H$：建立/保持时间

### 1.3 应用场景
- 高速缓存（L2/L3 cache）
- 网络设备数据缓冲
- 通信设备包缓冲

## 二、Flash（闪存）

### 2.1 类型
- NOR Flash：随机读取快，适合代码存储
- NAND Flash：顺序读写快，适合大容量数据

### 2.2 关键参数
- 读取速度
- 擦除/写入时间
- 擦写次数（NAND > NOR）
- 坏块管理（NAND）

### 2.3 注意事项
- 写操作必须满足电源电压范围
- 写保护（WP）引脚在电源波动时必须拉低
- 关注读干扰和写干扰问题（NAND）

## 三、EEPROM

### 3.1 特点
- 字节级擦写
- 擦写次数通常 100 万次
- 接口：I²C、SPI、Microwire

### 3.2 PCB 要点
- I²C 上拉电阻选择（1~10kΩ，取决于总线电容）
- 去耦电容靠近 EEPROM 电源引脚
- WP 引脚处理（不用时接 GND）

## 四、存储器选型对比

| 类型 | 速度 | 容量 | 成本 | 易失性 |
|------|------|------|------|--------|
| SRAM | 最快 | 小 | 高 | 易失 |
| SDRAM/DDR | 快 | 大 | 中 | 易失 |
| NOR Flash | 中 | 中 | 中 | 非易失 |
| NAND Flash | 慢 | 大 | 低 | 非易失 |
| EEPROM | 慢 | 小 | 中 | 非易失 |

## 五、设计 checklist

- [ ] SRAM 时序裕量 ≥ 0.5ns？
- [ ] Flash 写保护在电源波动时处理？
- [ ] NAND Flash 坏块管理实现？
- [ ] EEPROM 的 I²C 上拉电阻正确？
- [ ] 热插拔场景的 Flash 保护？
- [ ] 各存储器的电源去耦充分？
