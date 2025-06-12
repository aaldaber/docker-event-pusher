#!/bin/bash

PUSHGATEWAY_URL=${PUSHGATEWAY_URL:-http://pushgateway.example.com:9091}
PUSHGATEWAY_USER=${PUSHGATEWAY_USER:-your_username}
PUSHGATEWAY_PASS=${PUSHGATEWAY_PASS:-your_password}

AUTH_HEADER=$(echo -n "$PUSHGATEWAY_USER:$PUSHGATEWAY_PASS" | base64)

docker events --filter 'event=start' --format '{{.Time}} {{.Actor.Attributes.name}}' |
while read timestamp container_name; do
  echo "container_start_total{container=\"$container_name\"} 1" | \
  curl --data-binary @- \
       -H "Authorization: Basic $AUTH_HEADER" \
       "$PUSHGATEWAY_URL/metrics/job/container_start/instance/$container_name"
done
