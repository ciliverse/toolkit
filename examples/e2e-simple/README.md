# 简单端到端示例

这是一个简单的端到端云原生应用示例，展示从开发到生产部署的完整流程。

## 应用架构

- **前端** - React/Vue.js 单页应用
- **后端** - Node.js/Python REST API
- **数据库** - PostgreSQL/MongoDB
- **缓存** - Redis

## 技术栈

- **容器化** - Docker
- **编排** - Kubernetes
- **服务网格** - Istio (可选)
- **监控** - Prometheus + Grafana
- **日志** - ELK Stack

## 快速开始

```bash
# 1. 构建应用
make build

# 2. 本地运行
make run-local

# 3. 部署到Kubernetes
make deploy

# 4. 查看服务状态
kubectl get pods
```

## 学习目标

- 理解云原生应用开发模式
- 掌握容器化和Kubernetes部署
- 学习CI/CD流水线配置
- 了解监控和日志管理