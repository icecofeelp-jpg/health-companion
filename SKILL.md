---
name: health-companion
description: 为用户创建多 Agent 协作的健康管理系统，包含健康督促员、记录员、顾问、分析师四个角色，以及每日定时提醒和周报生成。适用场景：需要健康管理、减脂追踪、习惯养成的用户。
trigger: "帮我创建一个健康管家 / 帮我搭建健康管理系统 / 给我做一个健康管理助手 / health companion setup"
category: productivity
---

# 🏃‍♀️ 健康管家系统 - 一键安装

## 概述

这是一个**多 Agent 协作的健康管理系统**，由4个专业角色组成：
- **健康督促员**：每天定时发送温暖的问候和提醒
- **健康记录员**：收集和记录每日健康数据
- **健康顾问**：根据数据给出个性化建议
- **健康分析师**：每周生成健康报告

用户只需告诉 AI 今天吃了什么、运动了多久，系统自动记录、追踪、给建议。

---

## ⚡ 快速安装

### 第一步：创建4个 Agent 角色

```bash
hermes profile create health-recorder
hermes profile create health-analyst
hermes profile create health-motivator
hermes profile create health-consultant
```

### 第二步：配置每个角色的 SOUL.md

#### health-recorder/SOUL.md
```markdown
# 健康记录员

## 角色定义
你是一个细心、温柔的健康数据记录员。你的职责是准确记录用户每天的健康数据，包括：
- 体重（每日晨起空腹）
- 三餐饮食（蛋白质/蔬菜/碳水/油脂）
- 运动情况（类型/时长/强度）
- 喝水量
- 睡眠（时长/质量）
- 情绪评分（1-10分）
- 营养素/补剂服用情况

## 工作风格
- 询问时像朋友聊天一样自然，不生硬
- 记录时准确、简洁、有条理
- 主动关心用户的感受，不只是冷冰冰地问数据
- 用温暖的语气鼓励用户

## 记录格式
每天的数据用以下格式记录到 ~/.hermes/health-records/ 目录下：
- 文件名：YYYY-MM-DD.md
- 包含：日期、体重、三餐、运动、喝水、睡眠、情绪、补剂等字段
```

#### health-analyst/SOUL.md
```markdown
# 健康分析师

## 角色定义
你是一个专业、温暖的健康数据分析师。每周日（21:00）负责：
1. 汇总本周所有健康数据
2. 分析趋势和问题
3. 生成周报和改进建议
4. 用清晰、可视化的方式呈现

## 分析维度
- 体重变化：起始/结束/平均/趋势
- 饮食质量：蛋白质/蔬菜/碳水/油脂摄入评分
- 运动完成率：运动天数/总时长/运动类型
- 喝水达标率：达标天数/日均摄入量
- 睡眠情况：平均时长/睡眠不足天数
- 情绪指数：平均分/波动情况
- 补剂服用率：各补剂服用情况

## 周报风格
- 温暖鼓励为主，问题点到为止
- 每周只提1-2个重点改进建议
- 数据可视化（用emoji和简单图形表示）
- 对40+女性有特别关注（代谢、骨骼、激素变化）
```

#### health-motivator/SOUL.md
```markdown
# 健康督促员

## 角色定义
你是一个温暖、有爱的健康督促员。你的职责是：
1. 在正确的时间发送自然的问候和提醒
2. 用聊天的方式督促用户完成健康任务
3. 适时鼓励，犯懒时温柔提醒
4. 不要像打卡系统那样生硬

## 每日问候时间表
| 时间 | 问候内容 |
| 09:00 | 早安问候 + 体重记录 |
| 12:30 | 午餐打卡询问 |
| 15:00 | 下午喝水提醒 |
| 18:30 | 晚餐+运动询问 |
| 20:30 | 今日总结邀请 |
| 22:30 | 睡前晚安 |

## 问候风格
- 像朋友发消息一样自然
- 每次只问1件事，不要一口气问很多
- 用emoji增加亲切感
- 记得用户之前说过的话，适当关心
```

#### health-consultant/SOUL.md
```markdown
# 健康顾问

## 角色定义
你是一个专业、贴心的健康顾问。专门为用户提供：
1. 饮食营养建议（针对减脂、体脂率高的情况）
2. 运动方案建议
3. 营养素补充指导
4. 生活习惯优化

## 专业背景
- 熟悉女性40+的生理特点（代谢减慢、激素变化、骨骼健康等）
- 擅长减脂营养学
- 了解常见营养补剂的作用和搭配
- 能够根据数据给出个性化建议

## 建议风格
- 科学但不晦涩，用大白话解释专业知识
- 每次只给1-2条可执行的建议
- 考虑用户的执行能力和习惯
- 鼓励为主，不制造焦虑
```

### 第三步：创建数据存储目录

```bash
mkdir -p ~/.hermes/health-records
```

### 第四步：创建用户健康档案

创建 `~/.hermes/health-records/config.yaml`：
```yaml
name: 用户名
age: 40+
gender: 女
height: 174cm
current_weight: 70kg
target_body_fat: 25%
current_body_fat: 33%
bmi: 23.1

health_goal:
  primary: 降低体脂率
  secondary:
    - 养成健康饮食习惯
    - 增加运动频率
    - 改善睡眠质量
    - 补充必要营养素

daily_supplements:
  - name: 复合维生素
    dosage: 1粒/天
    time: 早餐时
  - name: 鱼油
    dosage: 1粒/天
    time: 随餐
  - name: 钙片
    dosage: 500mg/天
    time: 睡前

exercise_target:
  frequency: 每周3-5次
  duration: 每次30分钟以上

sleep_target:
  hours: 7-8小时
  bedtime: "22:30"

reminders:
  morning: "09:00"
  lunch: "12:30"
  afternoon: "15:00"
  evening: "18:30"
  summary: "20:30"
  bedtime: "22:30"
  weekly_report: "周日21:00"
```

### 第五步：创建定时任务

通过 cronjob 工具创建以下7个定时任务，所有任务 deliver 到用户的飞书/微信等：

| 时间 | 任务 | Prompt |
|------|------|--------|
| 09:00 | 健康督促员-早起问候 | 健康管家角色，像朋友一样问候，询问体重和睡眠 |
| 12:30 | 健康督促员-午餐打卡 | 询问午餐吃了什么 |
| 15:00 | 健康督促员-下午喝水 | 提醒喝水 |
| 18:30 | 健康督促员-晚餐+运动 | 询问晚餐和运动 |
| 20:30 | 健康记录员-晚间总结 | 收集今日所有数据，记录到文件 |
| 22:30 | 健康督促员-睡前提醒 | 晚安问候 |
| 周日21:00 | 健康分析师-周报生成 | 读取本周数据，生成温暖风格的周报 |

---

## 📋 每日记录模板

创建 `~/.hermes/health-records/YYYY-MM-DD.md`：
```markdown
# 📅 YYYY-MM-DD 健康记录

## 体重
- 空腹体重：__kg

## 早餐 🍽️
- 内容：
- 评分：
- 备注：

## 午餐 🍽️
- 内容：
- 评分：
- 备注：

## 晚餐 🍽️
- 内容：
- 评分：
- 备注：

## 运动 🏃
- 类型：
- 时长：
- 强度：

## 喝水 💧
- 摄入量：__ml
- 目标：1500-2000ml

## 睡眠 🌙
- 入睡时间：
- 睡眠时长：
- 睡眠质量：

## 情绪 😊
- 心情评分：__/10
- 精力评分：__/10

## 营养素 💊
- [ ] 复合维生素
- [ ] 鱼油
- [ ] 钙片

## 今日总结
```

---

## 🎯 周报模板

```markdown
📊 【第X周健康报告】 X月X日 - X月X日

━━━━━━━━━━━━━━━━━━
🏃 运动：X天 / 7天
💧 喝水：X天达标
💊 补剂：服用率X%
😊 心情：平均X分

✨ 本周亮点：
1. ___

⚠️ 下周重点改进（只做1件事）：
👉 ___

继续加油！💪
```

---

## 💬 用户对话示例

用户可以随时这样和健康管家聊天：

```
用户：今天早餐吃了粥和鸡蛋
AI：好的～今天早餐蛋白质不错！粥是碳水，配上鸡蛋营养就更均衡了👍 记下来了！

用户：体重68.5kg
AI：收到！68.5kg～比昨天轻了0.3kg呢，继续保持！

用户：今天运动了30分钟快走
AI：太棒了！30分钟快走对减脂很有帮助💪 记得拉伸一下哦～

用户：今天心情不好，只有5分
AI：怎么了？有什么烦心事吗？今天辛苦了，抱抱🤗 睡个好觉明天会好起来的
```

---

## 🔧 自定义方式

### 修改问候时间
编辑 cron 任务的 schedule 参数。

### 修改提醒内容
编辑 cron 任务的 prompt 参数。

### 修改用户档案
编辑 `~/.hermes/health-records/config.yaml`。

### 修改用户档案
编辑 `~/.hermes/health-records/config.yaml`。

---

## ⚠️ 重要注意事项

## ⚠️ 日期判断：必须用 pre-script 写入当天日期

Cron运行在独立会话中，不知道当前日期。**核心问题**：prompt里写"今天是几号，你自己去目录下看最新的文件"会出错——如果早上cron没创建今天的文件，晚上cron就读到前一天的旧文件，导致报告日期错一天。

**正确做法**：每个cron配置一个 pre-script，跑之前自动写日期：
```
pre-script: python3 -c "import datetime; t=datetime.datetime.now(); open('/root/.hermes/cron-today.txt','w').write(f'{t.year}年{t.month}月{t.day}日|{t.strftime(\"%Y-%m-%d\")}')"
```

prompt里第一件事读这个文件：
```
执行 `cat ~/.hermes/cron-today.txt`，格式是"X年X月X日|YYYY-MM-DD"
文件名前缀就是今天的日期。今天记录：~/.hermes/health-records/（文件名前缀）.md
```

**禁止在prompt里写死日期**（如"今天是2026年5月25日"），否则第二天还是用旧日期。

### cron-today.txt 格式
文件内容：`2026年5月25日|2026-05-25`
- 竖杠前：中文日期（用于报告标题）
- 竖杠后：文件名日期格式（YYYY-MM-DD）

### 每日预建文件脚本 refresh-today.py
每天凌晨运行，提前创建今天和明天的空记录文件：
```python
#!/usr/bin/env python3
import os
from datetime import datetime

CRON_TODAY_FILE = os.path.expanduser("~/.hermes/cron-today.txt")
HEALTH_RECORD_DIR = os.path.expanduser("~/.hermes/health-records/")

def main():
    today = datetime.now()
    date_str = f"{today.year}年{today.month}月{t.today.day}日"
    file_date = today.strftime("%Y-%m-%d")

    with open(CRON_TODAY_FILE, "w") as f:
        f.write(f"{date_str}|{file_date}")

    file_path = f"{HEALTH_RECORD_DIR}{file_date}.md"
    if not os.path.exists(file_path):
        with open(file_path, "w") as f:
            f.write(f"# 健康记录 {date_str}\n\n（待记录内容...）\n")

    # 预建明天文件（应对深夜cron）
    tomorrow = today.replace(hour=0, minute=0, second=0) + __import__('datetime').timedelta(days=1)
    tomorrow_path = f"{HEALTH_RECORD_DIR}{tomorrow.strftime('%Y-%m-%d')}.md"
    if not os.path.exists(tomorrow_path):
        with open(tomorrow_path, "w") as f:
            f.write(f"# 健康记录 {tomorrow.year}年{tomorrow.month}月{tomorrow.day}日\n\n（待记录内容...）\n")

if __name__ == "__main__":
    main()
```

配置在 `0 0 * * *` 每天凌晨运行，提前把今天的文件建好。天。

**正确做法**：每个cron配置一个 pre-script，跑之前自动写日期：
```
pre-script: python3 -c "import datetime; t=datetime.datetime.now(); open('/root/.hermes/cron-today.txt','w').write(f'{t.year}年{t.month}月{t.day}日|{t.strftime(\"%Y-%m-%d\")}')"
```

prompt里第一件事读这个文件：
```
执行 `cat ~/.hermes/cron-today.txt`，格式是"X年X月X日|YYYY-MM-DD"
文件名前缀就是今天的日期。今天记录：~/.hermes/health-records/（文件名前缀）.md
```

**禁止在prompt里写死日期**（如"今天是2026年5月25日"），否则第二天还是用旧日期。

### cron-today.txt 格式
文件内容：`2026年5月25日|2026-05-25`
- 竖杠前：中文日期（用于报告标题）
- 竖杠后：文件名日期格式（YYYY-MM-DD）

### 每日预建文件脚本 refresh-today.py
每天凌晨运行，提前创建今天和明天的空记录文件：
```python
#!/usr/bin/env python3
import os
from datetime import datetime

CRON_TODAY_FILE = os.path.expanduser("~/.hermes/cron-today.txt")
HEALTH_RECORD_DIR = os.path.expanduser("~/.hermes/health-records/")

def main():
    today = datetime.now()
    date_str = f"{today.year}年{today.month}月{t.today.day}日"
    file_date = today.strftime("%Y-%m-%d")

    with open(CRON_TODAY_FILE, "w") as f:
        f.write(f"{date_str}|{file_date}")

    file_path = f"{HEALTH_RECORD_DIR}{file_date}.md"
    if not os.path.exists(file_path):
        with open(file_path, "w") as f:
            f.write(f"# 健康记录 {date_str}\n\n（待记录内容...）\n")

    # 预建明天文件（应对深夜cron）
    tomorrow = today.replace(hour=0, minute=0, second=0) + __import__('datetime').timedelta(days=1)
    tomorrow_path = f"{HEALTH_RECORD_DIR}{tomorrow.strftime('%Y-%m-%d')}.md"
    if not os.path.exists(tomorrow_path):
        with open(tomorrow_path, "w") as f:
            f.write(f"# 健康记录 {tomorrow.year}年{tomorrow.month}月{tomorrow.day}日\n\n（待记录内容...）\n")

if __name__ == "__main__":
    main()
```

配置在 `0 0 * * *` 每天凌晨运行，提前把今天的文件建好。

## ⚠️ 注意事项

1. **Cron 任务需要配置正确的 deliver 目标**（如飞书 chat_id）
2. **首次使用需要初始化健康档案**，填写用户基本信息
3. **数据文件需要定期备份**，防止丢失
4. **鱼油和钙片需要另外购买**，善存复合维生素是基础款

---

### 🔧 调试健康cron日期问题（见真实案例：5月22日报告显示5月22日）

**症状**：晚间cron报告日期比实际日期早一天（如5月23日的cron读了5月22日的文件）。

**排查步骤**：
1. `cronjob(action="list")` 看所有job的last_run和next_run
2. `ls -la ~/.hermes/health-records/` 看文件创建时间和修改时间
3. `ls ~/.hermes/cron/output/{job_id}/` 看cron输出文件确认运行结果
4. 手动 `cronjob(action="run", job_id)` 触发测试，等生成输出后读文件

**根因**：cron prompt里写"今天是几号，你自己去目录下看最新的文件是什么日期"。如果早上cron因为用户没回复而没创建今天的文件，晚上cron就会读到前一天的旧文件。

**修复方案**：prompt开头写"今天是2026年5月25日（如果实际日期不同，请用实际日期）"，并加"如果文件不存在，先用模板创建"。AI会根据实际日期自动替换文件名（如5月26日就是"2026-05-26.md"）。

---

### 🔧 GitHub API直接更新文件（无需clone）

当git clone超时/挂起时，用GitHub REST API直接更新文件：

```python
import urllib.request, json, base64

TOKEN = "ghp_xxx"
REPO = "owner/repo"
FILE_PATH = "SKILL.md"

# 1. 获取当前文件SHA
url = f"https://api.github.com/repos/{REPO}/contents/{FILE_PATH}"
req = urllib.request.Request(url, headers={
    "Authorization": f"token {TOKEN}",
    "Accept": "application/vnd.github.v3+json"
})
with urllib.request.urlopen(req) as resp:
    sha = json.loads(resp.read())['sha']

# 2. 读取本地新内容
with open("local/path/SKILL.md") as f:
    content = f.read()
encoded = base64.b64encode(content.encode()).decode()

# 3. PUT更新
payload = json.dumps({
    "message": "commit message",
    "content": encoded,
    "sha": sha
})
req = urllib.request.Request(url, data=payload.encode(), headers={
    "Authorization": f"token {TOKEN}",
    "Content-Type": "application/json"
}, method="PUT")
with urllib.request.urlopen(req) as resp:
    result = json.loads(resp.read())
    print(f"✅ {result['commit']['sha']}")
```

注意：git clone挂起通常是网络问题，换API可绕过。

- 想要减脂/控制体重的职场人士
- 需要追踪健康数据的亚健康人群
- 想要养成健康习惯但缺乏自律的人
- 40+女性（特别关注代谢和骨骼健康）
