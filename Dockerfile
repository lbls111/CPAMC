FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz | tar -xz -C /usr/local/bin && mv /usr/local/bin/cli-proxy-api /usr/local/bin/cliproxy
WORKDIR /app

# 【修正】：使用正确的 remote-management 字段来开启远程访问和设置密码
RUN printf 'port: 8317\n\
host: 0.0.0.0\n\
remote-management:\n\
  allow-remote: true\n\
  secret-key: "123456"\n' > /app/config.yaml

EXPOSE 8317
CMD ["/usr/local/bin/cliproxy","-config","/app/config.yaml"]
