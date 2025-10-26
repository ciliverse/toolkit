# API 网关

该目录包含API网关的配置和部署文件。

## API网关功能

- **路由管理** - 请求路由和转发
- **认证授权** - 用户身份验证和权限控制
- **限流控制** - API调用频率限制
- **监控统计** - API使用情况统计
- **协议转换** - 不同协议间的转换

## 网关技术

- **Kong** - 云原生API网关
- **Zuul** - Netflix微服务网关
- **Spring Cloud Gateway** - Spring生态网关
- **Traefik** - 现代HTTP反向代理
- **Istio Gateway** - 服务网格网关

## 安全功能

- **JWT认证** - JSON Web Token验证
- **OAuth2** - 标准授权协议
- **API密钥** - API密钥管理
- **IP白名单** - IP访问控制
- **CORS处理** - 跨域请求处理

## 流量管理

- **负载均衡** - 后端服务负载分发
- **熔断器** - 故障隔离和恢复
- **重试机制** - 请求失败重试
- **超时控制** - 请求超时管理

## 使用示例

```bash
# 部署API网关
kubectl apply -f api-gateway.yaml

# 配置路由规则
kubectl apply -f gateway-routes.yaml

# 检查网关状态
kubectl get gateway

# 测试API访问
curl -H "Authorization: Bearer token" \
     https://api.example.com/v1/users
```