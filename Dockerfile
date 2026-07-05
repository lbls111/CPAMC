FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl ca-certificates supervisor && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz \
  | tar -xz -C /usr/local/bin && mv /usr/local/bin/cli-proxy-api /usr/local/bin/cliproxy

RUN curl -L https://github.com/0xAstroAlpha/cliProxyAPI-Dashboard/releases/latest/download/dashboard-linux-amd64 -o /usr/local/bin/dashboard \
  && chmod +x /usr/local/bin/dashboard

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
WORKDIR /app
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
