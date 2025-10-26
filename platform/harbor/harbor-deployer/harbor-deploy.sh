#!/usr/bin/env bash
#
# ==========================================================
# Harbor Deployer - 企业级自动化安装脚本
# Author: cillian
# Version: 1.0.0
# ==========================================================
# install-harbor-enterprise.sh
# 企业级 Harbor 自动部署脚本（支持参数化、离线/在线、HTTPS、自签证书）
# - 支持架构: amd64 / arm64
# - 支持主流 Linux: Debian/Ubuntu & RHEL/CentOS/Alma/Rocky
# - 支持：--hostname, --admin-pass, --local-pkg, --https, --cert, --key, --with-trivy, --dry-run
#
# 使用示例：
#   sudo ./install-harbor-enterprise.sh --hostname registry.example.com --https --with-trivy
#   sudo ./install-harbor-enterprise.sh --local-pkg /tmp/harbor-offline-installer-2.7.0.tgz --hostname harbor.local
#
set -euo pipefail
IFS=$'\n\t'

# -----------------------
# Defaults
# -----------------------
DEFAULT_INSTALL_DIR="/opt/harbor"
DEFAULT_ADMIN_PASS=""
DEFAULT_WITH_TRIVY=false
DEFAULT_DRY_RUN=false
DEFAULT_WITH_HTTPS=false
DEFAULT_LOCAL_PKG=""
DEFAULT_CERT=""
DEFAULT_KEY=""
DEFAULT_FORCE=false
DEFAULT_VERSION=""   # "" 表示在线获取 latest（如果未提供 --local-pkg）
ARCH_TAG=""
OS_FAMILY=""
PKG_FILE=""
GITHUB_API_LATEST="https://api.github.com/repos/goharbor/harbor/releases/latest"

# -----------------------
# Helper functions
# -----------------------
echoinfo(){ echo -e "\\e[34m[INFO]\\e[0m $*"; }
echowarn(){ echo -e "\\e[33m[WARN]\\e[0m $*"; }
echoerr(){ echo -e "\\e[31m[ERROR]\\e[0m $*" >&2; }
confirm(){ 
  if [[ "$DEFAULT_FORCE" == "true" ]]; then return 0; fi
  read -r -p "$1 [y/N]: " ans
  [[ "$ans" =~ ^([yY][eE][sS]|[yY])$ ]]
}
require_cmd(){
  if ! command -v "$1" &>/dev/null; then
    echoerr "需要命令: $1，当前未安装或不在 PATH。"
    return 1
  fi
  return 0
}
ensure_root(){
  if [[ "$EUID" -ne 0 ]]; then
    echowarn "建议以 root 或 sudo 运行。本脚本将尝试使用 sudo 执行需要权限的操作。"
  fi
}

# -----------------------
# Parse args
# -----------------------
print_usage(){
  cat <<EOF
Usage: sudo ./install-harbor-enterprise.sh [options]

Options:
  --hostname <FQDN>         必填：Harbor 访问主机名 (eg. registry.example.com)
  --admin-pass <pass>       管理员密码（若不提供将随机生成并显示）
  --local-pkg <path>        离线包路径（.tgz），优先使用本地包（支持离线环境）
  --version <tag>           指定 Harbor 版本 tag（如 v2.7.0），仅在线模式有效
  --https                   启用 HTTPS（若不提供证书，将生成自签名证书）
  --cert <path>             指定已有证书文件（PEM）
  --key <path>              指定已有私钥文件（PEM）
  --with-trivy              启用 Trivy（容器安全扫描）
  --install-dir <path>      更改安装目录（默认: /opt/harbor）
  --force                   不交互，默认使用
  --dry-run                 仅显示将要执行的步骤，不实际执行
  -h, --help                显示帮助
EOF
}

# read args
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --hostname) HOSTNAME="$2"; shift 2;;
    --admin-pass) DEFAULT_ADMIN_PASS="$2"; shift 2;;
    --local-pkg) DEFAULT_LOCAL_PKG="$2"; shift 2;;
    --version) DEFAULT_VERSION="$2"; shift 2;;
    --https) DEFAULT_WITH_HTTPS=true; shift ;;
    --cert) DEFAULT_CERT="$2"; shift 2;;
    --key) DEFAULT_KEY="$2"; shift 2;;
    --with-trivy) DEFAULT_WITH_TRIVY=true; shift ;;
    --install-dir) DEFAULT_INSTALL_DIR="$2"; shift 2;;
    --force) DEFAULT_FORCE=true; shift ;;
    --dry-run) DEFAULT_DRY_RUN=true; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

if [[ -z "${HOSTNAME:-}" ]]; then
  echoerr "必须通过 --hostname 指定 Harbor 的访问主机名（FQDN）。"
  print_usage
  exit 2
fi

INSTALL_DIR="${DEFAULT_INSTALL_DIR%/}"
WITH_TRIVY="$DEFAULT_WITH_TRIVY"
DRY_RUN="$DEFAULT_DRY_RUN"
LOCAL_PKG="$DEFAULT_LOCAL_PKG"
WITH_HTTPS="$DEFAULT_WITH_HTTPS"
CERT_PATH="$DEFAULT_CERT"
KEY_PATH="$DEFAULT_KEY"

# -----------------------
# Safety: dry-run wrapper
# -----------------------
run_or_echo(){
  if [[ "$DRY_RUN" == "true" ]]; then
    echoinfo "[DRY-RUN] $*"
  else
    echoinfo "RUN: $*"
    eval "$@"
  fi
}

# -----------------------
# Environment detection
# -----------------------
detect_arch_os(){
  local uname_m
  uname_m="$(uname -m)"
  case "$uname_m" in
    x86_64) ARCH_TAG="amd64" ;;
    aarch64|arm64) ARCH_TAG="arm64" ;;
    *) echoerr "不支持的 CPU 架构: $uname_m"; exit 1 ;;
  esac
  echoinfo "检测到架构: $ARCH_TAG"

  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    case "${ID,,}" in
      ubuntu|debian) OS_FAMILY="debian" ;;
      centos|rhel|rocky|almalinux) OS_FAMILY="rhel" ;;
      *) echowarn "未识别的发行版: $ID. 尝试继续安装，但某些包管理器命令可能失败." ;;
    esac
  fi
  echoinfo "操作系统系列: ${OS_FAMILY:-unknown}"
}

# -----------------------
# Install/check dependencies
# -----------------------
install_dependencies(){
  echoinfo "检查并安装必要依赖：curl tar openssl wget"
  if [[ "$OS_FAMILY" == "debian" ]]; then
    run_or_echo "apt-get update -y"
    run_or_echo "apt-get install -y curl tar openssl wget ca-certificates apt-transport-https gnupg lsb-release"
  elif [[ "$OS_FAMILY" == "rhel" ]]; then
    run_or_echo "yum install -y curl tar openssl wget ca-certificates lsb-release"
  else
    echowarn "未明确支持的发行版，确保系统上安装 curl tar openssl docker"
  fi

  # docker 安装提示（不会强制覆盖现有 docker）
  if ! command -v docker &>/dev/null; then
    echoinfo "系统未检测到 docker，自动安装 Docker CE..."
    if [[ "$OS_FAMILY" == "debian" ]]; then
      run_or_echo "curl -fsSL https://get.docker.com | sh"
    elif [[ "$OS_FAMILY" == "rhel" ]]; then
      run_or_echo "curl -fsSL https://get.docker.com | sh"
    else
      echowarn "请手动安装 Docker（https://docs.docker.com/engine/install/）"
    fi
  else
    echoinfo "检测到 docker: $(docker --version | head -n1)"
  fi

  # docker compose: prefer 'docker compose' plugin, but ensure docker-compose compatibility
  if docker compose version &>/dev/null; then
    echoinfo "检测到 Docker Compose (v2 插件)"
  else
    if ! command -v docker-compose &>/dev/null; then
      echoinfo "安装 docker-compose (兼容模式)..."
      run_or_echo "curl -L \"https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose"
      run_or_echo "chmod +x /usr/local/bin/docker-compose"
    else
      echoinfo "检测到 docker-compose: $(docker-compose --version | head -n1)"
    fi
  fi

  # make sure docker is running
  if ! systemctl is-active --quiet docker 2>/dev/null; then
    echowarn "Docker 未处于运行态，尝试启动 docker 服务..."
    run_or_echo "systemctl enable --now docker"
  fi
}

# -----------------------
# Download Harbor package (在线 or 本地)
# -----------------------
fetch_harbor_pkg(){
  mkdir -p "$INSTALL_DIR"
  cd "$INSTALL_DIR"

  if [[ -n "$LOCAL_PKG" ]]; then
    if [[ ! -f "$LOCAL_PKG" ]]; then
      echoerr "指定的本地包不存在: $LOCAL_PKG"; exit 1
    fi
    PKG_FILE="$(basename "$LOCAL_PKG")"
    echoinfo "使用本地包: $LOCAL_PKG -> $INSTALL_DIR/$PKG_FILE"
    run_or_echo "cp -a \"$LOCAL_PKG\" \"$INSTALL_DIR/$PKG_FILE\""
    return 0
  fi

  # 在线模式：尝试获取 latest 或指定版本
  if [[ -n "$DEFAULT_VERSION" ]]; then
    TAG="$DEFAULT_VERSION"
  else
    echoinfo "尝试查询 GitHub release 最新版本..."
    if ! require_cmd curl; then echoerr "curl 未安装"; exit 1; fi
    TAG="$(curl -fsSL "$GITHUB_API_LATEST" | grep -m1 '"tag_name"' | cut -d\" -f4 || true)"
    if [[ -z "$TAG" ]]; then
      echowarn "无法通过 GitHub API 获取最新版本，请指定 --version 或使用 --local-pkg"
      exit 1
    fi
  fi
  echoinfo "选择版本: $TAG"

  PKG_FILE="harbor-offline-installer-${TAG}.tgz"
  DOWNLOAD_URL="https://github.com/goharbor/harbor/releases/download/${TAG}/${PKG_FILE}"
  echoinfo "下载: $DOWNLOAD_URL"
  run_or_echo "curl -L -o \"$INSTALL_DIR/$PKG_FILE\" \"$DOWNLOAD_URL\""
}

# -----------------------
# 校验包（基本校验）
# -----------------------
verify_pkg(){
  echoinfo "校验 Harbor 包完整性（基本校验：tar -tzf）..."
  if ! tar tzf "$INSTALL_DIR/$PKG_FILE" >/dev/null 2>&1; then
    echoerr "Harbor 包可能损坏：$INSTALL_DIR/$PKG_FILE"
    exit 1
  fi
  echoinfo "基本校验通过。"
  # 可选：如果用户传入 checksum 文件或想要更多校验，可在这里扩展
}

# -----------------------
# 解压与生成配置
# -----------------------
prepare_install_dir(){
  cd "$INSTALL_DIR"
  echoinfo "解压 Harbor 包到: $INSTALL_DIR"
  run_or_echo "tar xf \"$PKG_FILE\" -C \"$INSTALL_DIR\" --strip-components=1"
  if [[ ! -f "$INSTALL_DIR/install.sh" ]]; then
    echoerr "安装包解压后未找到 install.sh，请检查包是否为 Harbor 离线安装包。"; exit 1
  fi

  # 备份原有 harbor.yml（若存在）
  if [[ -f harbor.yml ]]; then
    echoinfo "发现现有 harbor.yml，备份至 harbor.yml.bak.$(date +%s)"
    run_or_echo "cp -a harbor.yml harbor.yml.bak.$(date +%s)"
  fi

  # 生成 harbor.yml 从模板（harbor.yml.tmpl）
  if [[ -f harbor.yml.tmpl ]]; then
    echoinfo "生成 harbor.yml 基于模板"
    run_or_echo "cp harbor.yml.tmpl harbor.yml"
    # 替换 hostname
    run_or_echo "sed -i \"s/^hostname:.*/hostname: ${HOSTNAME}/\" harbor.yml || true"
  else
    echowarn "未找到 harbor.yml.tmpl，请手动准备 harbor.yml"
  fi

  # admin 密码处理
  if [[ -z "$DEFAULT_ADMIN_PASS" ]]; then
    # 生成随机强密码
    DEFAULT_ADMIN_PASS="$(openssl rand -base64 18 | tr -dc 'A-Za-z0-9' | cut -c1-16)"
    echoinfo "未指定 admin 密码，已生成随机密码（请保存）"
  fi
  run_or_echo "sed -i \"s/^harbor_admin_password:.*/harbor_admin_password: ${DEFAULT_ADMIN_PASS}/\" harbor.yml || true"
}

# -----------------------
# TLS: 使用用户证书或生成自签
# -----------------------
setup_tls(){
  if [[ "$WITH_HTTPS" != "true" ]]; then
    echoinfo "不启用 HTTPS。若需启用请加 --https 参数。"
    return
  fi

  CERT_DIR="$INSTALL_DIR/certs"
  mkdir -p "$CERT_DIR"

  if [[ -n "$CERT_PATH" && -n "$KEY_PATH" ]]; then
    if [[ ! -f "$CERT_PATH" || ! -f "$KEY_PATH" ]]; then
      echoerr "指定的证书或私钥不存在: $CERT_PATH , $KEY_PATH"; exit 1
    fi
    echoinfo "使用用户提供的证书: $CERT_PATH"
    run_or_echo "cp -a \"$CERT_PATH\" \"$CERT_DIR/$(basename $CERT_PATH)\""
    run_or_echo "cp -a \"$KEY_PATH\" \"$CERT_DIR/$(basename $KEY_PATH)\""
    TLS_CERT="$CERT_DIR/$(basename $CERT_PATH)"
    TLS_KEY="$CERT_DIR/$(basename $KEY_PATH)"
  else
    echoinfo "未提供证书，生成自签名证书（仅建议测试/内网使用）..."
    TLS_CERT="$CERT_DIR/$HOSTNAME.crt"
    TLS_KEY="$CERT_DIR/$HOSTNAME.key"
    if [[ ! -f "$TLS_CERT" || ! -f "$TLS_KEY" ]]; then
      echoinfo "生成自签名证书: $TLS_CERT, $TLS_KEY"
      run_or_echo "openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout \"$TLS_KEY\" -out \"$TLS_CERT\" -subj \"/C=CN/ST=Beijing/L=Beijing/O=Company/OU=DevOps/CN=${HOSTNAME}\""
    else
      echoinfo "已存在自签证书，复用。"
    fi
  fi

  # 将 harbor.yml 的证书配置注释/替换（多版本 harbor.yml 格式可能不同）
  # 我们优先采用 https 前端证书配置：certificate & private_key
  if grep -q "certificate:" harbor.yml 2>/dev/null || grep -q "private_key:" harbor.yml 2>/dev/null; then
    run_or_echo "sed -i \"s|certificate: .*|certificate: ${TLS_CERT}|g\" harbor.yml || true"
    run_or_echo "sed -i \"s|private_key: .*|private_key: ${TLS_KEY}|g\" harbor.yml || true"
  else
    # 某些模板中直接使用 "protocol: https" & tls related keys - we try to add
    cat >> harbor.yml <<EOF

# --- 自动附加 TLS（由 install-harbor-enterprise.sh 添加） ---
protocol: https
certificate: ${TLS_CERT}
private_key: ${TLS_KEY}
EOF
  fi

  echoinfo "TLS 设置已完成，证书路径: $TLS_CERT"
}

# -----------------------
# Firewall / SELinux related hints
# -----------------------
configure_firewall(){
  echoinfo "检查并提示防火墙规则（若使用 firewalld 则尝试开放 80/443/4443）"
  if command -v firewall-cmd &>/dev/null && systemctl is-active --quiet firewalld; then
    echoinfo "检测到 firewalld，尝试开放端口 80/443/4443"
    run_or_echo "firewall-cmd --permanent --add-port=80/tcp"
    run_or_echo "firewall-cmd --permanent --add-port=443/tcp"
    run_or_echo "firewall-cmd --permanent --add-port=4443/tcp || true"
    run_or_echo "firewall-cmd --reload"
  else
    echowarn "未检测到 firewalld 或未运行，请根据需要开放 80/443/4443 端口"
  fi
  if command -v setenforce &>/dev/null; then
    echowarn "如果启用了 SELinux（Enforcing），请确保 Docker 与 Harbor 的目录策略正确，或临时设置为 permissive：setenforce 0（仅测试）"
  fi
}

# -----------------------
# Run installer
# -----------------------
run_installer(){
  cd "$INSTALL_DIR"
  INSTALL_ARGS=()
  if [[ "$WITH_TRIVY" == "true" ]]; then INSTALL_ARGS+=( "--with-trivy" ); fi

  echoinfo "准备执行 Harbor 安装脚本 install.sh ${INSTALL_ARGS[*]}"
  if ! confirm "确认开始安装 Harbor 到 $INSTALL_DIR ?"; then
    echoinfo "取消安装。"
    exit 0
  fi

  # mark timestamps for possible rollback/debug
  run_or_echo "cp -a harbor.yml harbor.yml.preinstall.$(date -u +%s)"

  # run install
  run_or_echo "chmod +x ./install.sh"
  run_or_echo "yes | ./install.sh ${INSTALL_ARGS[*]}"  # yes | 以防脚本交互（取决于版本）
}

# -----------------------
# Post-install validation
# -----------------------
post_install_validate(){
  echoinfo "安装后检查：docker 容器状态与端口监听"
  if ! docker ps --format '{{.Names}} {{.Status}}' | grep -E 'goharbor|harbor' >/dev/null 2>&1; then
    echoerr "未检测到 Harbor 相关容器运行，尝试查看最近容器状态："
    docker ps -a | sed -n '1,120p'
    exit 1
  fi
  echoinfo "检测到 Harbor 容器正在运行。"
  echoinfo "检查端口 80/443/4443:"
  ss -tlnp | grep -E ':(80|443|4443)\s' || echowarn "未检测到端口监听，请确认 install.sh 是否完成。"
  echoinfo "默认管理员账号：admin，密码：${DEFAULT_ADMIN_PASS}"
  echoinfo "请务必登录 ${HOSTNAME} 并立即修改 admin 密码。"
}

# -----------------------
# Main
# -----------------------
main(){
  ensure_root
  detect_arch_os
  install_dependencies
  fetch_harbor_pkg
  verify_pkg

  echoinfo "安装目录: $INSTALL_DIR"
  prepare_install_dir
  setup_tls
  configure_firewall
  run_installer
  post_install_validate

  echoinfo "部署完成——总结："
  echo "  Harbor 访问地址: https://${HOSTNAME}"
  echo "  管理员: admin"
  echo "  初始密码: ${DEFAULT_ADMIN_PASS}"
  echo "  安装目录: ${INSTALL_DIR}"
  echo "  注意: 若使用自签名证书，请在客户端（docker）上添加 CA 或设置 insecure-registries（仅内网/测试）"
}

# -----------------------
# Start
# -----------------------
main "$@"
