# Helm Chart 模板

该目录包含常用的Helm Chart模板，用于Kubernetes应用打包和部署。

## Chart 模板类型

- **Web应用** - 前端和后端应用Chart
- **数据库** - MySQL, PostgreSQL, MongoDB Chart
- **中间件** - Redis, RabbitMQ, Kafka Chart
- **监控** - Prometheus, Grafana Chart
- **日志** - ELK, PLG Stack Chart

## 模板结构

```
chart-template/
├── Chart.yaml          # Chart元数据
├── values.yaml         # 默认配置值
├── values-dev.yaml     # 开发环境配置
├── values-prod.yaml    # 生产环境配置
├── templates/          # 模板文件
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   └── secret.yaml
└── README.md          # Chart使用说明
```

## 模板特性

- **参数化配置** - 支持环境变量和配置覆盖
- **条件渲染** - 基于条件的资源创建
- **函数支持** - Helm模板函数和管道
- **依赖管理** - Chart依赖关系管理
- **钩子支持** - 生命周期钩子处理

## 使用方法

```bash
# 创建新Chart
helm create myapp

# 复制模板
cp -r templates/helm/webapp/* myapp/

# 自定义配置
vim myapp/values.yaml

# 验证模板
helm lint myapp/

# 部署Chart
helm install myapp-release myapp/

# 升级Chart
helm upgrade myapp-release myapp/
```

## 最佳实践

- 使用语义化版本控制
- 提供完整的values.yaml文档
- 实现优雅的资源管理
- 支持多环境配置