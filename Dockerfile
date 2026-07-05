FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app

RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin && \
    ls -l /usr/local/bin && \
    if [ -f /usr/local/bin/cli-proxy-api ]; then mv /usr/local/bin/cli-proxy-api /usr/local/bin/cliproxy; \
    elif [ -f /usr/local/bin/server ]; then mv /usr/local/bin/server /usr/local/bin/cliproxy; \
    elif [ -f /usr/local/bin/CLIProxyAPI ]; then mv /usr/local/bin/CLIProxyAPI /usr/local/bin/cliproxy; \
    else echo "binary not found, contents:" && ls -R /usr/local/bin && exit 1; fi

RUN mkdir -p /app/logs
EXPOSE 8317
CMD ["/usr/local/bin/cliproxy","--config","/app/config.yaml"]
