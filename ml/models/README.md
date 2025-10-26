# 模型管理

该目录包含机器学习模型的版本控制、注册和生命周期管理。

## 模型注册

- **模型版本控制** - MLflow Model Registry
- **模型元数据** - 描述、标签、阶段
- **模型血缘** - 数据和实验追踪
- **模型审批** - 部署前审核流程

## 模型格式

- **MLflow** - 通用模型格式
- **ONNX** - 跨平台推理格式
- **TensorFlow SavedModel** - TF原生格式
- **PyTorch JIT** - PyTorch部署格式
- **Pickle** - Python序列化格式

## 模型阶段

- **Staging** - 测试阶段
- **Production** - 生产阶段
- **Archived** - 归档阶段

## 使用示例

```bash
# 注册模型
mlflow models serve --model-uri models:/my-model/1

# 模型转换
python convert_model.py --input model.pkl --output model.onnx

# 模型验证
python validate_model.py --model-path models/my-model

# 部署模型
kubectl apply -f k8s/model-deployment.yaml
```