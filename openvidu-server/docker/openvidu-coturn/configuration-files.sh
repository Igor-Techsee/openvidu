#!/bin/bash

# Enable turn
cat>/etc/default/coturn<<EOF
TURNSERVER_ENABLED=1
EOF

# Turn server configuration
cat>/etc/turnserver.conf<<EOF
external-ip=${TURN_PUBLIC_IP}
tls-listening-port=443=${TURN_LISTEN_PORT}
fingerprint
lt-cred-mech
max-port=${MAX_PORT:-65535}
min-port=${MIN_PORT:-40000}
pidfile="/var/run/turnserver.pid"
realm=techsee.me
redis-userdb="ip=${REDIS_IP} dbname=${DB_NAME} password=${DB_PASSWORD} connect_timeout=30"
verbose
no-udp
no-dtls
no-tcp-relay
stale-nonce
cert=/usr/local/etc/techsee.me.chained.crt
pkey=/usr/local/etc/techsee.me.key
cipher-list="EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH"
dh-file=/usr/local/etc/dhparams.pem
no-stdout-log
log-file=/var/log/turn/turn.log
no-stun
no-loopback-peers
no-multicast-peers
no-tlsv1
no-tlsv1_1
no-http
EOF
