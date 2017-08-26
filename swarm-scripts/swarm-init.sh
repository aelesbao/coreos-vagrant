#!/bin/bash

set -e

advertise_addr="$(ip addr show eth1 | grep 'inet' | cut -d: -f2 | awk '{print $2}' | sed s@/16@@)"
etcdctl set /docker/swarm/advertise-addr "$advertise_addr"

docker swarm init --advertise-addr "$advertise_addr"
etcdctl set /docker/swarm/join-token/manager "$(docker swarm join-token -q manager)"
etcdctl set /docker/swarm/join-token/worker "$(docker swarm join-token -q worker)"
