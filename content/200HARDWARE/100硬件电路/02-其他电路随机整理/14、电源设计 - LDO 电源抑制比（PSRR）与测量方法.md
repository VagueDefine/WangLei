[电源设计 - LDO 电源抑制比（PSRR）与测量方法 - Power's Wiki](https://wiki-power.com/%E7%94%B5%E6%BA%90%E8%AE%BE%E8%AE%A1-LDO%E7%94%B5%E6%BA%90%E6%8A%91%E5%88%B6%E6%AF%94%EF%BC%88PSRR%EF%BC%89%E4%B8%8E%E6%B5%8B%E9%87%8F%E6%96%B9%E6%B3%95/)  
# 电源设计 - LDO 电源抑制比（PSRR）与测量方法

低压差线性稳压器（LDO）相比 DC-DC 的优点之一，是输出电压纹波小。但是高速电路下，LDO 的电源抑制比（PSRR）也是不可忽略的因素，通常被误认为是单一的静态值，本篇文章将详细讲解电源抑制比（PSRR）及如何测量它。

## 电源抑制比（PSRR）的定义
电源抑制比（Power Supply Rejection Ratio, PSRR）也称纹波抑制比，通常在 $LDO$ 的数据手册中能找到，它代表 $LDO$ 在某个频率下从输入到输出的衰减程度，代表不同频率下纹波抑制能力。在有些高速通信电路如 Wi-Fi、蓝牙等，就需要用上电源抑制比较大的高速 $LDO$，当芯片需要瞬间拉大电流时能快速响应，不至于掉到低于额定电压导致负载重启。还有一些场景是使用 DC-DC 作为一级降压、$LDO$作为二级降压 / 滤波，因为 DC-DC 开关频率在 kHz-MHz 级别，即 $LDO$ 在 $100kHz$ 以上，就需要严格考虑 $PSRR$ 了。

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350472-84873c1f-5a04-4766-be7e-25713fd66f26.png)

电源抑制比（PSRR）用公式表示为：
$$
PSRR(dB)=20\log\frac{V_{rp(in)}}{V_{rp(out)}}\tag{1} 
$$
其中，$V_{rp(in)}$ 表示输入纹波，$V_{rp(out)}$ 表示输出纹波。高速 $LDO$ 的 $PSRR$ 一般大于 $60dB$，而普通 $LDO$ 的 $PSRR$ 一般在 20dB 左右。$60dB$ 的 $PSRR$ 代表当输入纹波为$1V$ 时，输出纹波将为 $1mV$。

我们先看普通 LDO（XC6206 系列）的纹波抑制曲线：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350563-5f36031e-12a9-473e-81d4-f2491f3784a2.png)

可以看出，在频率为 $1kHz$ 时，`XC6206P302` 的纹波抑制比约为 $23dB$。

再看高速 $LDO$（`XC6217x302`）的纹波抑制曲线：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350633-469a1f37-63ab-4aed-bd4d-d969071cd814.png)

在频率为 $1kHz$ 时，`XC6217x302` 的纹波抑制比约为 $68dB$。

## 电源抑制比（PSRR）的测量方法
![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350701-cf8d20db-3fe4-4f71-9595-fe5cee04697e.png)

电源抑制比（PSRR）的测量分 **输入注入** 和 **输出测量** 两个部分。通过以下方法测试，并记录输入与输出的电压纹波，根据公式即可算出 PSRR 的值。

### 输入注入
#### 信号发生器
使用信号发生器直接产生正弦波，接在 LDO 的输入端。此方法受限于信号发生器的输出电流（像 DG4062 输出电流峰值在 100kHz 正弦波下是 1.65A）。

#### 运算放大器
放大器的作用是将 AC 纹波叠加到直流电源的 DC 电压上。

运放的选择需要满足几个基本条件：

1. 运放带宽满足 LDO 测试范围。
2. 运放最大输出电流不小于 LDO 最大输出电流。
3. 运放输出电压范围覆盖 LDO 输入电压范围。

可按照以下的示意图设计加法器：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350774-31b8aabb-72b2-4d51-93df-96251449e936.png)

其中，R1 与 R2 相等，最低截止频率由 C1 和 R1 共同决定，最高截止频率由运放的带宽所决定。

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350825-045cbb27-42c0-4546-90e6-4a6309bf5ff0.png)

#### 信号发生器 + 运算放大器
使用运放作为信号发生器的电压跟随器，可解除信号发生器驱动电流不足的限制。

#### LC 节点法
利用电感和电容实现 DC 电压和 AC 电压的叠加，一起作为 LDO 的输入：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350920-00de452c-7ee0-4ce5-ad23-ac370517580f.png)

其中，电容 C1 用于防止 VAC 对 VDC 产生高脉冲影响，电感 L1 防止 VDC 使 VAC 发生短路，使用 LC 隔离两个电源

这个电路的最高频率由电感 L1 和电容 C1 共同决定，最低频率由 C1 决定。

#### 音频分析仪（Audio Precision）
音频分析仪自身没有能力产生 DC 直流电压，且驱动能力弱，所以需要通过一个高带宽大电流的运放，把它产生的 AC 纹波叠加到直流电源的 DC 电压上，然后再连接到 LDO 的输入端。但因为音频分析仪带宽的限制，不能测到频率 100kHz 以上的 PSRR。

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494350983-1d662def-5c11-4537-b25a-9eea3d83b69f.png)

#### 专用注入器
此方法需要用到专用的输入注入器（例如 J2120A，带宽 10Hz-10MHz，直流电压最大值为 50V，输出电流最高 5A），它可以把 AC 纹波和直流电源 DC 电压直接叠加，但经过注入器后的输入电压会有所衰减。配合网分仪分别测量输入与输出电压纹波值：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494351050-596caa14-87a7-4e7b-be76-24f83bb37fbf.png)

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494351104-9813e41f-8afc-4239-a094-3dc113b0d126.png)

### 输出测量
#### 示波器
一般的示波器可以测量到毫伏级电压，当 LDO 的 PSRR 不高于 40-50dB 时，如果输入交流电压峰峰值为 1V，那么 LDO 输出中的同频率交流电压峰峰值为 3mV~10mV，可以用示波器直接测量。

示波器不适用于测量高 PSRR 的 LDO，如果输出纹波太小，示波器无法精确测量。

#### 运放 + 示波器
当 LDO 的 PSRR 大于 50dB 时，由于输出纹波幅值通常小于 1mV，无法利用示波器直接测量。这时可以考虑使用运算放大器将 LDO 输出交流电压放大 100 倍甚至更高，在设计运放电路时需要考虑:

+ LDO 输出有直流电压，电路需要将直流电压去掉。
+ 放大电路自身产生的噪声要远小于放大后交流电压。
+ 运放输入失调电压不能太大，否则经放大电路放大后会输出很大的直流电压。
+ 放大电路的带宽需要满足 LDO 的 PSRR 测量频率范围。

放大电路的设计：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494351162-9f693ee9-9d38-4729-9da8-1d102cd1c581.png)

该电路的最低截止频率由 C1 和 R1 所决定，最高截止频率由运放的带宽所决定。

#### 频谱分析仪 / 网分仪
频谱分析仪可以测量微伏级电压信号，可以配合使用高阻抗输入探头来测量 LDO 输出交流电压。如果没有高阻抗探头，可以用运放搭建：

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494351213-666705ed-375c-4bc8-b3ab-e8c01e6f6e4f.png)

## 测量注意事项
1. 测试时应首先使用示波器观察 LDO 输入端交流电压波形是否正常。
2. LDO 电路最好按数据手册，加相应的电容去耦，但使用运放方法测试时，需要去掉 LDO 的输入电容，避免运放不稳定。
3. 如果使用注入器，输出电压有衰减，则电压需要适当增加。
4. LDO 的输出负载不要用电子负载提供，建议用功率电阻。
5. 输出使用接地弹簧探头以降低噪声，如下图。

![](https://cdn.nlark.com/yuque/0/2025/png/43593038/1766494351265-d6583251-bcf2-4efd-a093-d20828dc1e68.png)

## 参考
+ [Reducing high-speed signal chain power supply issues](https://e2e.ti.com/blogs_/b/powerhouse/posts/reducing-high-speed-signal-chain-power-supply-issues)
+ [LDO 基础知识：电源抑制比](https://e2echina.ti.com/blogs_/b/analogwire/posts/ldo)
+ [LDO PSRR Measurement Simplified](https://www.ti.com/lit/an/slaa414a/slaa414a.pdf?ts=1650484764171&ref_url=https%253A%252F%252Fwww.google.com%252F)
+ [LDO 的 PSRR 测量](http://www.3peakic.com.cn/Public/Uploads/files/LDO%E7%9A%84PSRR%E6%B5%8B%E9%87%8F.pdf)
+ [LDO 的 PSRR 测量 · 电子研习社](https://zhuanlan.zhihu.com/p/35112931)
+ [电源抑制比（PSRR）测量](https://www.rohde-schwarz.com.cn/applications/-psrr-application-card_56279-601516.html)
+ [关于 DC-DC 瞬态测试的一些东西 🚧](http://www.oliverkung.top/%e5%85%b3%e4%ba%8edc-dc%e7%9e%ac%e6%80%81%e6%b5%8b%e8%af%95%e7%9a%84%e4%b8%80%e4%ba%9b%e4%b8%9c%e8%a5%bf/)

