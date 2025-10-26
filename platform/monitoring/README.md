# 监控系统

该目录包含监控、指标收集和告警的配置文件。

## 监控架构

- **指标收集** - Prometheus, InfluxDB, VictoriaMetrics
- **指标存储** - 时序数据库存储
- **可视化** - Grafana, Chronograf
- **告警** - AlertManager, Grafana Alerts

## Prometheus 生态

- **Prometheus** - 指标收集和存储
- **Grafana** - 数据可视化和仪表板
- **AlertManager** - 告警路由和通知
- **Node Exporter** - 系统指标采集
- **Pushgateway** - 短期作业指标推送

## 监控类型

- **基础设施监控** - 服务器、网络、存储
- **应用监控** - 应用性能和业务指标
- **容器监控** - Docker和Kubernetes监控
- **网络监控** - 网络流量和延迟
- **安全监控** - 安全事件和威胁检测

## 关键指标

- **可用性** - 服务可用率和SLA
- **性能** - 响应时间、吞吐量、错误率
- **资源** - CPU、内存、磁盘、网络使用率
- **业务** - 用户活跃度、转化率、收入

## 告警策略

- **阈值告警** - 基于指标阈值的告警
- **趋势告警** - 基于趋势变化的告警
- **异常检测** - 基于机器学习的异常告警
- **复合告警** - 多条件组合告警

## 使用示例

```bash
# 部署Prometheus Stack
kubectl apply -f prometheus-stack/

# 部署Node Exporter
kubectl apply -f node-exporter/

# 访问Grafana
kubectl port-forward svc/grafana 3000:3000

# 查看Prometheus目标
kubectl port-forward svc/prometheus 9090:9090
```