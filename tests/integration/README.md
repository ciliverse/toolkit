# 集成测试

该目录包含集成测试的配置和测试用例。

## 集成测试范围

- **API集成测试** - REST API端到端测试
- **数据库集成测试** - 数据访问层测试
- **消息队列测试** - MQ消息收发测试
- **缓存集成测试** - Redis缓存功能测试
- **第三方服务测试** - 外部服务集成测试

## 测试环境

- **测试容器** - Docker Compose测试环境
- **测试数据库** - 专用测试数据库
- **模拟服务** - Mock外部依赖服务
- **测试配置** - 独立测试配置文件

## 测试框架

- **REST Assured** - Java REST API测试
- **Supertest** - Node.js HTTP测试
- **requests** - Python HTTP客户端测试
- **Postman/Newman** - API自动化测试
- **TestContainers** - 容器化集成测试

## 测试用例

- **正常流程** - 业务正常执行路径
- **异常处理** - 错误和异常情况
- **边界测试** - 边界值和极限情况
- **并发测试** - 多用户并发场景
- **数据一致性** - 数据完整性验证

## 执行方式

```bash
# 启动测试环境
docker-compose -f docker-compose.test.yml up -d

# 运行集成测试
npm run test:integration

# 生成测试报告
npm run test:report

# 清理测试环境
docker-compose -f docker-compose.test.yml down
```