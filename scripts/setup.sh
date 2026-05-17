#!/bin/bash
# 健康管家系统 - 一键安装脚本
# 使用方法：bash <(curl -sL https://xxx/health-setup.sh)

set -e

echo "🏃‍♀️ 健康管家系统安装向导"
echo "============================"
echo ""

# 1. 检查 hermes 是否安装
if ! command -v hermes &> /dev/null; then
    echo "❌ 请先安装 Hermes Agent"
    exit 1
fi

# 2. 创建 Agent 角色
echo "📝 创建4个健康管家角色..."

hermes profile create health-recorder --description "健康数据记录员" 2>/dev/null || echo "health-recorder 已存在"
hermes profile create health-analyst --description "健康数据分析师" 2>/dev/null || echo "health-analyst 已存在"
hermes profile create health-motivator --description "健康督促员" 2>/dev/null || echo "health-motivator 已存在"
hermes profile create health-consultant --description "健康顾问" 2>/dev/null || echo "health-consultant 已存在"

echo "✅ 角色创建完成"
echo ""

# 3. 创建数据目录
echo "📁 创建健康数据目录..."
mkdir -p ~/.hermes/health-records

# 4. 询问用户基本信息
echo "📋 请回答以下问题来定制你的健康档案："
echo ""

read -p "1. 你的名字是？: " name
read -p "2. 你的年龄？: " age
read -p "3. 性别（男/女）？: " gender
read -p "4. 身高（cm）？: " height
read -p "5. 当前体重（kg）？: " weight

# 5. 生成配置文件
cat > ~/.hermes/health-records/config.yaml << EOF
name: $name
age: $age
gender: $gender
height: ${height}cm
current_weight: ${weight}kg

health_goal:
  primary: 改善健康
  secondary:
    - 养成健康饮食习惯
    - 增加运动频率
    - 改善睡眠质量

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

water_target:
  daily_ml: 1500-2000

reminders:
  morning: "09:00"
  lunch: "12:30"
  afternoon: "15:00"
  evening: "18:30"
  summary: "20:30"
  bedtime: "22:30"
  weekly_report: "周日21:00"
EOF

echo "✅ 健康档案创建完成"
echo ""

# 6. 创建今日记录模板
cat > ~/.hermes/health-records/$(date +%Y-%m-%d).md << EOF
# 📅 $(date +%Y-%m-%d) 健康记录

## 体重
- 空腹体重：待记录

## 早餐 🍽️
- 内容：
- 评分：/10

## 午餐 🍽️
- 内容：
- 评分：/10

## 晚餐 🍽️
- 内容：
- 评分：/10

## 运动 🏃
- 类型：
- 时长：分钟
- 强度：低/中/高

## 喝水 💧
- 摄入量：ml

## 睡眠 🌙
- 睡眠时长：小时

## 情绪 😊
- 心情评分：/10

## 营养素 💊
- [ ] 复合维生素
- [ ] 鱼油
- [ ] 钙片
EOF

echo "✅ 今日记录模板创建完成"
echo ""

# 7. 提示安装 cron 任务
echo "📌 下一步："
echo "在 Hermes 中运行以下命令来设置定时提醒："
echo ""
echo "1. 打开 Hermes"
echo "2. 说：'帮我设置健康管家定时提醒'"
echo "3. 或者使用 cronjob 工具手动创建7个定时任务"
echo ""

echo "============================"
echo "🎉 安装完成！"
echo ""
echo "📁 健康数据目录：~/.hermes/health-records/"
echo "👤 健康档案：~/.hermes/health-records/config.yaml"
echo ""
echo "开始和你的健康管家聊天吧！"
