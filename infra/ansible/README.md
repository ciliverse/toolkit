# Ansible 自动化

该目录包含Ansible playbooks和角色，用于服务器配置管理和应用部署自动化。

## Playbooks

- **系统配置** - 操作系统基础配置
- **安全加固** - 安全策略和配置
- **应用部署** - 应用程序安装和配置
- **监控部署** - 监控组件安装

## 目录结构

```
ansible/
├── playbooks/          # 主要的playbook文件
├── roles/              # 可重用的角色
├── inventory/          # 主机清单
├── group_vars/         # 组变量
├── host_vars/          # 主机变量
└── ansible.cfg         # Ansible配置文件
```

## 使用方法

```bash
# 1. 安装依赖
ansible-galaxy install -r requirements.yml

# 2. 检查连接
ansible all -m ping

# 3. 执行playbook
ansible-playbook -i inventory/hosts playbooks/site.yml

# 4. 限制到特定主机组
ansible-playbook -i inventory/hosts -l web playbooks/webserver.yml
```

## 最佳实践

- 使用角色组织可重用代码
- 加密敏感数据使用ansible-vault
- 在生产环境前先测试
- 维护清晰的变量层次结构