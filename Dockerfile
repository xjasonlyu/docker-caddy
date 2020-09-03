FROM caddy:builder AS builder

ENV CADDY_SOURCE_VERSION=master

RUN caddy-builder \
    github.com/mholt/caddy-webdav \
    github.com/caddy-dns/cloudflare

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
