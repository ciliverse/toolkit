# 机器学习工作负载

该目录包含机器学习相关的工具、脚本和配置，支持完整的ML生命周期管理。

## 目录结构

- `data/` - 数据处理和存储配置
- `experiments/` - 实验管理和跟踪
- `models/` - 模型管理和版本控制
- `pipelines/` - ML流水线和工作流
- `serving/` - 模型部署和推理服务

## ML生命周期

1. **数据准备** - 数据收集、清洗和预处理
2. **实验开发** - 模型训练和超参数调优
3. **模型管理** - 版本控制和注册
4. **流水线部署** - 自动化训练和部署
5. **模型服务** - 在线推理和监控

## 技术栈

- **框架** - TensorFlow, PyTorch, Scikit-learn
- **编排** - Kubeflow, MLflow, Apache Airflow
- **存储** - MinIO, HDFS, 云存储
- **监控** - Prometheus, MLflow Tracking
- **部署** - KFServing, TensorFlow Serving

## 快速开始

```bash
# 1. 部署ML平台
make deploy-ml-platform

# 2. 运行数据处理
make process-data

# 3. 启动实验
make run-experiment

# 4. 部署模型
make deploy-model
```