# 持续集成 (CI)

该目录包含持续集成和持续部署的配置文件和脚本。

## 目录结构

- `github-actions/` - GitHub Actions 工作流配置
- `gitlab-ci/` - GitLab CI/CD 配置

## 支持的CI平台

- **GitHub Actions** - 基于GitHub的CI/CD流水线
- **GitLab CI** - 基于GitLab的CI/CD流水线

## 使用说明

根据你的代码托管平台选择相应的CI配置：
- 对于GitHub项目，使用 `github-actions/` 中的配置
- 对于GitLab项目，使用 `gitlab-ci/` 中的配置

每个平台目录都包含完整的CI/CD流水线配置，包括构建、测试、安全扫描和部署步骤。