---
tags:
  - LDO
name: LT3045,LT3094.TPS7A330
Time: 2025-12-16T11:29:00
Supplement:
---
## 参数
#### PSRR电源抑制比计算
电源抑制比（Power Supply Rejection Ratio, PSRR）也称纹波抑制比，通常在 LDO 的数据手册中能找到，它代表 LDO 在某个频率下从输入到输出的衰减程度，代表不同频率下纹波抑制能力。在有些高速通信电路如 Wi-Fi、蓝牙等，就需要用上电源抑制比较大的高速 LDO，当芯片需要瞬间拉大电流时能快速响应，不至于掉到低于额定电压导致负载重启。还有一些场景是使用 DC-DC 作为一级降压、LDO 作为二级降压 / 滤波，因为 DC-DC 开关频率在 kHz-MHz 级别，即 LDO 在 100kHz 以上，就需要严格考虑 PSRR 了。
![PSRR](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041117.png)
PSRR计算公式：
$$PSRR=20log\frac{V_{rp(in)}}{V_{rp(out)}} \tag{1}$$
其中， $V_{rp(in)}$表示输入纹波，$V_{rp(out)}$表示输出纹波。高速 LDO 的 PSRR 一般大于 60dB，而普通 LDO 的 PSRR 一般在 20dB 左右。60dB 的 PSRR 代表当输入纹波为 1V 时，输出纹波将为 1mV。
![LT3045-PSRR-curve](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041120.png)
![TPS7a330](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041120%201.png)

### 电压
 输出电压：最小数值：$1.221A$也是***内部参考电压**
- [ ] 输入电压：$V_{in}-GND=40V$
- [ ] 输出电压：$V_{out}$
### 电流
![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041121.png)
![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041121%201.png)

### 特性
![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041122.png)

### DATASHEET
![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041087.pdf)

![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041090.pdf)

![](100电源芯片/120PowerCircult/0000assets/122-LDO-PSRR/file-20251223210041092.pdf)