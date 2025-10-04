FROM python:3.11

ENV HOME="/root" \
    DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装工具，同时清理缓存以减小镜像体积
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl && \
    rm -rf /var/lib/apt/lists/*

# 启动命令
CMD ["sleep", "360000"]