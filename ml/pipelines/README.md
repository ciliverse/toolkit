# ML流水线

该目录包含机器学习流水线和工作流的定义和配置。

## 流水线类型

- **训练流水线** - 自动化模型训练
- **推理流水线** - 批量预测处理
- **特征流水线** - 特征工程自动化
- **数据流水线** - 数据处理工作流

## 编排工具

- **Kubeflow Pipelines** - K8s原生ML工作流
- **Apache Airflow** - 通用工作流调度
- **MLflow Projects** - ML项目管理
- **Argo Workflows** - 容器化工作流

## 流水线组件

- **数据摄取** - 数据收集和验证
- **预处理** - 数据清洗和转换
- **训练** - 模型训练和验证
- **评估** - 模型性能评估
- **部署** - 模型部署和服务

## 使用方法

```bash
# 编译流水线
python pipeline.py

# 提交流水线
kfp pipeline upload --pipeline-name my-pipeline pipeline.yaml

# 运行流水线
kfp run submit --experiment-name exp1 --pipeline-name my-pipeline

# 监控流水线
kfp run list --experiment-name exp1
```