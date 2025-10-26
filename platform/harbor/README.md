# Harbor 镜像仓库

该目录包含Harbor私有镜像仓库的部署和配置文件。

## Harbor 功能

- **镜像存储** - Docker镜像私有存储
- **漏洞扫描** - 镜像安全漏洞检测
- **访问控制** - 基于RBAC的权限管理
- **镜像签名** - Notary数字签名验证
- **复制同步** - 多仓库镜像同步

## 部署模式

- **单机部署** - 单节点Harbor实例
- **高可用部署** - 多节点负载均衡
- **云原生部署** - Kubernetes Helm部署

## 存储配置

- **本地存储** - 本地文件系统存储
- **对象存储** - S3/MinIO对象存储
- **数据库** - PostgreSQL元数据存储
- **缓存** - Redis缓存加速

## 安全配置

- **HTTPS访问** - TLS证书配置
- **LDAP集成** - 企业用户认证
- **镜像扫描** - Trivy/Clair漏洞扫描
- **策略管理** - 镜像推送策略

## 使用示例

```bash
# 登录Harbor
docker login harbor.example.com

# 推送镜像
docker tag myapp:latest harbor.example.com/myproject/myapp:latest
docker push harbor.example.com/myproject/myapp:latest

# 拉取镜像
docker pull harbor.example.com/myproject/myapp:latest

# 扫描镜像
curl -X POST "https://harbor.example.com/api/v2.0/projects/myproject/repositories/myapp/artifacts/latest/scan"
```