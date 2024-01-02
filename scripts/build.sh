#!/bin/bash

#if [ $# -eq 0 ]; then
#    printf "Usage: \n\n\t. build.sh /path/to/llama/model \n\n"
#    return
#fi

#echo "LLaMa model path: $1";

docker container stop deception-db
docker container prune 
# docker image rm deception-db:latest
sudo rm -r mount

docker build --tag deception-db:latest . #--build-arg="LLAMA_MODELS_PATH=$1"  