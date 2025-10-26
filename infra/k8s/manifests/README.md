# Kubernetes 清单文件

该目录包含原生Kubernetes YAML清单文件，用于直接部署到Kubernetes集群。

## 清单类型

- **工作负载** - Deployment, StatefulSet, DaemonSet
- **服务** - Service, Ingress, EndpointSlice
- **配置** - ConfigMap, Secret
- **存储** - PVC, StorageClass
- **RBAC** - Role, RoleBinding, ServiceAccount

## 目录组织

```
manifests/
├── namespace/          # 命名空间定义
├── rbac/              # RBAC配置
├── configmaps/        # 配置文件
├── deployments/       # 应用部署
├── services/          # 服务定义
├── ingress/           # 入口控制器
└── storage/           # 存储配置
```

## 部署方法

```bash
# 1. 创建命名空间
kubectl apply -f namespace/

# 2. 部署RBAC
kubectl apply -f rbac/

# 3. 部署配置
kubectl apply -f configmaps/

# 4. 部署应用
kubectl apply -f deployments/

# 5. 创建服务
kubectl apply -f services/

# 6. 配置入口
kubectl apply -f ingress/
```

## 最佳实践

- 使用标签和注解增强资源管理
- 设置合适的资源限制和请求
- 配置健康检查和就绪探针
- 使用命名空间隔离不同环境