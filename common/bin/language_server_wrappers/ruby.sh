#!/bin/bash

bundle exec solargraph

#docker-compose \
#    --file ~/------/dev-tools/docker/docker-compose.yml \
#    --project-directory ~/vinted/dev-tools/docker/ \
#    run -T -v "core-sync:$HOME/vinted/core" -w "$PWD" \
#    core solargraph stdio

#docker-compose \
#    --file ~/------/dev-tools/docker/docker-compose.yml \
#    --project-directory ~/vinted/dev-tools/docker/ \
#    run -p 7658:7658 -T -v all-vinted-sync:$HOME/vinted \
#    core bundle exec solargraph socket --host=0.0.0.0
