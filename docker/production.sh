#!/bin/bash

serviceName=$(cat config/service-name.txt)
serviceName=${serviceName,,}
directory="docker"
webport=$(cat config/webport.txt)
typeset -i buildCount=$(cat config/version.txt)
echo "Running deployed version $buildCount of $serviceName...";
#download the binary image from crypt if the local image doesn't exist
if [[ "$(docker images -q $serviceName:$buildCount 2> /dev/null)" == "" ]]; then
    echo "Download the binary from crypt..."
    cd ~/crypt;
    ./down.sh $serviceName-$buildCount.tar $serviceName-$buildCount.tar
    mv $serviceName-$buildCount.tar ~/$serviceName/$directory/$serviceName-$buildCount.tar
    echo "Loading binary into docker image..."
    cd ~/$serviceName/$directory
    docker load < $serviceName-$buildCount.tar
    echo "Cleaning up..."
    rm -f $serviceName-$buildCount.tar
fi
echo "Running docker image $serviceName:$buildCount"
docker rm -f "$serviceName"
#check for token.txt which is needed to add the mm360v2nodeApi module
FILETOKEN="config/token.txt"
FILETOKENSTRING=$(cat config/token.txt)
FILETOKENSTRINGLEN=${#FILETOKENSTRING}
if [ -f $FILETOKEN ] && [ "$FILETOKENSTRINGLEN" -gt 0 ]
then
   echo "File $FILETOKEN exists and is not empty, clearing token.txt..."
   echo "">$FILETOKEN
else
   echo "File $FILETOKEN does not exist or is empty no worries..."
fi
docker run --name="$serviceName" \
-p $webport:$webport \
-v /${PWD}/../://root/app \
-d $serviceName:$buildCount