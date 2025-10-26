# Kubernetes 配置

该目录包含Kubernetes集群配置和资源清单文件。

## 目录结构

- `charts/` - Helm Charts 包
- `manifests/` - 原生Kubernetes YAML清单

## 配置类型

- **集群组件** - 核心Kubernetes组件配置
- **网络策略** - 网络安全和流量控制
- **存储类** - 持久化存储配置
- **RBAC** - 基于角色的访问控制
- **监控** - 集群监控和告警配置

## 部署方式

### 使用kubectl直接部署
```bash
kubectl apply -f manifests/
```

### 使用Helm部署
```bash
helm install myapp charts/myapp/
```

## 最佳实践

- 使用命名空间隔离不同环境
- 配置资源限制和请求
- 实施网络策略提高安全性
- 定期备份etcd数据
- 监控集群健康状态