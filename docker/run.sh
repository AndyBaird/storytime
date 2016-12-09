#!/bin/bash
./build.sh
serviceName=$(cat config/service-name.txt)
serviceName=${serviceName,,}
webport=$(cat config/webport.txt)
#remove existing container
docker rm -f $serviceName;
#run
docker run --name="$serviceName" -p $webport:$webport -v /${PWD}/../://root/app -d $serviceName | xargs docker logs -f
