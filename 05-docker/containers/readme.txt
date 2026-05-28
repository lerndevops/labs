# Docker Basics & Advanced Commands Guide

## Introduction
There are many Docker images available on Docker Hub that can be pulled and used to create containers.

Docker Hub: https://hub.docker.com

---

# Docker Image Management

## Search for Docker Images
```bash
docker search <image-name>
```

Search for Docker images from the command line.

### Example
```bash
docker search nginx
```

---

## Pull a Docker Image
```bash
docker pull <image-name>
```

Download a Docker image from Docker Hub.

### Example
```bash
docker pull nginx
```

---

## List Docker Images
```bash
docker images
```

Display all Docker images available on the local machine.

---

## View Image History
```bash
docker history <image-name>
```

View the layers and changes made to the Docker image.

### Example
```bash
docker history nginx
```

---

## Inspect Docker Image
```bash
docker inspect <image-name>
```

Display detailed information about the image in JSON format.

### Example
```bash
docker inspect nginx
```

---

## Remove Docker Image
```bash
docker rmi <image-name>
```

Remove a Docker image from the local machine.

### Example
```bash
docker rmi nginx
```

---

## Remove Unused Images
```bash
docker image prune
```

Remove all unused Docker images.

---

# Running Docker Containers

## Container Run Modes

### Interactive Mode (`-it`)
- Creates a new container
- Opens an interactive terminal inside the container

### Detached Mode (`-d`)
- Creates a new container
- Runs the container in the background

---

## Run Container in Detached Mode
```bash
docker run -d nginx
```

---

## Run Container in Interactive Mode
```bash
docker run -it nginx bash
```

---

## List Running Containers
```bash
docker ps
```

---

## List All Containers
```bash
docker ps -a
```

---

# Container Lifecycle Commands

## Stop a Container
```bash
docker stop <container-id>
```

## Start a Stopped Container
```bash
docker start <container-id>
```

## Restart a Container
```bash
docker restart <container-id>
```

## Inspect a Container
```bash
docker inspect <container-id>
```

## Remove a Stopped Container
```bash
docker rm <container-id>
```

## Force Remove a Running Container
```bash
docker rm -f <container-id>
```

## Remove All Stopped Containers
```bash
docker container prune
```

---

# Accessing a Running Container

## Step 1
```bash
docker run -d nginx
```

## Step 2
```bash
docker ps
```

## Step 3
```bash
docker exec -it <container-id> bash
```

---

# Exit From a Container

```text
Ctrl + P + Q
```

This detaches from the container without stopping it.

---

# Port Publishing

## Dynamic Port Mapping (`-P`)
```bash
docker run -d -P nginx
```

Check mapping:
```bash
docker ps
```

Example access:
```text
http://52.14.62.88:32768
```

---

## Manual Port Mapping (`-p`)
```bash
docker run -d -p 1234:80 nginx
```

Format:
```text
host-port:container-port
```

Example access:
```text
http://52.14.62.88:1234
```

---

# Advanced Docker Commands

## Limit Memory Usage
```bash
docker run -d \
  --restart unless-stopped \
  -p 8080:80 \
  --memory 500M \
  --memory-reservation 256M \
  nginx
```

---

## Limit CPU Usage
```bash
docker run -d -P --cpus="0.5" nginx
```

---

# Configure Logging
```bash
docker run \
  --log-driver json-file \
  --log-opt max-size=50m \
  nginx
```

---

# Docker Networking

## Disconnect from Network
```bash
docker network disconnect bridge <container-id>
```

## Connect to Network
```bash
docker network connect myb <container-id>
```

## Run in Specific Network
```bash
docker run -itd --net net1 alpine
```

## Connect to Additional Network
```bash
docker network connect net2 <container-id>
```

---

# Restart Policies

## no
Never restart the container.

## on-failure
Restart only if the container exits with a non-zero exit code.

## always
Always restart the container and restart after Docker daemon startup.

## unless-stopped
Always restart unless manually stopped.

---

# Quick Reference

| Purpose | Command |
|---|---|
| Search image | `docker search nginx` |
| Pull image | `docker pull nginx` |
| List images | `docker images` |
| Run container | `docker run -d nginx` |
| List containers | `docker ps` |
| Stop container | `docker stop <id>` |
| Remove container | `docker rm <id>` |
| Remove image | `docker rmi nginx` |
| Access shell | `docker exec -it <id> bash` |

