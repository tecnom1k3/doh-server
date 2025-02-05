#!/usr/bin/env sh
exec /opt/app/doh-proxy --listen-address "$LISTEN_ADDRESS" --hostname "$DOH_HOSTNAME" --server-address "$SERVER_ADDRESS"
