FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz | tar -xz -C /usr/local/bin && mv /usr/local/bin/cli-proxy-api /usr/local/bin/cliproxy
WORKDIR /app

# 【新增这一行】：把代码仓库里的 config.yaml 复制到容器的 /app/ 目录下
COPY config.yaml /app/config.yaml 

EXPOSE 8317
CMD ["/usr/local/bin/cliproxy","-config","/app/config.yaml"]
