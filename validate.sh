#!/usr/bin/env bash
[[ $1 == "" ]] && echo "Usage: ./validate.sh [option] [filename]
Options:
        --install   install npm dependency (http-server)
" && exit
[[ $1 == "--install" ]] && npm install -g http-server && [[ $2 == "" ]] && exit
http-server&
sleep 2
docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 oasnet
docker run -it --rm --net=oasnet usabillabv/openapi3-validator "http://192.168.0.1:8080/${1}"
docker network rm oasnet
kill $!