
## 🚀 Harbor Deployer — 自动化企业级 Harbor 安装与部署工具

> 一键部署最新版本 Harbor，支持多架构、多系统环境自动识别与安全安装。
> 兼容企业私有化部署、离线环境与生产级使用。

---

### 📘 项目简介

**Harbor Deployer** 是一个自动化安装脚本，用于快速、可靠地部署 [Harbor](https://goharbor.io) 镜像仓库服务。
它支持自动检测当前系统架构（`x86_64` / `arm64` / `aarch64` 等），下载官方最新稳定版本的 Harbor 安装包，完成环境依赖检查、TLS配置初始化、启动与健康检测。

该脚本旨在为 **企业私有云、DevOps 团队、Kubernetes 环境** 提供一键化 Harbor 部署解决方案。

---

### 🧩 支持的环境

| 分类   | 支持项                                                             |
| ---- | --------------------------------------------------------------- |
| 操作系统 | Ubuntu 20.04+ / Debian 11+ / CentOS 7+ / RockyLinux / AlmaLinux |
| 架构   | `x86_64`, `arm64`, `aarch64`                                    |
| 网络模式 | 在线安装 / 离线部署（需提前准备 Harbor 包）                                     |
| 运行模式 | HTTP / HTTPS（默认启用自签证书）                                          |
| 权限要求 | root 或 sudo 权限用户                                                |

---

### ⚙️ 功能特性

* ✅ 自动检测系统与架构，下载官方 Harbor 最新版本
* ✅ 自动安装 Docker & Docker Compose（可复用已有环境）
* ✅ 自动生成自签名证书（或使用自定义证书）
* ✅ 自动启动并验证 Harbor 服务健康状态
* ✅ 支持离线部署与镜像预加载
* ✅ 可配置 Harbor 管理员账户与密码
* ✅ 安全防护：严格权限、敏感变量保护、错误回滚机制

---

### 📦 安装与使用

#### 1️⃣ 克隆仓库

```bash
git clone https://github.com/ciliverse/tools.git
cd tools/harbor-deployer
```

#### 2️⃣ 授权并执行脚本

```bash
chmod +x harbor-deploy.sh
sudo ./harbor-deploy.sh
```

#### 3️⃣ 安装完成后访问

默认访问地址：

```
https://<your-hostname>/
```

默认管理员账户：

```
admin / Harbor12345
```

> ✅ 安装完成后请立即修改管理员密码。

---

### 🔐 自定义配置

你可以在脚本执行前定义以下环境变量：

| 变量名                     | 说明                     | 默认值               |
| ----------------------- | ---------------------- | ----------------- |
| `HARBOR_VERSION`        | 指定 Harbor 版本（默认自动检测最新） | 最新稳定版             |
| `HARBOR_DOMAIN`         | Harbor 域名或 IP          | 当前主机名             |
| `HARBOR_ADMIN_PASSWORD` | 管理员密码                  | Harbor12345       |
| `INSTALL_MODE`          | `online` 或 `offline`   | online            |
| `CERT_DIR`              | 自定义证书路径                | /etc/harbor/certs |

示例：

```bash
export HARBOR_VERSION="2.11.0"
export HARBOR_DOMAIN="harbor.corp.local"
export HARBOR_ADMIN_PASSWORD="StrongPass@123"
sudo ./harbor-deploy.sh
```

---

### 📁 项目结构

```
harbor-deployer/
├── harbor-deploy.sh          # 主部署脚本
├── LICENSE                   # 许可证
├── README.md                 # 项目文档
└── offline/                  # 离线部署支持目录（可选）
    └── harbor-offline-installer.tgz
```

---

### 🧰 脚本逻辑概览

1. 检测操作系统与CPU架构
2. 检查 root 权限
3. 自动安装 Docker 与 Docker Compose
4. 下载或解压 Harbor 安装包
5. 自动生成 `harbor.yml` 配置文件
6. 执行安装并启动 Harbor
7. 校验服务健康状态并输出访问信息

---

### 🛡️ 安全与合规

* 所有敏感信息（密码、证书）仅保留在本地，不上传网络
* 默认生成自签名证书，建议生产环境使用正式证书
* 不修改系统防火墙、selinux、安全策略（仅提示手动操作）

---

### 🧭 离线部署指南

1. 下载对应版本的离线安装包：

   ```
   wget https://github.com/goharbor/harbor/releases/download/v2.11.0/harbor-offline-installer-v2.11.0.tgz
   ```
2. 放入 `offline/` 目录
3. 执行：

   ```
   INSTALL_MODE=offline ./harbor-deploy.sh
   ```

---

### 🧑‍💻 贡献指南

欢迎提交 PR 或 issue 改进此项目！

* Fork 仓库并创建分支
* 提交修改（请遵守 shell 脚本规范）
* 发起 Pull Request

---

### 📜 开源许可证

本项目基于 [MIT License](./LICENSE) 开源。
自由使用、修改与分发，请保留版权信息。

---

### 💡 建议与反馈

如需企业级支持或集群部署优化，可联系作者或提交 Issue：

* ✉️ Email: [devops@yourdomain.com](mailto:devops@yourdomain.com)
* 🌐 Website: [https://yourdomain.com](https://yourdomain.com)

