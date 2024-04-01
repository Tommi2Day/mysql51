#!/bin/bash
#
# mysql51 docker container starter


#define variables
if [ -r run.vars ]; then
	source run.vars
fi

#set defaults if needed
VMNAME=${VMNAME:-mysql51}
DOCKER_SHARED=${DOCKER_SHARED:-$(pwd)}
SHARED_DIR=${DOCKER_SHARED}/${VMNAME}-shared
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-mysql51}
EXT_DB_PORT=${EXT_DB_PORT:-32306}

#debug
if [ -z "$DEBUG" ]; then
	RUN="-d "
else
	RUN="--rm=true -it --entrypoint bash "

fi

#docker volumes on windows need this extra slash
if [ "$OSTYPE" = "msys" ]; then
	P=/
fi


#stop existing container
docker stop $VMNAME >/dev/null 
docker rm $VMNAME >/dev/null

if [ "$1" = "clean" ]; then
	#clean all if debug set to clean
	rm -Rf ${SHARED_DIR}
fi

#create shared directories
if [ ! -d  ${SHARED_DIR} ]; then
		mkdir -p ${SHARED_DIR}
fi

#run it
docker run --name $VMNAME \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
-v $P${SHARED_DIR}:/db \
-p ${EXT_DB_PORT}:3306 \
$RUN \
tommi2day/mysql51

