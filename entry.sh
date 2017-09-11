#!/bin/sh

#GIT_REPO=$1
#GIT_DIR=$2

# We do it this way so that we can abstract if from just git later on
GIT_DIR_VC_DIR=$GIT_DIR/.git

echo $GIT_DIR_VC_DIR
echo $GIT_REPO
echo $GIT_DIR

if [ ! -d $GIT_DIR_VC_DIR ]
then
    git clone $GIT_REPO $GIT_DIR
    cd $GIT_DIR
    moonc .
else
    cd $GIT_DIR
    git pull $GIT_REPO
    moonc .
fi


/usr/local/openresty/luajit/bin/lapis "$@"

#while :; do
    #sleep 300
#done
