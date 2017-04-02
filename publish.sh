#!/usr/bin/env bash

DOCKER_REGISTRY_TEST="127.0.0.1:5001"
DOCKER_REPOSITORY="food_web"
DOCKER_TAG="v1.0.1"

if [[ `docker images -a | grep $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY` ]];then
    if [[ `docker ps -a | grep $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY:$DOCKER_TAG` ]];then
        docker rm -f $(docker ps -a|grep $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY:$DOCKER_TAG|awk '{printf $1}'|cut -d/ -f1)
    fi
    docker rmi $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY:$DOCKER_TAG
fi
mvn clean install -Ptest -Dmaven.test.skip=true -Ddocker.registry=$DOCKER_REGISTRY_TEST -Ddocker.repository=$DOCKER_REPOSITORY -Ddocker.tag=$DOCKER_TAG
#docker run -d -p 8080:80 -v /var/log/case_webapp:/var/log/case_webapp --restart=always $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY:$DOCKER_TAG
docker run -d -p 80:8080 --restart=always $DOCKER_REGISTRY_TEST/$DOCKER_REPOSITORY:$DOCKER_TAG