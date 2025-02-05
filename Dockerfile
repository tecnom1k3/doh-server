FROM alpine:latest AS compiler

RUN apk add rust cargo

RUN cargo install --root /opt/doh-proxy doh-proxy --no-default-features

FROM alpine:latest AS doh-alpine

RUN apk add libgcc && \
    rm -rf /var/cache/apk/*

WORKDIR /opt/app

RUN adduser -S -H -s /sbin/nologin doh-proxy

USER doh-proxy

COPY --from=compiler --chown=doh-proxy:doh-proxy /opt/doh-proxy/bin/doh-proxy ./

COPY --chown=doh-proxy:doh-proxy entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

EXPOSE 3000

# Use the exec form for the ENTRYPOINT so signals are handled properly.
ENTRYPOINT ["./entrypoint.sh"]
