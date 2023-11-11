#!/bin/bash

# Install a few tools
apt-get install wget

# Install Jfrog CLI
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog\_public\_gpg.key | apt-key add -
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | tee -a /etc/apt/sources.list;
apt update;
apt install -y jfrog-cli-v2;
jfrog --version

# Create a Docker volume for Jenkins data
docker volume create jenkins-data
docker network create jenkins-network

# Run the jenkins-docker container with a mounted volume for data persistence
docker run --name jenkins-docker --network jenkins-network -d \
 -u root -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock \
 -v jenkins-data:/var/jenkins_home \
 cloudsheger/jenkins-docker-latest:latest
