FROM sancraftdev/cloudflared:latest

RUN apk upgrade --no-cache
RUN apk add --no-cache ca-certificates wget curl bind-tools

ENV upstream=https://dns.adguard-dns.com/dns-query

LABEL org.opencontainers.image.source="https://github.com/SanCraftDev/cloudflared-dns"
ENTRYPOINT cloudflared --no-autoupdate --metrics localhost:9133 proxy-dns --address 0.0.0.0 --upstream ${upstream}

HEALTHCHECK CMD (dig example.com @127.0.0.1 && curl -skI localhost:9133) || exit 1
