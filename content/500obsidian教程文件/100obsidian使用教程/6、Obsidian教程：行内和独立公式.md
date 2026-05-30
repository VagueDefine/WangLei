---
title: 6、Obsidian教程：行内和独立公式
source:
author: WangLI
created: 2026-05-30-星期六
description:
tags:
  - obsidian教程
  - 博客
aliases:
  - 行内和独立公式
draft: false
---
### 1、行内公式

如果你想让公式跟文字在同一行，应该用单个 `$` 包裹，写法为：
```
$A=B+C$
```

### 2、独立公式
对于markdown来说，独立公式应当为独立的**块级公式**
```
$$Z=R+1/(j\omega C)+j\omega L=R+j[\omega L-1/(\omega C)]\tag{1}$$
```
**这个写法本身是对的**，但问题出在「位置」上。并不是块级公式，在quartz渲染后独立公式不能居中
	![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/6%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9A%E8%A1%8C%E5%86%85%E5%92%8C%E7%8B%AC%E7%AB%8B%E5%85%AC%E5%BC%8F/b7874e207ce25a3389306c07354e19be_MD5.jpg)
#### 正确的两种用法：
- **独立居中公式（推荐，就是你想要的效果）**
    公式必须单独占一行，前后换行：
    ```
    $$
    Z=R+1/(j\omega C)+j\omega L=R+j\left[\omega L-\frac{1}{\omega C}\right] \tag{1}
    $$
    ```
    这样渲染后，公式会自动居中，编号也会跑到右边
    ![](100obsidian%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B/0000assets/6%E3%80%81Obsidian%E6%95%99%E7%A8%8B%EF%BC%9A%E8%A1%8C%E5%86%85%E5%92%8C%E7%8B%AC%E7%AB%8B%E5%85%AC%E5%BC%8F/a3a13697219cee774ec2947b0f88173b_MD5.jpg)
- **行内公式（跟文字走，不居中）**
    
    如果你想让公式跟文字在同一行，应该用单个 `$` 包裹：

    ```
    电路的阻抗为 $Z=R+1/(j\omega C)+j\omega L$，如式(1)所示。
    ```
    

### 2. 为什么你的 CSS 没生效？

你之前写的 CSS：

```custom.scss
mjx-container[display="true"] {
  display: block !important;
  margin: 1.5rem auto !important;
  text-align: center !important;
}
```

这个规则只对「被 MathJax 识别为块级公式（带 `display="true"` 属性）」的元素生效。

但你现在的情况：

- 公式写在 Obsidian 行内，即使你用了 `$$`，渲染后 MathJax 可能不会给它加上 `display="true"` 属性；
- 没有这个属性，你的 CSS 规则就匹配不上，自然不会居中。