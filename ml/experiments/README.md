# 机器学习实验

该目录包含ML实验管理、跟踪和可重现性配置。

## 实验管理

- **实验跟踪** - MLflow, Weights & Biases
- **超参数调优** - Optuna, Hyperopt
- **实验版本控制** - DVC, Git
- **结果可视化** - TensorBoard, Jupyter

## 实验结构

```
experiments/
├── notebooks/          # Jupyter实验笔记本
├── configs/           # 实验配置文件
├── scripts/           # 训练脚本
├── results/           # 实验结果
└── artifacts/         # 模型产物
```

## 实验流程

1. **实验设计** - 定义假设和指标
2. **环境准备** - 配置实验环境
3. **实验执行** - 运行训练和评估
4. **结果分析** - 分析和比较结果
5. **实验记录** - 记录和分享发现

## 使用方法

```bash
# 启动实验跟踪服务
mlflow ui

# 运行实验
python experiments/train_model.py --config configs/experiment1.yaml

# 比较实验结果
mlflow experiments list
mlflow runs compare --experiment-id 1

# 导出最佳模型
mlflow models serve --model-uri models:/best-model/1
```