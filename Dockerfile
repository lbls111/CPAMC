FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl ca-certificates supervisor && rm -rf /var/lib/apt/lists/*

# CLIProxyAPI
RUN curl -L https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.2.47/CLIProxyAPI_7.2.47_linux_amd64.tar.gz \
  | tar -xz -C /usr/local/bin && mv /usr/local/bin/cli-proxy-api /usr/local/bin/cliproxy

# Dashboard
RUN curl -L https://github.com/0xAstroAlpha/cliProxyAPI-Dashboard/releases/latest/download/dashboard-linux-amd64 \
  -o /usr/local/bin/dashboard && chmod +x /usr/local/bin/dashboard

RUN mkdir -p /etc/supervisor/conf.d && \
  printf '[supervisord]\nnodaemon=true\n[program:cliproxy]\ncommand=/usr/local/bin/cliproxy -c /app/config.yaml\nautorestart=true\n[program:dashboard]\ncommand=/usr/local/bin/dashboard --cpa-url http://localhost:8317 --port 3000\nautorestart=true\n' \
  > /etc/supervisor/conf.d/supervisord.conf

WORKDIR /app
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
