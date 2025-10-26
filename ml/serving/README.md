# 模型服务

该目录包含机器学习模型的部署和推理服务配置。

## 服务类型

- **在线推理** - 实时API服务
- **批量推理** - 批处理预测
- **边缘推理** - 边缘设备部署
- **流式推理** - 实时流处理

## 推理框架

- **TensorFlow Serving** - TF模型服务
- **TorchServe** - PyTorch模型服务
- **KFServing/KServe** - K8s原生模型服务
- **Triton Inference Server** - NVIDIA推理服务器
- **MLflow Models** - 通用模型服务

## 部署方式

- **Kubernetes** - 容器化部署
- **Docker** - 单机容器部署
- **云服务** - 托管服务部署
- **无服务器** - Serverless部署

## 监控指标

- **响应时间** - 推理延迟监控
- **吞吐量** - QPS性能指标
- **准确性** - 模型预测准确度
- **资源使用** - CPU/GPU/内存使用率

## 使用示例

```bash
# 部署模型服务
kubectl apply -f model-service.yaml

# 测试推理API
curl -X POST http://model-service/predict \
  -H "Content-Type: application/json" \
  -d '{"instances": [[1,2,3,4]]}'

# 监控服务状态
kubectl get inferenceservice
```