# 入口控制器

该目录包含入口控制器和负载均衡的配置文件。

## 入口控制器类型

- **Nginx Ingress** - 最流行的入口控制器
- **Traefik** - 现代云原生代理
- **Istio Gateway** - 服务网格入口网关
- **Kong** - API网关和入口控制器
- **HAProxy** - 高性能负载均衡器

## 功能特性

- **负载均衡** - 流量分发和负载均衡
- **SSL终端** - HTTPS证书管理
- **路径路由** - 基于路径的流量路由
- **主机路由** - 基于域名的虚拟主机
- **限流控制** - 流量限制和QoS

## 配置类型

- **HTTP路由** - 7层应用路由
- **TCP/UDP代理** - 4层网络代理
- **gRPC路由** - gRPC服务路由
- **WebSocket** - WebSocket连接支持
- **HTTP/2** - HTTP/2协议支持

## 高可用配置

- **多副本部署** - 控制器高可用
- **健康检查** - 后端服务健康检测
- **故障转移** - 自动故障切换
- **会话保持** - 会话粘性配置

## 使用示例

```bash
# 部署Nginx Ingress Controller
kubectl apply -f nginx-ingress-controller.yaml

# 创建Ingress规则
kubectl apply -f ingress-rules.yaml

# 查看入口状态
kubectl get ingress

# 获取外部IP
kubectl get svc -n ingress-nginx
```