FROM golang:alpine AS builder

# v2.2.0-rc.2
ARG CADDY_VERSION=master

RUN apk add --no-cache git \
    && go get -u github.com/caddyserver/xcaddy/cmd/xcaddy \
    && xcaddy build \
    --output /usr/bin/caddy \
    --with github.com/mholt/caddy-webdav \
    --with github.com/caddy-dns/cloudflare

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
