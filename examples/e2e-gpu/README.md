# GPU 端到端示例

这是一个基于GPU加速的机器学习端到端示例，展示AI/ML工作负载在云原生平台上的部署和管理。

## 应用架构

- **模型训练** - 使用GPU进行深度学习模型训练
- **模型服务** - GPU推理服务部署
- **数据处理** - 大规模数据预处理管道
- **监控** - GPU资源监控和性能指标

## 技术栈

- **ML框架** - TensorFlow/PyTorch
- **GPU支持** - NVIDIA GPU Operator
- **容器运行时** - NVIDIA Container Runtime
- **资源调度** - Kubernetes GPU调度
- **模型服务** - TensorFlow Serving/TorchServe

## 硬件要求

- NVIDIA GPU (Tesla/RTX/Quadro)
- CUDA 11.0+
- 足够的GPU内存 (推荐8GB+)

## 快速开始

```bash
# 1. 检查GPU支持
nvidia-smi

# 2. 部署GPU Operator
make deploy-gpu-operator

# 3. 构建GPU镜像
make build-gpu

# 4. 部署ML工作负载
make deploy-ml

# 5. 检查GPU资源使用
kubectl get nodes -o custom-columns=NAME:.metadata.name,GPU:.status.allocatable."nvidia\.com/gpu"
```

## 学习目标

- 掌握GPU工作负载的容器化
- 理解Kubernetes GPU资源调度
- 学习ML模型的云原生部署
- 了解GPU监控和故障排除