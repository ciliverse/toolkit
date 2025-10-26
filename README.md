# Ciliverse Toolkit — Cloud-Native & AI DevOps Toolkit

> 🚀 一个融合 Cloud Native、DevOps 与 AI 技术的全栈工程工具库。  
> 包含基础设施自动化、平台运维、服务模板、MLOps 管线与智能化运维脚本。  
> 适用于企业私有云、边缘集群、AI 训练与推理环境的统一管理与自动化。


---

## 目录（High level）

- `docs/`       — 设计文档、架构、贡献与安全策略  
- `infra/`      — IaC: Terraform / Ansible / Kubernetes manifests / Helm charts  
- `platform/`   — 平台组建：Harbor、Ingress、Monitoring、Logging 等  
- `services/`   — 后端 / 前端 / API 模板与示例  
- `ml/`         — MLOps：训练、模型、Serving、Pipelines、数据处理  
- `ops/`        — SRE/运维工具：备份、恢复、故障排查、混沌测试  
- `tools/`      — 通用脚本 / CLI / Docker helper  
- `examples/`   — End-to-End 示例工程（含 GPU / 无 GPU）  
- `ci/`         — CI/CD pipeline 模板（GitHub Actions / GitLab CI）  
- `tests/`      — 语法、静态分析、安全扫描、集成测试

---

## 为什么这个仓库有价值？

- 覆盖 **全栈技术栈**（Infra、Platform、Backend、Frontend、MLOps）  
- 专为 **云原生 + AI** 场景设计：支持 GPU、模型服务、在线推理、数据流水线  
- 与企业实践接轨：包含 IaC、可审计脚本、可复现 CI/CD 模板与监控/告警方案  
- 以模块化、模板化、可复用为设计原则，便于团队协作和快速交付

---

## 快速开始

### 克隆仓库

```bash
git clone https://github.com/ciliverse/tools.git
cd tools
````

### 查看文档与架构图

```bash
less docs/INTRO.md
less docs/ARCHITECTURE.md
```

### 运行示例：快速部署本地 K8s + 模型服务（示例）

> 下面示例假设已安装 `kind`、`kubectl`、`helm`。

```bash
# 启动本地 k8s（kind）
./infra/k8s/local-kind/create-cluster.sh

# 部署示例平台（harbor, ingress, monitoring）
./platform/harbor/install.sh --hostname harbor.local --with-trivy
./platform/ingress/install.sh --provider nginx

# 部署示例服务 + 模型 serving
kubectl apply -f examples/e2e-simple/manifests/
```

---

## 关键模块说明（亮点）

### infra/

* `terraform/`：模块化网络、k8s、存储、iam 配置示例（可直接复用）
* `k8s/`：base namespace、rbac、storageclass、coredns 调整 templates

### platform/

* `harbor/`：企业级 Harbor 一键部署脚本（支持离线、证书、trivy）
* `monitoring/`：Prometheus + Grafana + Alertmanager + Exporters 部署模板
* `logging/`：Loki / Fluent Bit or Filebeat 集成模板

### ml/

* `models/`：已打包的模型容器示例（PyTorch / TF / ONNX / Triton）
* `serving/`：KFServing / Seldon / Triton 部署示例，包含 GPU 配置与 autoscaling
* `pipelines/`：Argo/Kubeflow pipeline 示例（数据预处理 → 训练 → 验证 → 部署）

### ops/

* k8s 日常运维脚本：`k8s-ops/` 包含 pod-debug、namespace-cleaner、resource-reporter
* 备份/恢复：etcd、mysql/postgres、pv snapshots 模板
* 安全：IAM 最小权限示例、secrets 管理（Vault / sealed-secrets / External Secrets）

---

## 开发 & 贡献指南

请阅读 `docs/CONTRIBUTING.md`，核心要点：

* Fork -> Feature branch -> PR（描述变更、兼容性、回滚点）
* 新增脚本需包含 header（purpose/usage/author/date）并支持 `-h` 帮助
* 必须加上单元/集成测试（放在 `tests/`）并在 CI 通过
* 对外下载或执行第三方资源需检查签名或校验哈希

---

## CI / Delivery（建议）

* 使用 GitHub Actions / GitLab CI 进行：

  * Shellcheck / golangci-lint / pylint 静态检查
  * container image build & scan（Trivy）
  * 模拟部署（kind / k3d）作为集成测试
  * 自动发布 Terraform module 和 Helm chart 到内部 registry

示例 pipeline 放在 `ci/github-actions/`。

---

## 安全 & 合规

* 严格禁止把 secrets（密码 / key / cert）提交到仓库
* 推荐使用 Vault / SealedSecrets / ExternalSecrets 做 secret 管理
* 所有生产证书使用受信 CA；自签证书仅限测试环境
* 定期执行 SCA（软件组成分析）与容器镜像扫描

---

## 版本控制与分支策略

* `main`：生产就绪（严格保护、PR required）
* `develop`：日常合并与 CI 校验分支
* feature branches：`feat/<area>-<short>`，例如 `feat/ml-pipeline-argo`
* release tags：`vYYYY.MM.DD` 或 semver `v1.2.0`

---

## 典型工作流示例（快速上手）

1. 新增 Terraform module：`infra/terraform/my-module` -> 编写 -> 本地 `terraform fmt`、`terraform validate` -> PR
2. 新增模型 serving：`ml/serving/new-model` -> 提供 Dockerfile + K8s manifests -> CI 自动构建镜像并推到内部 registry -> `examples` 里提供 demo
3. 运维脚本：`ops/k8s-ops/pod-debug.sh` -> 要求带 `-h`、log 输出并在 `tests/` 添加 lint 检查

---

## License

该项目使用 **MIT License**。详见 `LICENSE` 文件。

---

## 联系方式

* Repo: [https://github.com/ciliverse/tools](https://github.com/ciliverse/tools)
* 邮箱: [devops@ciliverse.com](mailto:cilliantech@gmail.com)

---

## 致谢

感谢社区与团队贡献者。欢迎 star ⭐、fork、贡献你的脚本与最佳实践！


