#!/bin/bash
./build.sh
serviceName=$(cat config/service-name.txt)
serviceName=${serviceName,,}
directory="docker"
typeset -i buildCount=$(cat config/version.txt)
buildCount=$buildCount+1
echo $buildCount>version.txt
#check for token.txt which is needed to add the mm360v2nodeApi module
FILETOKEN="config/token.txt"
FILETOKENSTRING=$(cat config/token.txt)
FILETOKENSTRINGLEN=${#FILETOKENSTRING}
if [ -f $FILETOKEN ] && [ "$FILETOKENSTRINGLEN" -gt 0 ]
then
   echo "File $FILETOKEN exists, clearing token.txt..."
   echo "">$FILETOKEN
else
   echo "File $FILETOKEN does not exist or is empty no worries..."
fi
echo "Tagging service as version $buildCount...";
docker tag $serviceName $serviceName:$buildCount
echo "Dumping $serviceName image to binary version $buildCount...";
docker save "$serviceName:$buildCount" > "$serviceName-$buildCount".tar
echo "Upload the binary to crypt..."
mv $serviceName-$buildCount.tar ~/crypt/
cd ~/crypt;
./up.sh $serviceName-$buildCount.tar $serviceName-$buildCount.tar
echo "Cleaning up..."
rm -f $serviceName-$buildCount.tar
