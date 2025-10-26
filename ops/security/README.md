# 安全运维

该目录包含安全扫描、漏洞管理和安全加固的工具和脚本。

## 安全扫描

- **容器镜像扫描** - 镜像漏洞检测
- **代码安全扫描** - SAST静态代码分析
- **依赖漏洞扫描** - 第三方组件安全检查
- **配置安全扫描** - 安全配置基线检查
- **网络安全扫描** - 端口和服务扫描

## 安全工具

- **Trivy** - 容器镜像和文件系统扫描
- **Falco** - 运行时安全监控
- **OPA Gatekeeper** - 策略即代码
- **Kube-bench** - CIS Kubernetes基准检查
- **Kube-hunter** - Kubernetes渗透测试

## 安全策略

- **网络策略** - 微分段和流量控制
- **Pod安全策略** - 容器安全配置
- **RBAC策略** - 基于角色的访问控制
- **准入控制** - 资源创建安全检查

## 合规检查

- **CIS基准** - 安全配置基准
- **PCI-DSS** - 支付卡行业标准
- **SOC 2** - 系统和组织控制
- **GDPR** - 数据保护法规

## 使用示例

```bash
# 镜像安全扫描
trivy image myapp:latest

# 集群安全扫描
kube-bench run --targets master,node

# 运行时监控
falco --rules-file /etc/falco/rules.yaml

# 策略验证
opa fmt --diff policies/

# 网络扫描
nmap -sS -A target-host
```