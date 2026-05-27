---
name: health-companion
description: 为用户创建多Agent协作的健康管理系统，包含4个专业角色（督促员/记录员/分析师/顾问），通过cron定时任务协同工作。
trigger: "帮我创建一个健康管家 / 帮我搭建健康管理系统 / 给我做一个健康管理助手 / health companion setup"
category: productivity
---

# 🏃‍♀️ 健康管家系统 - 4 Agent 协作架构

## 概述

这是一个**真正的多Agent协作健康管理系统**，由4个专业角色组成：

| Agent | 角色 | 职责 | 挂载到的Cron |
|-------|------|------|-------------|
| health-motivator-agent | 督促员 | 发送温暖问候和提醒，只督促不记录 | 早安/午餐/喝水/晚餐/睡前 |
| health-recorder-agent | 记录员 | 把用户数据写入.md文件 | 早安/午餐/晚餐/晚间总结 |
| health-analyst-agent | 分析师 | 汇总数据、生成报告 | 晚间总结/周日周报 |
| health-consultant-agent | 顾问 | 根据数据给建议 | 用户主动询问时 |

## ⚡ 架构原理

cron job 运行时，通过 `skills` 参数挂载对应Agent的skill内容作为prompt上下文。
- 每个cron可以挂载1-2个Agent的skill
- skills参数会让AI加载对应SKILL.md的内容
- 不同时间点的cron挂载不同角色组合，形成协作

```
09:00 早安  →  督促员 + 记录员
12:00 午餐  →  督促员 + 记录员
15:00 喝水  →  督促员（轻量提醒）
18:00 晚餐  →  督促员 + 记录员
20:00 晚间  →  分析师 + 记录员
21:00 周报  →  分析师
22:00 睡前  →  督促员
```

## ✅ 安装步骤

### 第一步：创建4个Agent skill（已创建）

每个Agent有一个skill文件，位于 `~/.hermes/skills/health/` 下：
- `health-motivator-agent/SKILL.md` - 督促员
- `health-recorder-agent/SKILL.md` - 记录员
- `health-analyst-agent/SKILL.md` - 分析师
- `health-consultant-agent/SKILL.md` - 顾问

### 第二步：确保数据目录存在

```bash
mkdir -p ~/.hermes/health-records
```

### 第三步：确保cron-today.txt预写脚本

所有cron job都需要配置pre-script，确保运行时知道今天是几号：

**重要：script参数只接受文件路径，不接受inline命令！**

❌ 错误写法（踩坑教训）：`script: python3 -c "import datetime..."` → 会报 "Script not found"

✅ 正确做法：
```bash
# 先创建脚本文件
cat > /root/.hermes/scripts/cron-today.py << 'EOF'
#!/usr/bin/env python3
import datetime
t = datetime.datetime.now()
open('/root/.hermes/cron-today.txt','w').write(f'{t.year}年{t.month}月{t.day}日|{t.strftime("%Y-%m-%d")}')
EOF
```

然后 cron job 的 script 参数写：`python3 /root/.hermes/scripts/cron-today.py`

### 第四步：配置各cron的skills参数

每个cron创建时，通过 `skills` 参数挂载对应Agent的skill：

| Cron ID | 时间 | skills |
|---------|------|--------|
| f1fba417dbd9 | 09:00 | ["health-motivator-agent", "health-recorder-agent"] |
| 1c7c6c33b918 | 12:00 | ["health-motivator-agent", "health-recorder-agent"] |
| 23f1856be90c | 15:00 | ["health-motivator-agent"] |
| db4d8d8ecb0a | 18:00 | ["health-motivator-agent", "health-recorder-agent"] |
| 58f754263fcf | 20:00 | ["health-analyst-agent", "health-recorder-agent"] |
| 051d8404e46b | 21:00 (周日) | ["health-analyst-agent"] |
| ddb81d07f7a4 | 22:00 | ["health-motivator-agent"] |

### 🔧 调试要点

**排查步骤**：
1. `cronjob(action="list")` 看所有job的last_run和next_run
2. `cat ~/.hermes/cron-today.txt` 确认日期是否正确（应为今天）
3. `ls ~/.hermes/health-records/` 看文件是否存在、日期对不对
4. `ls ~/.hermes/cron/output/{job_id}/` 看cron输出
5. 手动 `cronjob(action="run", job_id)` 触发测试

**常见根因**：
- pre-script 路径写错（inline命令被当作文件名）→ script参数必须是文件路径如 `python3 /root/.hermes/scripts/cron-today.py`
- prompt里让AI"自己去找最新文件" → 换成读 `cron-today.txt`
- 两次 run 做对比：第一次读旧日期 → 修复 → 第二次读正确日期

### 🔧 script参数路径陷阱（已踩坑验证）

**症状**：cron job 配置 `script: python3 -c "import datetime;..."` 后，运行时报告：
```
Script not found: /root/.hermes/scripts/python3 -c "import datetime; t=datetime.datetime.now(); ..."
```
系统把整个字符串当作文件路径去找，没找到就报 `Script not found`。

**根因**：`script` 参数只接受**实际存在的文件路径**，不接受 inline shell 命令字符串。`-c "..."` 会被系统当作一个不存在的脚本文件名。

**验证时间**：2026-05-27，两次 run 对比：
- 第一次：inline命令 → Script not found → 读到了旧日期(5月24日)的数据
- 第二次：文件路径 `python3 /root/.hermes/scripts/cron-today.py` → 正确写入今天日期(5月27日) → 正确读空文件

**正确做法**：
1. 创建脚本文件 `/root/.hermes/scripts/cron-today.py`
2. Cron job 的 `script` 参数引用它：`python3 /root/.hermes/scripts/cron-today.py`
3. 每次 cron run 前后对比 `cat ~/.hermes/cron-today.txt` 确认日期正确

