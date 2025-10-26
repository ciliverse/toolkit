# 日志管理

该目录包含日志收集、处理和分析的配置文件。

## 日志架构

- **日志收集** - Fluent Bit, Fluentd, Filebeat
- **日志存储** - Elasticsearch, Loki, ClickHouse
- **日志展示** - Kibana, Grafana, Chronograf
- **日志分析** - Logstash, Vector, FluentD

## ELK Stack 组件

- **Elasticsearch** - 分布式搜索引擎
- **Logstash** - 日志处理管道
- **Kibana** - 数据可视化平台
- **Beats** - 轻量级数据采集器

## PLG Stack 组件

- **Promtail** - 日志收集代理
- **Loki** - 日志聚合系统
- **Grafana** - 日志查询和可视化

## 日志类型

- **应用日志** - 应用程序运行日志
- **系统日志** - 操作系统和内核日志
- **访问日志** - Web服务器访问日志
- **审计日志** - 安全审计和合规日志
- **性能日志** - 性能监控和调试日志

## 日志处理

- **日志解析** - 结构化日志数据
- **日志过滤** - 重要信息筛选
- **日志聚合** - 多源日志汇总
- **日志告警** - 异常事件告警

## 使用示例

```bash
# 部署ELK Stack
kubectl apply -f elk-stack/

# 部署PLG Stack
kubectl apply -f plg-stack/

# 查看日志收集状态
kubectl get pods -n logging

# 访问Kibana/Grafana
kubectl port-forward svc/kibana 5601:5601
```