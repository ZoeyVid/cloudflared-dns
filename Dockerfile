FROM --platform=${BUILDPLATFORM} golang:1.19.0-alpine3.16 as build

ARG CLOUDFLARED_VERSION=2022.8.2

ARG GO111MODULE=on
ARG CGO_ENABLED=0
ARG TARGETARCH
ARG TARGETOS
    
RUN apk add --no-cache ca-certificates git build-base
RUN git clone --recursive https://github.com/cloudflare/cloudflared --branch ${CLOUDFLARED_VERSION} /src
WORKDIR /src
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} make -j "$(nproc)" cloudflared

FROM alpine:3.16.2
RUN apk add --no-cache ca-certificates bind-tools

COPY --from=build /src/cloudflared /usr/local/bin/cloudflared

ENV upstream=https://dns.adguard-dns.com/dns-query

LABEL org.opencontainers.image.source="https://github.com/SanCraftDev/cloudflared-dns"
ENTRYPOINT cloudflared --no-autoupdate proxy-dns --address 0.0.0.0 --upstream ${upstream}

HEALTHCHECK CMD dig example.com @127.0.0.1 || exit 1
