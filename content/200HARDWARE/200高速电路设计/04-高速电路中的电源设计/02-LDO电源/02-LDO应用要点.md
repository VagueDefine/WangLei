---
title: 02-LDO应用要点
source: "[高速电路设计实践 (王剑宇, 苏颖) (Z-Library)](../../资料/高速电路设计实践%20(王剑宇,%20苏颖)%20(Z-Library).pdf)"
author: WangLI
created: 2026-05-29-星期五
description: LDO 电源的完整选型设计指南，涵盖参数、结温计算、PSRR、PCB布局等要点
tags:
  - 高速电路设计
  - 电源设计
  - LDO
aliases:
  - LDO应用要点
  - LDO Selection
  - LDO设计指南
draft: false
---

## 一、LDO 工作原理

LDO 通过调整管（Pass Element）的线性调节实现稳压。核心指标：

- **压差 $V_{dropout}$**：维持调节所需的最小输入-输出压差
- **静态电流 $I_q$**：LDO 自身消耗的电流
- **电源抑制比 PSRR**：对输入纹波的抑制能力

## 二、关键参数

### 2.1 压差
- PMOS LDO 的 $V_{dropout}$ 可低至 100~300mV
- NMOS LDO 需要电荷泵驱动，压差可更低
- 低压差 LDO 适合电池供电

### 2.2 静态电流
- 高精度 LDO：$I_q$ 几百 μA
- 低功耗 LDO：$I_q$ < 1μA（轻载高效）
- 超低 $I_q$ LDO 的瞬态响应较差

### 2.3 电源抑制比 PSRR
- DC 时 PSRR 通常 60~80dB
- 1MHz 时 PSRR 降至 20~40dB
- 高频段（>10MHz）PSRR 基本失效，需配合磁珠/LC 滤波

### 2.4 输出噪声
- 低噪声 LDO 输出电压噪声 < 10μVrms
- 用于 ADC/DAC/PLL 供电

## 三、结温计算

$$T_J = T_A + P_{diss} \times \theta_{JA}$$
$$P_{diss} = (V_{in} - V_{out}) \times I_{load} + V_{in} \times I_q$$

**选型铁律**：$T_J < T_{Jmax}$（通常 125°C），建议留 20°C 余量。

## 四、LDO vs DC-DC 选型

| 场景 | 选型 | 原因 |
|------|------|------|
| 3.3V→3.0V（小压差） | LDO | 高效率、低纹波 |
| 5V→1.2V（大压差） | DC-DC | LDO 效率过低（24%） |
| 模拟电路供电 | LDO | 低噪声、高 PSRR |
| >1A 负载 | DC-DC | LDO 散热难处理 |
| 电池供电待机 | LDO | 超低 $I_q$ |

**经验法则**：当 $(V_{in} - V_{out}) > 2V$ 且 $I_{load} > 100mA$ 时，优先考虑 DC-DC。

## 五、PCB 布局要点

- 输入/输出电容紧靠 LDO 引脚
- 反馈分压电阻靠近 FB 引脚放置
- 功率路径短而宽，减小 DCR
- LDO 底部铺铜皮并打过孔散热
- SENSE 走线远离 SW 节点和电感

## 六、选型 checklist

- [ ] 输入输出电压范围满足要求？
- [ ] 最大输出电流满足负载需求？
- [ ] 结温在安全范围内？
- [ ] PSRR 在目标频段足够高？
- [ ] 压差满足最小输入输出条件？
- [ ] 输出噪声是否适合负载芯片？
- [ ] 静态电流是否满足功耗预算？
- [ ] 是否具备热关断和过流保护？
