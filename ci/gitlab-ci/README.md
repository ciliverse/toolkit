# GitLab CI

该目录包含 GitLab CI/CD 流水线配置文件。

## 流水线阶段

标准流水线包含以下阶段：
- **构建** (build) - 编译代码和构建镜像
- **测试** (test) - 单元测试、集成测试
- **安全** (security) - 代码扫描、漏洞检测
- **部署** (deploy) - 部署到各个环境

## 文件结构

- `.gitlab-ci.yml` - 主配置文件
- `scripts/` - CI/CD 脚本
- `templates/` - 可重用的作业模板

## 使用说明

1. 将 `.gitlab-ci.yml` 复制到项目根目录
2. 配置 GitLab CI/CD 变量
3. 设置 GitLab Runner
4. 提交代码触发流水线执行