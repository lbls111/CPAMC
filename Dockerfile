FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz | tar -xz -C /usr/local/bin
RUN mkdir -p /app/logs
EXPOSE 8317
CMD ["/usr/local/bin/server","--config","/app/config.yaml"]
