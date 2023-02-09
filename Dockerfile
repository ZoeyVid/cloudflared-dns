FROM zoeyvid/cloudflared

RUN apk upgrade --no-cache && \
    apk add --no-cache ca-certificates wget tzdata curl bind-tools

ENTRYPOINT ["cloudflared", "--no-autoupdate", "--metrics", "localhost:9172", "proxy-dns", "--address", "0.0.0.0"]
HEALTHCHECK CMD (dig example.com @127.0.0.1 && curl -skI localhost:9172) || exit 1
