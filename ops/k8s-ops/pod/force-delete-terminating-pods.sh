#!/bin/bash
# 自动检测处于 Terminating 状态的命名空间
# 并强制删除其中的 Pod
# 使用方法：
#   ./force-delete-terminating-pods.sh [--yes]

set -e

AUTO_CONFIRM=false
if [ "$1" == "--yes" ]; then
  AUTO_CONFIRM=true
fi

echo "🔍 正在扫描处于 Terminating 状态的命名空间..."
terminating_ns=$(kubectl get ns --no-headers 2>/dev/null | awk '$2=="Terminating"{print $1}')

if [ -z "$terminating_ns" ]; then
  echo "✅ 没有处于 Terminating 状态的命名空间。"
  exit 0
fi

count=$(echo "$terminating_ns" | wc -l | tr -d ' ')
echo "⚠️ 检测到 $count 个处于 Terminating 状态的命名空间："
echo "$terminating_ns" | sed 's/^/   - /'

if [ "$AUTO_CONFIRM" = false ]; then
  read -p "是否要强制删除这些命名空间下的 Pod？(y/n): " confirm
  if [ "$confirm" != "y" ]; then
    echo "❎ 已取消操作。"
    exit 0
  fi
fi

for ns in $terminating_ns; do
  echo "🧹 正在清理命名空间 [$ns] 下的 Pod..."
  pods=$(kubectl get pod -n "$ns" --no-headers 2>/dev/null | awk '{print $1}')
  if [ -z "$pods" ]; then
    echo "   ✅ 没有 Pod 可删除。"
    continue
  fi

  echo "$pods" | while read -r pod; do
    echo "   🔥 强制删除 Pod: $pod"
    kubectl delete pod "$pod" -n "$ns" --grace-period=0 --force --ignore-not-found
  done
done

echo
echo "✅ 已完成：共处理 $count 个处于 Terminating 状态的命名空间。"
echo "✅ 所有命名空间内的 Pod 已强制清理完成。"
