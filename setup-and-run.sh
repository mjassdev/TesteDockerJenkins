#!/usr/bin/env bash

dockerhub_user=matheusjose

jenkins_port=8080
image_name=ci-jenkins
image_version=2.2.2
container_name=jenkins2.2.2

docker pull jenkins:2.112

docker stop ${container_name}

docker build --no-cache -t ${dockerhub_user}/${image_name}:${image_version} . 

if [ ! -d m2deps ]; then
    mkdir m2deps
fi
if [ -d jobs ]; then
    rm -rf jobs
fi
if [ ! -d jobs ]; then
    mkdir jobs
fi

docker run -p ${jenkins_port}:8080 \
    -v `pwd`/jobs:/var/jenkins_home/jobs/ \
    -v `pwd`/m2deps:/var/jenkins_home/.m2/repository/ \
    --rm --name ${container_name} \
    ${dockerhub_user}/${image_name}:${image_version}
