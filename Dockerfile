FROM python:3.11

ENV HOME="/root" \
    DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装工具和nginx，同时清理缓存以减小镜像体积
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    nginx && \
    rm -rf /var/lib/apt/lists/*

# 创建nginx默认站点目录
RUN mkdir -p /app/www

# 配置nginx默认站点
RUN echo 'server {' > /etc/nginx/sites-available/default && \
    echo '    listen 80 default_server;' >> /etc/nginx/sites-available/default && \
    echo '    listen [::]:80 default_server;' >> /etc/nginx/sites-available/default && \
    echo '    root /app/www;' >> /etc/nginx/sites-available/default && \
    echo '    index index.html index.htm index.nginx-debian.html;' >> /etc/nginx/sites-available/default && \
    echo '    server_name _;' >> /etc/nginx/sites-available/default && \
    echo '    location / {' >> /etc/nginx/sites-available/default && \
    echo '        try_files $uri $uri/ =404;' >> /etc/nginx/sites-available/default && \
    echo '    }' >> /etc/nginx/sites-available/default && \
    echo '}' >> /etc/nginx/sites-available/default

# 创建一个默认的index.html文件
RUN echo '<html><head><title>Welcome to nginx!</title></head><body><h1>Welcome to nginx!</h1><p>If you see this page, the nginx web server is successfully installed and working.</p></body></html>' > /app/www/index.html

# 暴露80端口
EXPOSE 80

# 启动nginx服务
CMD ["nginx", "-g", "daemon off;"]