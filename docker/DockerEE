#!/bin/bash

# replace the below sample URL with your's
DOCKER_EE_URL="https://storebits.docker.com/ee/trial/sub-c12cb585-d245-4d63-a1bf-04f69a8967ce"
DOCKER_EE_VERSION=18.09

## Install required packages
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

## Add the GPG and apt repository using your Docker EE URL
curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -
sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] $DOCKER_EE_URL/ubuntu $(lsb_release -cs) stable-$DOCKER_EE_VERSION"

## Install Docker EE
sudo apt-get update
sudo apt-get install -y docker-ee=5:18.09.4~3-0~ubuntu-bionic
