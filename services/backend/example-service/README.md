# 示例服务

这是一个完整的微服务示例，展示云原生应用开发的最佳实践。

## 服务功能

- **用户管理** - 用户注册、登录、信息管理
- **权限控制** - 基于角色的访问控制
- **数据CRUD** - 标准数据操作接口
- **业务逻辑** - 核心业务处理流程

## 技术实现

- **框架** - Spring Boot 2.x
- **数据库** - PostgreSQL + JPA
- **缓存** - Redis
- **认证** - JWT Token
- **文档** - OpenAPI/Swagger

## 项目结构

```
example-service/
├── src/main/java/
│   ├── controller/     # REST控制器
│   ├── service/        # 业务逻辑层
│   ├── repository/     # 数据访问层
│   ├── entity/         # 实体类
│   ├── dto/           # 数据传输对象
│   └── config/        # 配置类
├── src/main/resources/
│   ├── application.yml # 应用配置
│   └── db/migration/  # 数据库迁移脚本
├── src/test/          # 单元测试
├── Dockerfile         # 容器构建文件
└── k8s/              # Kubernetes部署配置
```

## 快速开始

```bash
# 构建应用
./mvnw clean package

# 构建Docker镜像
docker build -t example-service:latest .

# 本地运行
docker-compose up -d

# 部署到Kubernetes
kubectl apply -f k8s/

# 访问API文档
open http://localhost:8080/swagger-ui.html
```

## API端点

- `GET /api/v1/users` - 获取用户列表
- `POST /api/v1/users` - 创建新用户
- `GET /api/v1/users/{id}` - 获取用户详情
- `PUT /api/v1/users/{id}` - 更新用户信息
- `DELETE /api/v1/users/{id}` - 删除用户