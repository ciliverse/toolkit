#!/bin/bash
# 强制删除命名空间下的所有 Pod
# 使用方法：
#   ./force-delete-pods.sh <namespace>

# 检查参数
if [ -z "$1" ]; then
  echo "❌ 请输入要强制删除的命名空间，例如："
  echo "   ./force-delete-pods.sh my-namespace"
  exit 1
fi

NAMESPACE=$1

echo "⚙️ 正在获取命名空间 [$NAMESPACE] 下的 Pod 列表..."
PODS=$(kubectl get pod -n "$NAMESPACE" --no-headers 2>/dev/null | awk '{print $1}')

if [ -z "$PODS" ]; then
  echo "✅ 命名空间 [$NAMESPACE] 下没有 Pod。"
  exit 0
fi

echo "🚨 检测到以下 Pod 将被强制删除："
echo "$PODS" | sed 's/^/   - /'

read -p "⚠️ 确认要强制删除这些 Pod 吗？(y/n): " confirm
if [ "$confirm" != "y" ]; then
  echo "❎ 操作已取消。"
  exit 0
fi

for pod in $PODS; do
  echo "🔥 正在强制删除 Pod: $pod ..."
  kubectl delete pod "$pod" -n "$NAMESPACE" --grace-period=0 --force --ignore-not-found
done

echo "✅ 命名空间 [$NAMESPACE] 下的所有 Pod 已强制删除完成。"
