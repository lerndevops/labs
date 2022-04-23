#!/bin/bash

VERSION=2.1.0
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs, "arm64" for ARM 64.

wget https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz -P /tmp

tar -xzf /tmp/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz -C /usr/bin
chmod 755 /usr/bin/docker-credential-gcr
