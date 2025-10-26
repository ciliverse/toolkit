# 数据管理

该目录包含机器学习数据处理、存储和管理的配置和脚本。

## 数据类型

- **原始数据** - 未处理的源数据
- **清洗数据** - 预处理后的数据
- **特征数据** - 特征工程后的数据
- **训练数据** - 模型训练用数据集
- **测试数据** - 模型评估用数据集

## 数据存储

- **对象存储** - MinIO, S3
- **文件系统** - HDFS, NFS
- **数据库** - PostgreSQL, MongoDB
- **数据湖** - Delta Lake, Apache Hudi

## 数据处理工具

- **批处理** - Apache Spark, Pandas
- **流处理** - Apache Kafka, Apache Flink
- **数据验证** - Great Expectations
- **数据血缘** - Apache Atlas

## 使用示例

```bash
# 数据摄取
python ingest_data.py --source s3://bucket/raw-data

# 数据清洗
python clean_data.py --input raw-data --output clean-data

# 特征工程
python feature_engineering.py --input clean-data --output features

# 数据验证
python validate_data.py --data features
```