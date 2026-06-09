---
tags:
  - 项目/硬件
  - opencode
  - ESP32
  - OLED
  - LED
  - 
aliases:
  - opencode状态显示器
  - 
title: 2、opencode状态显示器
source:
author: WangLei
created: 2026-06-08T11:10:00
modified: 2026-06-08T11:10:00
description: 将 opencode 的工作状态实时显示在 ESP32 的 OLED 屏幕和 LED 上。
draft: false
---

# opencode 状态显示器

将 opencode 的工作状态实时显示在 ESP32 的 OLED 屏幕和 LED 上。

> **ESP32 IP**: 192.168.49.232:8080  
> **WiFi**: C202 / xiaoaojianghu  
> **opencode 版本**: 1.16.2

## 📋 项目概览

| 项目 | 说明 |
|------|------|
| **功能** | opencode 状态 → TCP → ESP32 → OLED 显示文字动画 + LED 灯效 |
| **硬件** | ESP32 + SSD1306 OLED 128×64 + LED |
| **通信** | WiFi TCP (192.168.49.232:8080) |
| **opencode 插件** | ~/.config/opencode/plugins/esp32-status.js |

### 状态对应表

| opencode 事件 | 发送指令 | OLED 显示 | LED 灯效 |
|---|---|---|---|
| 工具执行中 | `"busy"` | Busy + 进度条 | 呼吸灯 |
| AI 思考中 | `"thinking"` | Think + 三点动画 | 呼吸灯 |
| 空闲/完成 | `"off"` | Ready + 圆环 | 闪烁 500ms |
| 出错 | `"error"` | Error! + 闪烁 ✕ | 快闪 200ms |

---

## 📁 文件结构

```
C:\Users\16344\Desktop\状态显示\
└── opencode-light/
    ├── src/
    │   └── main.cpp          ← ESP32 固件 (OLED + LED + TCP)
    ├── include/
    │   └── README
    ├── lib/
    ├── platformio.ini        ← PlatformIO 项目配置
    └── plugin.mjs            ← opencode 插件 (原始版)

C:\Users\16344\.config\opencode\
    ├── plugins/
    │   └── esp32-status.js   ← opencode 插件 (正式版)
    ├── opencode.json         ← opencode 配置
    └── package.json          ← npm 依赖
```

![原始插件位置](700%E7%89%A9%E8%81%94%E7%BD%91/0000assets/2%E3%80%81opencode%E7%8A%B6%E6%80%81%E6%98%BE%E7%A4%BA%E5%99%A8/f2792327fc99e1e79b209892a327d571_MD5.jpg)

![正式插件位置](700%E7%89%A9%E8%81%94%E7%BD%91/0000assets/2%E3%80%81opencode%E7%8A%B6%E6%80%81%E6%98%BE%E7%A4%BA%E5%99%A8/1fbaa32436e6a8d88bec35159d8dee48_MD5.jpg)

---

## 🔌 opencode 插件

### 位置

[正式插件位置](0000assets/2、opencode状态显示器/1fbaa32436e6a8d88bec35159d8dee48_MD5.jpg)

```
~/.config/opencode/plugins/esp32-status.js
```

插件自动加载，无需在 `opencode.json` 中配置。

### 完整代码

```javascript
import net from "net"

export const ESP32StatusPlugin = async () => {
  const HOST = "192.168.49.232"
  const PORT = 8080
  let lastState = ""
  let lastSent = Date.now()
  let sock = null

  const connect = async () => {
    if (sock) { try { sock.destroy() } catch {} }
    sock = new net.Socket()
    sock.setNoDelay(true)
    await new Promise((resolve, reject) => {
      const timer = setTimeout(() => { sock.destroy(new Error("connect timeout")); reject() }, 2000)
      sock.connect(PORT, HOST, () => { clearTimeout(timer); resolve() })
      sock.on("error", () => {})
    })
    sock.on("close", () => { sock = null })
    sock.on("error", () => { sock = null })
  }

  const send = async (state) => {
    if (state === lastState && Date.now() - lastSent < 200) return
    lastState = state
    lastSent = Date.now()
    for (let attempt = 0; attempt < 3; attempt++) {
      try {
        if (!sock) await connect()
        sock.write(state + "\n")
        return
      } catch {
        sock = null
        if (attempt < 2) await new Promise(r => setTimeout(r, 500))
      }
    }
  }

  connect()
  setInterval(() => { try { if (sock) sock.write("ping\n") } catch {} }, 10000)

  return {
    "tool.execute.before": async () => { await send("busy") },
    "tool.execute.after": async () => { await send("thinking") },
    event: async ({ event }) => {
      if (event.type === "session.idle" || event.type === "session.done") {
        await send("off")
      }
      if (event.type === "session.status") {
        const t = event.properties?.status?.type
        if (t === "busy" && (lastState === "off" || lastState === "")) await send("busy")
        else if (t === "idle") await send("off")
        else if (t === "error") await send("error")
        else if (t === "stopped") await send("off")
      }
    },
  }
}
```

### 代码重点解释

| 部分 | 说明 |
|------|------|
| `import net from "net"` | Node.js 内置 TCP 模块，零依赖 |
| `sock.setNoDelay(true)` | 禁用 Nagle 算法，数据包即时发出不等待合并；否则小包可能延迟 200ms |
| **长连接** | 启动时 `connect()` 建立一条 TCP 连接，所有状态变化复用同一条，避免频繁三次握手 |
| **去重** | `send()` 内 200ms 内相同状态不重复发送，防止事件风暴导致 OLED 闪烁 |
| **心跳** | `setInterval` 每 10s 发 `"ping\n"` 保活；插件只管发送不问结果，ESP32 回复 `"pong"` 但不影响流程 |
| **自动重连** | 发送抛异常时 destroy 旧 socket → 新 `connect()`，最多 3 次 × 500ms 间隔 |
| **事件优先级** | `tool.execute.after` → `thinking`；`session.status type=busy` 仅在 `lastState === "off"` 时才响应，防止覆盖前者 |

### 插件开发要点

- 文件放在 `plugins/` 目录自动加载，无需配置
- 必须使用**命名导出** `export const SomeName = async (ctx) => { ... }`
- 插件函数返回 **Hooks 对象**，可注册 `tool`、`event`、`auth` 等钩子
- 依赖 npm 包需要在 `~/.config/opencode/package.json` 中声明

---

## 🌐 TCP 通信协议

插件与 ESP32 之间基于 TCP 的文本协议，每条指令以 `\n` 结尾。

### 指令格式

| 方向 | 报文 | 说明 |
|------|------|------|
| 插件 → ESP32 | `busy\n` | 设置状态为忙碌 |
| 插件 → ESP32 | `thinking\n` | 设置状态为思考中 |
| 插件 → ESP32 | `off\n` | 设置状态为空闲 |
| 插件 → ESP32 | `error\n` | 设置状态为错误 |
| 插件 → ESP32 | `ping\n` | 心跳保活 |
| ESP32 → 插件 | `pong\n` | 心跳回复 |
| ESP32 → 插件 | `ok busy\n` | 状态设置成功，返回当前状态 |
| ESP32 → 插件 | `error unknown\n` | 无法识别的指令 |

### 报文长度限制

- ESP32 端 `line.length() < 64`：单条指令超过 64 字符丢弃，防止内存溢出
- 缓冲区是局部 `String line`，无数据时 `available() == 0` 不累加

### 为什么用 `\n` 做分隔符

- 纯文本可读性好，telnet 可直接调试
- JSON 行首需要解码才能识别，文本命令可直接 `==` 比较
- `normalizeCommand()` 额外兼容 `{"state":"busy"}` 格式以防万一

### 心跳机制详解

```
插件                              ESP32
 │                                  │
 ├── 启动 connect() ──────────────→ │
 │                                  │
 ├── 10s 后 send("ping\n") ───────→ │
 │                                  ├── socket 存活，回复 "pong\n"
 │ ←── "pong\n" ──────────────────│
 │                                  │
 ├── 又一个 10s 后 send("ping\n") → │
 │                                  ├── socket 存活，回复 "pong\n"
 │ ←── "pong\n" ──────────────────│
 │                                  │
 │ (如果 ESP32 断电重启，socket 断开)    │
 │                                  │
 ├── send("busy\n") ──────────────× │  ← 连接已断开
 │                                  │
 ├── catch → destroy() → connect() │
 ├── 重连成功 ────────────────────→ │
 └── send("busy\n") ──────────────→ │
```

| 为什么用 10s 而不是更短/更长 | 说明 |
|---|---|
| < 5s | 太频繁，LED 灯会受干扰（ESP32 loop 里每 15ms 更新一次 LED，ping 在 handleClient 里处理，不会阻塞，但 wifi 发包耗电） |
| 10s | 足够短以通过家宽 NAT 超时（通常 30-60s），也不会被 ESP32 TCP 栈自动回收 |
| > 30s | 路由器 NAT 表项可能过期，连接静默断开 |
| 不用 TCP keepalive | Node.js 默认开启，但 2h 超时太长；应用层心跳更可控 |

### 为什么不用短连接

早期版本用短连接（每次 send 创建新 Socket），遇到 **ESP32 卡死** 问题：

```
插件 send("busy")
  → new Socket → connect → write → destroy
  → ESP32 handleClient() 里 while(client.connected()) 循环
  → 插件 destroy 后 ESP32 端 client.connected() 可能仍为 true（TCP FIN 未送达）
  → handleClient 不退出
  → 下次 server.available() 拿不到新 client
  → ESP32 彻底失联
```

长连接 + 心跳 避免了此问题：连接持续存在，无需反复 accept。

### 关于 `setNoDelay(true)`

- Nagle 算法：TCP 把小包攒到一定大小再发，减少小包数量
- 但状态变化需要**即时**显示，延迟 200ms 会让 OLED 响应变慢
- `setNoDelay(true)` 关闭 Nagle，每个 `write()` 立即推送
- 代价：网络小包增多（每条指令约 6-10 字节 + TCP/IP 头 40 字节），但在局域网内可忽略

---

## 📦 PlatformIO 配置

```ini
[env:esp32dev]
platform = espressif32
board = esp32dev
framework = arduino
lib_deps =
    adafruit/Adafruit SSD1306@^2.5.7
    adafruit/Adafruit GFX Library@^1.11.9
monitor_speed = 115200
upload_speed = 921600
```

| 参数 | 说明 |
|------|------|
| `board = esp32dev` | ESP32 DevKit V1（通用开发板） |
| `framework = arduino` | Arduino 框架，非 ESP-IDF |
| `Adafruit SSD1306` | OLED 驱动库，依赖 Wire(I2C) |
| `Adafruit GFX` | 图形原语库：画圆、画线、填充等 |
| `upload_speed = 921600` | 高速烧录，需要稳定 USB 线 |

---

## 📟 ESP32 固件 (src/main.cpp)

### 完整代码 (src/main.cpp)

```cpp
#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define OLED_RESET -1

#define LED_pin 2

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

#include <WiFi.h>

const char* WIFI_SSID = "C202";
const char* WIFI_PASSWORD = "xiaoaojianghu";
const uint16_t TCP_PORT = 8080;
WiFiServer server(TCP_PORT);

String currentState = "off";
char stateText[16] = "Ready";
unsigned long lastAnimMs = 0;
int frame = 0;
bool blinkOn = true;
IPAddress localIP;

// LED control
int ledBrightness = 0;
int ledStep = 2;
unsigned long lastLedMs = 0;

void setStateText(const String &s) {
  if (s == "thinking") strcpy(stateText, "Think");
  else if (s == "busy") strcpy(stateText, "Busy");
  else if (s == "success") strcpy(stateText, "Done");
  else if (s == "error") strcpy(stateText, "Error!");
  else if (s == "alarm") strcpy(stateText, "Alert!");
  else strcpy(stateText, "Ready");
}

void updateAnim() {
  unsigned long now = millis();
  int rate = (currentState == "thinking") ? 250 :
             (currentState == "busy") ? 100 :
             (currentState == "error") ? 200 :
             (currentState == "alarm") ? 300 : 500;
  if (now - lastAnimMs < rate) return;
  lastAnimMs = now;
  frame++;
  blinkOn = (frame % 2 == 0);
}

void drawDisplay() {
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(28, 2);
  display.print("OpenCode");
  display.drawFastHLine(4, 14, 120, SSD1306_WHITE);

  int cx = 64, cy = 28;

  if (currentState == "thinking") {
    for (int i = 0; i < 3; i++) {
      int r = (i == frame % 3) ? 6 : 3;
      display.fillCircle(cx - 16 + i * 16, cy, r, SSD1306_WHITE);
    }
  } else if (currentState == "busy") {
    display.drawRect(cx - 20, cy - 4, 40, 8, SSD1306_WHITE);
    int fw = ((frame % 20) + 1) * 38 / 20;
    display.fillRect(cx - 19, cy - 3, fw, 6, SSD1306_WHITE);
  } else if (currentState == "success") {
    display.fillCircle(cx, cy, 14, SSD1306_WHITE);
    display.fillCircle(cx, cy, 10, SSD1306_BLACK);
    display.drawLine(cx - 6, cy, cx - 2, cy + 5, SSD1306_WHITE);
    display.drawLine(cx - 2, cy + 5, cx + 6, cy - 5, SSD1306_WHITE);
  } else if (currentState == "error") {
    if (blinkOn) {
      display.fillCircle(cx, cy, 14, SSD1306_WHITE);
      display.fillCircle(cx, cy, 10, SSD1306_BLACK);
      display.drawLine(cx - 6, cy - 6, cx + 6, cy + 6, SSD1306_WHITE);
      display.drawLine(cx + 6, cy - 6, cx - 6, cy + 6, SSD1306_WHITE);
    }
  } else if (currentState == "alarm") {
    if (blinkOn) {
      display.fillTriangle(cx, cy - 12, cx - 12, cy + 8, cx + 12, cy + 8, SSD1306_WHITE);
      display.fillRect(cx - 3, cy + 2, 6, 6, SSD1306_BLACK);
      display.fillRect(cx - 2, cy - 5, 4, 5, SSD1306_WHITE);
      display.fillRect(cx - 2, cy + 2, 4, 1, SSD1306_WHITE);
    }
  } else {
    display.drawCircle(cx, cy, 8, SSD1306_WHITE);
  }

  int textLen = strlen(stateText);
  int textW = textLen * 12;
  display.setTextSize(2);
  display.setCursor((128 - textW) / 2, 48);
  display.print(stateText);
  display.display();
}

String normalizeCommand(String cmd) {
  cmd.trim();
  cmd.toLowerCase();
  if (cmd.startsWith("state ")) cmd = cmd.substring(6);
  int js = cmd.indexOf("\"state\"");
  if (js >= 0) {
    int c = cmd.indexOf(':', js);
    int q1 = cmd.indexOf('"', c + 1);
    int q2 = cmd.indexOf('"', q1 + 1);
    if (c >= 0 && q1 >= 0 && q2 > q1) { cmd = cmd.substring(q1 + 1, q2); cmd.trim(); }
  }
  return cmd;
}

bool applyCommand(String cmd) {
  cmd = normalizeCommand(cmd);
  if (cmd == "thinking") { currentState = "thinking"; setStateText("thinking"); return true; }
  if (cmd == "busy") { currentState = "busy"; setStateText("busy"); return true; }
  if (cmd == "success") { currentState = "success"; setStateText("success"); return true; }
  if (cmd == "error") { currentState = "error"; setStateText("error"); return true; }
  if (cmd == "alarm") { currentState = "alarm"; setStateText("alarm"); return true; }
  if (cmd == "off" || cmd == "ready") { currentState = "off"; setStateText("off"); return true; }
  if (cmd == "ready") { currentState = "off"; setStateText("ready"); return true; }  return false;
}

void updateLED() {
  unsigned long now = millis();
  if (now - lastLedMs < 15) return;
  lastLedMs = now;

  if (currentState == "off") {
    analogWrite(LED_pin, (now / 500) % 2 == 0 ? 255 : 0);
  } else if (currentState == "busy" || currentState == "thinking") {
    ledBrightness += ledStep;
    if (ledBrightness >= 255 || ledBrightness <= 0) ledStep = -ledStep;
    analogWrite(LED_pin, ledBrightness);
  } else if (currentState == "error") {
    analogWrite(LED_pin, (now / 200) % 2 == 0 ? 255 : 0);
  } else {
    analogWrite(LED_pin, 0);
  }
}

void safePrint(WiFiClient &c, const String &s) {
  if (c.connected()) c.print(s);
}

void safePrintln(WiFiClient &c, const String &s) {
  if (c.connected()) c.println(s);
}

void handleClient(WiFiClient &client) {
  safePrintln(client, "OpenCode OLED ready");
  String line;
  while (client.connected()) {
    updateAnim();
    drawDisplay();
    updateLED();
    while (client.available()) {
      char c = client.read();
      if (c == '\n' || c == '\r') {
        line.trim();
        if (line.length() > 0) {
          if (line.equalsIgnoreCase("ping")) safePrintln(client, "pong");
          else if (applyCommand(line)) { safePrint(client, "ok "); safePrintln(client, currentState); }
          else { safePrint(client, "error "); safePrintln(client, line); }
        }
        line = "";
      } else if (line.length() < 64) line += c;
    }
    delay(5);
  }
}

void setup() {

  pinMode(LED_pin,OUTPUT);

  Serial.begin(115200);
  delay(300);

  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println("OLED not found");
    for (;;);
  }
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(32, 24);
  display.print("OpenCode");
  display.setCursor(24, 40);
  display.print("Connecting...");
  display.display();

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(300);
    Serial.print(".");
  }

  localIP = WiFi.localIP();
  Serial.print("\nIP: ");
  Serial.println(localIP);
  server.begin();
  currentState = "off";
  setStateText("ready");
  drawDisplay();
}

void loop() {
  WiFiClient client = server.available();
  if (client) handleClient(client);
  updateAnim();
  drawDisplay();
  updateLED();
  delay(5);
}
```

### 代码重点解释

| 部分 | 说明 |
|------|------|
| `normalizeCommand()` | 先 `trim()` 去首尾空白，再 `toLowerCase()` 转小写；兼容 `"state busy"` 前缀和 `{"state":"busy"}` JSON 格式，确保各种来源的指令都能识别 |
| `applyCommand()` | match 关键词 → 改 `currentState` + `setStateText()`；`off` 和 `ready` 均映射到 `"off"` 状态 |
| `drawDisplay()` | 每种状态独立绘制；`thinking` 三点动画用 `frame % 3` 循环大中小圆；`busy` 进度条用 `(frame % 20) * 38 / 20` 循环 0-19 帧；`error` 用 `blinkOn` 控制交替显示/清空 |
| `updateAnim()` | 帧率：busy=100ms, thinking=250ms, off=500ms, error=200ms；`frame` 无上限递增永不溢出（`int` 溢出后变负，但 `%` 仍可正常取模） |
| `updateLED()` | 每 15ms 刷新一次；off 闪烁用 `(now/500)%2` 无状态切换；呼吸灯用 `ledBrightness ±= ledStep` 实现三角波；error 用 `(now/200)%2` 快闪 |
| `handleClient()` | `while(client.connected())` 循环内持续接收指令；`client.available()` 无数据时 `delay(5)` 防止 watchdog 触发；单行缓冲 `< 64` 防溢出 |
| `server.available()` | 每次 `loop()` 检查是否有新连接；**只 accept 一次**，因为 handleClient 是阻塞循环，断开后才返回 loop 继续 accept |
| `strcpy(stateText, ...)` | 用 `char[16]` 固定数组而非 `String`，避免堆碎片（ESP32 长期运行 String 频繁 new/delete 会导致堆碎片化和随机重启） |
| `safePrint()` / `safePrintln()` | 先检查 `client.connected()` 再 `print()`，防止向已断开的连接写数据导致异常 |
| `delay(5)` | 双重作用：① 释放 CPU 给 WiFi 协议栈和 Arduino 后台任务；② 避免 `loop()` 空转导致 ESP32 看门狗复位 |
| `analogWrite()` | ESP32 上实际映射到 LEDC PWM 外设，频率默认 5kHz，分辨率 8bit(`0-255`) |
| `line.length() < 64` | 缓冲区溢出防护；异常数据（如二进制流）超过 64 字符直接丢弃，保证单条指令不会被截断解析 |
| `frame` 不重置 | `frame` 自 setup 后一直递增，永不手动归零；各状态的动画靠 `%` 取模，循环在各自周期内，切换状态时动画无缝衔接 |
| `blinkOn = (frame % 2 == 0)` | 每两帧切换一次闪烁状态，让 `error` 和 `off` 状态复用同一个拍子 |

---

## 🔄 完整通讯流程

```
opencode 会话开始
    │
    ├── session.status type=busy  ──→ send("busy") ──→ OLED: Busy+进度条, LED: 呼吸灯
    │
    ├── tool.execute.before       ──→ send("busy")  (去重跳过，已在 busy)
    │
    ├── tool.execute.after        ──→ send("thinking") ──→ OLED: Think+三点, LED: 呼吸灯
    │
    ├── (AI 生成中, 可能有多次 tool.execute)
    │
    ├── session.status type=idle  ──→ send("off")  ──→ OLED: Ready+圆环, LED: 闪烁500ms
    │
    └── (空闲状态，每 10s 发送 ping 保活)

                                    ┌─────────────┐
                                    │ 插件 side    │
                                    │ 长连接 sock  │
                                    │ 10s ping     │
                                    │ 3次重连      │
                                    └──────┬──────┘
                                           │ TCP
                                    ┌──────┴──────┐
                                    │ ESP32 side   │
                                    │ server.avail │
                                    │ handleClient │
                                    │ 15ms LED     │
                                    │ 帧动画       │
                                    └─────────────┘
```

---

## 🔧 硬件接线

| ESP32 引脚 | 连接 |
|---|---|
| GPIO21 (SDA) | OLED SDA |
| GPIO22 (SCL) | OLED SCL |
| GPIO2 | LED 正极（串联 220Ω 电阻） |
| GND | OLED GND + LED 负极 |
| 3.3V | OLED VCC |

> ⚠️ 注意：OLED 供电用 3.3V，不要接 5V。LED 必须串联电阻。

---

## 🚀 使用流程

1. **烧录 ESP32**
   - 用 VS Code + PlatformIO 打开 `opencode-light` 项目
   - PlatformIO 会自动从 `platformio.ini` 的 `lib_deps` 下载依赖库
   - 编译上传 (`pio run -t upload` 或点 → 箭头按钮)
   - 首次烧录可能需要按住 BOOT 键

2. **安装插件**
   - 将 `esp32-status.js` 放入 `~/.config/opencode/plugins/`
   - 插件无需在 `opencode.json` 中注册，`plugins/` 目录自动扫描
   - 启动 opencode，观察终端是否有 ESP32 连接日志

3. **正常使用**
   - opencode 工作时 OLED 自动更新动画
   - 如果不显示，检查 ESP32 串口输出：`IP: 192.168.49.232`
   - 用 telnet 测试：`telnet 192.168.49.232 8080` 手动发 `busy` / `off`

---

## 🐛 踩坑记录

### 1. opencode 启动卡死
- **现象**：把普通 `.js` 文件扔进 `plugins/` 目录，opencode 启动时卡在加载页面
- **原因**：插件文件必须遵循 opencode 插件 API（导出 `export const Xxx = async (ctx) => { ... }`）
- **解决**：重写为标准插件格式，使用命名导出和 Hooks 对象

### 2. session.status 找不到状态数据
- **现象**：`event.data?.status` 始终为空
- **原因**：状态数据在 `event.properties?.status?.type` 里，不是 `event.data`
- **解决**：改用 `event.properties?.status?.type`

### 3. OLED 卡死在 "Thinking"
- **现象**：长对话时 OLED 停在 Thinking 不恢复
- **原因**：`session.status type=busy` 频繁触发，覆盖了 `tool.execute.after` 发的 `thinking`
- **解决**：在 `session.status type=busy` 事件中加条件 `(lastState === "off" || lastState === "")`，只在空闲时响应

### 4. 短对话无反应
- **现象**：问 "你好" 这种快速回答，OLED 全程不动
- **原因**：没有工具调用，`tool.execute.before/after` 不触发
- **解决**：监听 `session.status type=busy`，会话一忙就发信号

### 5. 重启 ESP32 后只能用一次
- **现象**：ESP32 重启后工作一个循环，之后 OLED 再也不更新
- **原因**：每次 `send()` 创建短连接，ESP32 的 `while(client.connected())` 在客户端断开后不退出，卡在第一个连接上
- **解决**：
  - 方法 A（原始方案）：改用**长连接**，启动时连一次，所有命令走同一连接
  - 方法 B（简化方案）：`sock.setTimeout(150)` 改成新的 Socket 连接方式，配合 `sock.destroy()` 超时退出
  - 最终采用 **长连接 + 心跳** 方案

### 6. 长连接自动断开 (心跳引入)
- **现象**：长时间空闲后，状态无法更新
- **原因**：ESP32 或网络设备空闲超时断开 TCP 连接
- **解决**：`setInterval` 每 10s 发 `"ping\n"` 保活；ESP32 端 `line.equalsIgnoreCase("ping")` 回复 `"pong"`，不改变状态

### 7. 心跳回复 pong 被当作指令
- **现象**：无
- **原因**：出现之前担心 `"pong"` 字符串被 `applyCommand()` 匹配到错误状态
- **解决分析**：ESP32 端 `handleClient()` 的指令解析是先判断 `"ping"` → 回复 `"pong"`，再 `applyCommand()` → 不匹配任何关键词 → 回复 `"error unknown"`。pong 被客户端丢弃（插件端不读响应数据），所以不会造成问题

### 8. 200ms 去重导致状态跳变
- **现象**：Busy → Thinking 快速切换时丢状态
- **原因**：`session.status type=busy` 在 `tool.execute.after` 后 2ms 内触发，去重判断 `lastState === "busy" && time < 200` 跳过了
- **解决**：只在 `lastState === "off"` 时才从 `session.status` 发 busy

### 9. 心跳时间太长导致虚假重连
- **现象**：无（潜在问题）
- **原因**：`setInterval` 只管每 10s 发 ping，**不检查**上次 ping 是否有回复。如果网络中断但 socket 未触发 `close/error` 事件，ping 会一直静默失败而插件不知
- **解决**：插件端不需要检测——因为下次 `send(state)` 时 `sock.write()` 会抛异常触发自动重连。即：ping 只保活，不做健康检查

### 10. ESP32 看门狗复位
- **现象**：ESP32 运行一段时间后自动重启
- **原因**：`loop()` 和 `handleClient()` 中的 `while(client.connected())` 是纯轮询，没有 `delay()` 或 `yield()`，Arduino 后台任务（WiFi 协议栈、TCP 栈）得不到 CPU 时间
- **解决**：每轮循环加 `delay(5)`：① 释放 CPU 给后台任务；② 5ms 足够低不影响 LED 15ms 刷新率；③ 所有循环（loop + handleClient + drawDisplay + updateLED）内都有 delay

### 11. String 类型堆碎片
- **现象**：ESP32 运行几小时后随机崩溃（watchdog 或 panic）
- **原因**：`String line` 在 `handleClient` 内反复 `+=` 和 `=""`，ESP32 堆内存碎片化
- **解决**：加 `line.reserve(64)` 预分配缓冲区（当前代码未加，是潜在风险）；`line.length() < 64` 限制最大长度；未来可改用 `char buf[64]` + 索引彻底避免堆操作

---

## 💡 项目扩展思路

### 集成 STM32F407
- ESP32 做主控通信 + 显示
- STM32F407 做传感器采集、电机控制（利用 FPU + DSP）
- 通信：UART 或 SPI 直连

### 更多 LED 效果
- 使用 RGB LED (WS2812) 替换单色 LED：
  - Ready → 绿色呼吸
  - Busy → 蓝色呼吸
  - Error → 红色闪烁

### 其他显示设备
- 替换 OLED 为 ILI9341 TFT 彩屏（SPI 接口）
- 显示更多信息：当前模型、响应耗时、Token 用量

---

## 📚 参考资料

- [opencode 插件文档](https://opencode.ai/docs/plugins/)
- [@opencode-ai/plugin SDK](https://opencode.ai/docs/sdk/)
- [Adafruit SSD1306 库](https://github.com/adafruit/Adafruit_SSD1306)
- [ESP32 Arduino 文档](https://docs.espressif.com/projects/arduino-esp32/)
