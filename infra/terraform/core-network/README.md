# 核心网络基础设施

该模块定义核心网络架构，包括VPC、子网、路由和安全组配置。

## 网络架构

- **VPC** - 虚拟私有云网络
- **公有子网** - 面向互联网的资源
- **私有子网** - 内部应用和数据库
- **NAT网关** - 私有子网出站访问
- **互联网网关** - 公网访问入口

## 安全配置

- **安全组** - 网络访问控制
- **网络ACL** - 子网级别安全
- **路由表** - 流量路由控制
- **VPC终端节点** - 私有服务访问

## 部署说明

```bash
# 1. 配置变量
cp terraform.tfvars.example terraform.tfvars
# 编辑 terraform.tfvars 文件

# 2. 初始化并部署
terraform init
terraform plan
terraform apply

# 3. 获取输出信息
terraform output
```

## 输出变量

- `vpc_id` - VPC标识符
- `public_subnet_ids` - 公有子网ID列表
- `private_subnet_ids` - 私有子网ID列表
- `security_group_ids` - 安全组ID列表