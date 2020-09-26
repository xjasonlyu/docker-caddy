FROM golang:alpine AS builder

ARG CADDY_VERSION
# Configures xcaddy to not clean up post-build (unnecessary in a container)
ENV XCADDY_SKIP_CLEANUP=1

RUN apk add --no-cache git \
    && go get -u github.com/caddyserver/xcaddy/cmd/xcaddy \
    && xcaddy build \
    --output /usr/bin/caddy \
    --with github.com/mholt/caddy-webdav \
    --with github.com/caddy-dns/cloudflare

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
