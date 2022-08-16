FROM --platform=${BUILDPLATFORM} golang:1.19.0-alpine3.16 as build

ARG CLOUDFLARED_VERSION=2022.8.1

ARG GO111MODULE=on
ARG CGO_ENABLED=0
ARG TARGETARCH
ARG TARGETOS
    
RUN apk add --no-cache ca-certificates git build-base
RUN git clone --recursive https://github.com/cloudflare/cloudflared --branch ${CLOUDFLARED_VERSION} /src
WORKDIR /src
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} make -j "$(nproc)" cloudflared

FROM busybox:1.35.0
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /src/cloudflared /usr/local/bin/cloudflared

LABEL org.opencontainers.image.source="https://github.com/SanCraftDev/cloudflared-dns"
ENTRYPOINT cloudflared --no-autoupdate proxy-dns --upstream ${upstream}
