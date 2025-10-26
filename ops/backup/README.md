# 备份恢复

该目录包含数据备份、恢复和灾难恢复的工具和脚本。

## 备份类型

- **数据库备份** - MySQL, PostgreSQL, MongoDB备份
- **文件系统备份** - 应用数据和配置文件备份
- **Kubernetes备份** - 集群配置和PV数据备份
- **镜像备份** - 容器镜像和Helm Chart备份

## 备份策略

- **全量备份** - 完整数据备份
- **增量备份** - 变更数据备份
- **差异备份** - 基于基线的备份
- **快照备份** - 存储快照备份

## 备份工具

- **Velero** - Kubernetes集群备份
- **Restic** - 去重增量备份
- **Duplicity** - 加密增量备份
- **mysqldump/pg_dump** - 数据库备份
- **rsync** - 文件同步备份

## 恢复测试

- **定期恢复演练** - 验证备份有效性
- **RTO/RPO测试** - 恢复时间和数据丢失测试
- **跨环境恢复** - 灾难恢复环境测试

## 使用示例

```bash
# 数据库备份
./backup-database.sh --type mysql --database myapp

# Kubernetes备份
velero backup create cluster-backup --include-namespaces default

# 文件备份
restic backup /data --repo s3:backup-bucket/restic

# 恢复数据
./restore-database.sh --backup backup-20231201.sql
```