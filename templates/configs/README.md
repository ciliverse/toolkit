# 配置文件模板

该目录包含各种应用和中间件的配置文件模板。

## 应用配置模板

- **Spring Boot** - application.yml模板
- **Node.js** - package.json和环境配置
- **Python** - settings.py和requirements.txt
- **Go** - config.yaml和环境配置
- **Docker** - Dockerfile和docker-compose.yml

## 中间件配置模板

- **Nginx** - nginx.conf和虚拟主机配置
- **Redis** - redis.conf配置模板
- **MySQL** - my.cnf配置模板
- **PostgreSQL** - postgresql.conf配置模板
- **RabbitMQ** - rabbitmq.conf配置模板

## Kubernetes配置模板

- **Deployment** - 应用部署模板
- **Service** - 服务暴露模板
- **ConfigMap** - 配置映射模板
- **Secret** - 密钥管理模板
- **Ingress** - 入口规则模板

## 监控配置模板

- **Prometheus** - 监控规则和配置
- **Grafana** - 仪表板JSON模板
- **AlertManager** - 告警规则模板
- **Fluentd** - 日志收集配置模板

## 使用方法

```bash
# 复制模板文件
cp templates/configs/spring-boot/application.yml myapp/

# 替换占位符
sed -i 's/{{APP_NAME}}/myapp/g' myapp/application.yml

# 验证配置文件
yamllint myapp/application.yml

# 应用配置
kubectl create configmap myapp-config --from-file=myapp/application.yml
```