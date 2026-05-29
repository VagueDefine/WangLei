---
title: 01-SDRAM 与 DDR 时序经典案例
source: "[高速电路设计实践 (王剑宇, 苏颖) (Z-Library)](../../资料/高速电路设计实践%20(王剑宇,%20苏颖)%20(Z-Library).pdf)"
author: WangLI
created: 2026-05-29-星期五
description: SDRAM/DDR 接口时序设计中的经典故障案例，涵盖读写时序、DQ-DQS 对齐、Vref 噪声等问题
tags:
  - 高速电路设计
  - 存储器
  - SDRAM
aliases:
  - SDRAM案例
  - DDR Case
  - 存储器时序案例
draft: false
---

## 一、相关案例

### 案例一：DDR3 写入时序 DQ 与 DQS 未对齐

某 DDR3 接口设计运行在 800MHz，实测发现写入数据时 DQ 与 DQS 的相位关系偏移约 90°，导致数据写入错误。

#### 讨论

DDR3 写入操作中 DQS 是源同步时钟，标准要求 DQ 与 DQS 边沿中心对齐，偏移量不应超过 ±0.25tCK。

设计中 FPGA 到 DDR3 颗粒的 DQ 和 DQS 走线没有严格等长，差值为 200mil。在 FR4 上 200mil 约 30ps，加上 FPGA 内部输出延迟偏差后，总相位偏移达到 0.35UI。

**改进**：
1. DQ 和 DQS 走线长度差控制在 ±20mil 以内
2. 使用 FPGA 内部的 IODELAY 模块调整 DQS 相位
3. 进行 write leveling 训练

---

### 案例二：DDR Vref 噪声导致采样错误

某 DDR2 设计中 Vref 由电阻分压从 VDD 得到，Vref 走线靠近 DDR 数据线，高速运行时出现随机数据错误。

#### 讨论

Vref 是 DDR 输入缓冲器的比较基准，噪声容限极低。DDR2 的 Vref 要求 $0.5 \times VDD \pm 1\%$。由于 Vref 走线靠近数据线，串扰耦合了 30mV 噪声，超出容限。

**改进**：
1. Vref 走线远离数据线和时钟线
2. Vref 走线用地线屏蔽
3. 使用专用 Vref 发生器（如 TPS51100）

---

### 案例三：DDR 读操作 Data Eye 不满足要求

某 DDR3-1600 设计读操作时，FPGA 接收端看到的 Data Eye 开口宽度仅 0.4UI，低于规格要求的 0.6UI。

#### 讨论

读操作中 DDR 颗粒输出 DQ 和 DQS（边沿对齐），接收端用 90° 相移后的 DQS 采样 DQ。Data Eye 开口变小的原因包括：
- DDR 颗粒的输出保持时间 $t_{DH}$ 偏小
- DQ 和 DQS 走线长度不匹配
- DQ 线间串扰

**改进**：
1. DQ 组内等长 ±10mil
2. DQS 与 DQ 等长差 ±20mil
3. 进行 read leveling 训练

---

### 案例四：地址/命令信号时序不满足建立时间

某 DDR3 设计中地址和命令信号从 FPGA 到 4 片 DDR3 颗粒，400MHz 时地址信号时序不满足所有颗粒的建立时间要求。

#### 讨论

地址/命令信号是单端信号，采用 Fly-by 拓扑时，信号到第 4 片比到第 1 片多了 0.3ns 走线延迟。

**改进**：
1. 使用 DDR3 的 write leveling 补偿
2. 确保阻抗连续减少反射

---

### 案例五：DLL 缺陷造成 DDR SDRAM 时序出错

某 DDR SDRAM 设计在高温环境下出现数据错误，经排查是 DDR 芯片内部的 DLL 在高温下失锁。

#### 讨论

DDR SDRAM 内部的延迟锁相环（DLL）用于调整 DQS 相对于 DQ 的相位。高温下 DLL 的延迟链漂移，导致 DQS 相位偏移超出容限。

**改进**：
1. 定期（或每次刷新时）重新锁定 DLL
2. 选择温度特性更好的 DDR 颗粒
3. 增加系统散热

---

## 二、案例总结

| 案例 | 根因 | 教训 |
|------|------|------|
| 一 | DQ-DQS 偏斜过大 | 源同步总线必须严格等长 |
| 二 | Vref 噪声耦合 | Vref 需专用发生器和保护 |
| 三 | Data Eye 开口不足 | 需进行读写 leveling 训练 |
| 四 | 地址信号时序偏移 | DDR3 用 Fly-by + leveling |
| 五 | DLL 高温失锁 | 关注存储器温度特性 |
