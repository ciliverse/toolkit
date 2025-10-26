# Helm Charts

该目录包含Helm Charts包，用于Kubernetes应用的包管理和部署。

## Charts 类型

- **应用Charts** - 业务应用的Helm包
- **基础设施Charts** - 基础设施组件的Helm包
- **依赖Charts** - 第三方依赖的Charts

## Chart 结构

```
chart-name/
├── Chart.yaml          # Chart元数据
├── values.yaml         # 默认配置值
├── templates/          # 模板文件
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── charts/             # 依赖Charts
└── README.md          # Chart文档
```

## 使用方法

```bash
# 1. 检查Chart语法
helm lint chart-name/

# 2. 渲染模板预览
helm template chart-name/

# 3. 安装Chart
helm install release-name chart-name/

# 4. 升级发布
helm upgrade release-name chart-name/

# 5. 查看发布状态
helm status release-name
```

## 开发最佳实践

- 使用语义化版本控制
- 提供完整的values.yaml文档
- 编写单元测试验证模板
- 使用Helm hooks处理生命周期事件