#!/bin/bash

listen_addr="$(ip addr show eth1 | grep 'inet' | cut -d: -f2 | awk '{print $2}' | sed s@/16@@)"
docker swarm join \
  --token "$(etcdctl get /docker/swarm/join-token/worker)" \
  --listen-addr "$listen_addr" \
  "$(etcdctl get /docker/swarm/advertise-addr):2377"
