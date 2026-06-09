# PFC+LLC技术综合应用

> **参考来源：**
> - [零基础掌握先进的PFC+LLC解决方案（知乎）](https://www.zhihu.com/tardis/bd/art/8370202774)
> - [【技术文章】零基础掌握先进的PFC+LLC解决方案（PFC篇）](https://forum.monolithicpower.cn/t/topic/4929)
> - [零基础掌握先进的PFC+LLC解决方案（LLC篇）](https://www.ednchina.com/technews/28734.html)
> - [PFC与LLC技术在传感器接口电路中的应用（抖音）](https://so-landing.douyin.com/search_ai_mobile/share_canvas?_pia_=1&share_src=share_url&search_hash=6efc4b13991c6b612fd302950fba425e15445cda&aid=1128&scene=canvas&ai_title=%E8%AE%B2%E4%B8%80%E4%B8%AA%E5%92%8C%E4%BC%A0%E6%84%9F%E5%99%A8%E6%8E%A5%E5%8F%A3%E7%94%B5%E8%B7%AF%E7%9B%B8%E5%85%B3%E7%9A%84pfc+llc+%E9%A1%B9%E7%9B%AE&schema_type=66&utm_campaign=client_share&app=aweme&utm_medium=ios&tt_from=copy&utm_source=copy&query=%E8%AE%B2%E4%B8%80%E4%B8%AA%E5%92%8C%E4%BC%A0%E6%84%9F%E5%99%A8%E6%8E%A5%E5%8F%A3%E7%94%B5%E8%B7%AF%E7%9B%B8%E5%85%B3%E7%9A%84pfc%20llc%20%E9%A1%B9%E7%9B%AE&search_id=20250622012736B6059FC4CEF1DBB6D803)

# PFC+LLC技术综合应用

## 一、PFC技术概述

### 1.1 为什么要用PFC
- **功率因数校正**：解决无PFC电源在AC输入端的电流波形畸变问题
- **电网保护**：将畸变的电流波形修正为正弦波，保护电网质量
- **效率提升**：提高电源系统效率，减少能量损耗

无PFC时的电流波形（非正弦、谐波严重）：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010196%201.png)

有PFC后的电流波形（正弦、与电压同相）：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010195%201.png)

### 1.2 PFC控制方式

PFC 可以有很多种不同实现方式，但大部分实用电路都是在 Boost 或在 Boost 基础上的衍生变形。PFC电路拓扑（基于Boost电路）：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010197.png)

**而从控制方式的角度来说，PFC 主要可以分为 CCM 和 CrM 两类。**

| 控制模式            | 适用功率               | 优点                | 缺点            |
| --------------- | ------------------ | ----------------- | ------------- |
| **CCM**（连续导通模式） | **大功率 >300W-400W** | 电感电流峰值低，可实现较大输出功率 | 二极管反向恢复引入开关损耗 |
| **CRM**（临界导通模式） | **小功率 <300W-400W** | 二极管自然过零关断，无反向恢复问题 | 电感电流峰值较大      |

## 二、LLC谐振变换器

### 2.1 LLC工作原理
- **谐振网络组成**：谐振电感（Lr）、谐振电容（Cr）、励磁电感（Lm）
- **软开关技术**：实现零电压开关（ZVS）和零电流开关（ZCS）
- **超高的转换效率和极低的电磁噪声**

LLC谐振变换器拓扑：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010193.jpg)

### 2.2 LLC增益特性
LLC输入到输出的增益与开关频率有直接关系：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010199.png)

- **谐振频率**：增益为1，实现软开关和高效变压器利用率
- **Region 1**（f > fr）：增益随频率升高而下降；轻载时增益调节幅度有限
- **Region 2**（f < fr）：增益随频率升高而上升，可提供升压能力，但频率下降导致励磁电流增加
- **Region 3**（容性模式）：Q值大时进入，导致硬开关问题

当开关频率等于谐振频率时：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010198%201.png)

## 三、PFC+LLC配合优势

### 3.1 互补性
- **PFC解决LLC的弱点**：PFC将宽范围输入电压（85Vac-265Vac）提升到固定值（400V），弥补LLC对输入电压范围敏感的缺陷
- **LLC发挥优势**：在固定输入输出比例下实现高效率软开关

### 3.2 系统架构
```
AC输入 → PFC级（Boost电路）→ 固定直流电压（400V）→ LLC级 → 低压直流输出
```

系统架构图：

![](0000assets/PFC%E4%B8%8ELLC%E6%8A%80%E6%9C%AF%E5%9C%A8%E4%BC%A0%E6%84%9F%E5%99%A8%E6%8E%A5%E5%8F%A3%E7%94%B5%E8%B7%AF%E4%B8%AD%E7%9A%84%E5%BA%94%E7%94%A8/file-20260604100954948.png)

## 四、MPS解决方案

### 4.1 集成控制芯片

**HR1211**：集成CCM PFC和LLC控制

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010195.png)

**HR1275**：集成CrM PFC和LLC控制

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010197%201.png)

### 4.2 主要特性
- **全范围高效率**：轻载时自动降低开关频率，过渡到断续电流状态
- **谷底开通**（HR1275）：通过内部检测电路保证谷底开通，降低开关损耗
- **PF/THD补偿**：自适应消除非理想因素，在各种条件下实现0.9以上PF值

PF补偿功能效果：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010194.png)

- **电流模式LLC控制**：稳定性和响应速度更优
- **Skip/Burst模式**：实现全范围高效率
- **设计工具**：可视化接口软件辅助方案设计

> **相关产品与资源链接：**
> - [HR1211（CCM PFC+LLC）](https://xg.zhihu.com/plugin/9da1cc990eb1923fa2e8dfc0075c79dd?BIZ=ECOMMERCE)
> - [HR1275（CrM PFC+LLC）](https://xg.zhihu.com/plugin/b188fc5566686bb9e3198b657dd51069?BIZ=ECOMMERCE)
> - [MPS PFC+LLC设计工具](https://xg.zhihu.com/plugin/602148858650df3c97757d2f6919b349?BIZ=ECOMMERCE)
> - [MPS中文技术论坛](https://xg.zhihu.com/plugin/77269ca1062f14305d7208c7768d4933?BIZ=ECOMMERCE)

LLC控制特性图：

![](0000assets/3%E3%80%81PFC+%E5%85%A8%E6%A1%A5LLC/file-20260604101010198.png)

## 五、应用场景与优势总结

### 5.1 传感器接口电路
- **高效稳定的电源系统**：结合PFC和LLC技术
- **动态响应**：负载突变时输出电压快速恢复
- **电磁兼容性**：满足高性能电源应用要求

### 5.2 优势总结
- **提高效率**：减少能量损耗，提升系统效率
- **增强稳定性**：确保系统可靠运行
- **电磁兼容性**：满足各种高性能电源应用要求
- **全范围高效率**：PFC+LLC架构已成为现代电源设计的标准方案
