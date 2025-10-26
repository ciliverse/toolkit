# Kubernetes 集群

该模块用于创建和配置生产级别的Kubernetes集群。

## 集群特性

- **高可用性** - 多个主节点和工作节点
- **自动扩展** - 基于负载的节点自动伸缩
- **网络插件** - CNI网络解决方案
- **存储类** - 动态存储分配
- **安全加固** - RBAC和网络策略

## 组件配置

- **控制平面** - API服务器、etcd、调度器
- **工作节点** - kubelet、kube-proxy、容器运行时
- **网络** - Pod网络和服务发现
- **存储** - 持久化卷和存储类
- **监控** - 集群监控和日志收集

## 部署步骤

```bash
# 1. 配置集群参数
cp terraform.tfvars.example terraform.tfvars
# 编辑集群配置

# 2. 部署集群
terraform init
terraform plan
terraform apply

# 3. 配置kubectl
# 根据云平台获取kubeconfig
aws eks update-kubeconfig --name cluster-name

# 4. 验证集群
kubectl get nodes
kubectl get pods -A
```

## 后续配置

部署完成后需要安装：
- **Ingress Controller** - 负载均衡器
- **Cert Manager** - SSL证书管理
- **Monitoring Stack** - Prometheus和Grafana
- **Logging Stack** - ELK或EFK