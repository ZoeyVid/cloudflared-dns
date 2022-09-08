FROM sancraftdev/cloudflared:latest

ENV upstream=https://dns.adguard-dns.com/dns-query

LABEL org.opencontainers.image.source="https://github.com/SanCraftDev/cloudflared-dns"
ENTRYPOINT cloudflared --no-autoupdate proxy-dns --address 0.0.0.0 --upstream ${upstream}

HEALTHCHECK CMD dig example.com @127.0.0.1 || exit 1
