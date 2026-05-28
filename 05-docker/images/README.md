# What are Docker Images?

A Docker image is a package that contains:

- An application
- Application dependencies
- Required libraries
- Runtime environment
- Configuration files

These images are used to create Docker containers.

---

# How to Build Docker Images

There are two ways to build Docker images:

1. Manual Process
2. Automated Process (Recommended)

---

# 1. Manual Docker Image Build Process

## Steps

1. Choose a base image
2. Run the image as a container in interactive mode
3. Make necessary changes inside the container
4. Exit safely from the container
5. Commit the changes as a new Docker image

---

## Example

### Pull Ubuntu Image
```bash
docker pull ubuntu
```

---

### Run Ubuntu Container
```bash
docker run -it ubuntu bash
```

---

## Make Changes Inside Container
```bash
apt-get update
apt-get install -y nginx
apt-get install -y vim
mkdir /home/configuration
touch /home/configuration/db.props
```

---

## Edit HTML File
```bash
vi /var/www/html/index.html
```

Edit and save the file.

---

## Exit Container Safely
```text
Ctrl + P + Q
```

> This detaches from the container without stopping it.

---

# Commit Container Changes as New Image

```bash
docker commit \
  -m "install nginx" \
  -c 'CMD /usr/sbin/nginx -g "daemon off;"' \
  -c 'EXPOSE 80' \
  <container-id> \
  <new-image-name>
```

---

## Important Parameters During Commit

| Option | Purpose |
|---|---|
| `-m` | Message describing the changes |
| `CMD` | Command to start the main process inside the container |
| `EXPOSE` | Port exposed by the application |
| `container-id` | Container where changes were made |
| `new-image-name` | Name for the new Docker image |

---

## Example

```bash
docker commit \
  -m "install nginx" \
  -c 'CMD /usr/sbin/nginx -g "daemon off;"' \
  -c 'EXPOSE 80' \
  abc123 \
  mynginx
```

---

# 2. Automated Docker Image Build Process (Real-Time Practice)

In real-world environments, Docker images are built using a Dockerfile.

---

# Create a Dockerfile

## Example File
```Dockerfile
FROM ubuntu

RUN apt-get update
RUN apt-get install -y nginx vim

RUN mkdir /home/config/
RUN touch /home/config/db.props

EXPOSE 80

CMD /usr/sbin/nginx -g "daemon off;"
```

---

# Build Docker Image

## Command
```bash
docker build -f /path/to/mydockerfile -t <new-image-name> .
```

---

## Explanation

| Option | Description |
|---|---|
| `-f` | Path to Dockerfile |
| `-t` | Name/tag for the image |
| `.` | Build context (current directory) |

---

## Example
```bash
docker build -f ./mydockerfile -t mynginx:v1 .
```

---

# Push Docker Images to Docker Hub

## Step 1: Create Docker Hub Account

Go to Docker Hub:

https://hub.docker.com

Create:
- Docker Hub account
- Repository (Example: `myapp`)

---

# Step 2: Login to Docker Hub

```bash
docker login
```

Provide:
- Docker Hub username
- Docker Hub password

Ensure you see:

```text
Login Succeeded
```

---

# Step 3: Tag the Image

## Syntax
```bash
docker tag local-image:tag new-repo:tag
```

---

## Example
```bash
docker tag myapp:v1 lerndevops/myapp:v1
```

---

# Step 4: Push the Image

## Syntax
```bash
docker push new-repo:tag
```

---

## Example
```bash
docker push lerndevops/myapp:v1
```

---

# Push Images to Private Repository (DTR)

DTR = Docker Trusted Registry

---

# Steps

## Create Account
Go to:
```text
mydockerrepo.com
```

Create:
- Account
- Repository

---

# Login to Private Registry

```bash
docker login mydockerrepo.com
```

Provide username and password.

---

# Tag Image

## Syntax
```bash
docker tag local-image:tagname mydockerrepo.com/account/repo:tagname
```

---

## Example
```bash
docker tag myapp-mytomcat:v1 mydockerrepo.com/lerndevops/myapp:v1
```

---

# Push Image

```bash
docker push mydockerrepo.com/lerndevops/myapp:v1
```

---

# Push Images to Private Registry Container

Docker provides a registry container that can be run locally.

---

# Start Local Registry

```bash
docker run -d \
  -p 5000:5000 \
  --restart always \
  --name registry \
  registry:2
```

---

# Local Registry Address

```text
localhost:5000
```

---

# Tag Image

```bash
docker tag myapp-mytomcat:v1 localhost:5000/myapp:v1
```

---

# Push Image

```bash
docker push localhost:5000/myapp:v1
```

---

# Transfer Images Offline

Docker images can be exported and imported.

---

# Save Docker Image

```bash
docker save -o mycentos.tgz mycentos:v1
```

---

# Copy Image Archive

```bash
scp mycentos.tgz <target-server>:/path
```

---

# Load Docker Image

```bash
docker load < mycentos.tgz
```

---

# Advanced Docker Image Concepts

# Find Dangling Images

Dangling images are unused images without tags.

---

## List Dangling Images

```bash
docker images -f dangling=true
```

---

## Remove Dangling Images

```bash
docker image prune --dangling=true
```

---

# Inspect Image Metadata

## Inspect Full Metadata

```bash
docker image inspect nginx:1.14.0
```

---

## Inspect Architecture

```bash
docker image inspect nginx:1.14.0 --format "{{.Architecture}}"
```

---

## Inspect Architecture and OS

```bash
docker image inspect nginx:1.14.0 --format "{{.Architecture}} {{.Os}}"
```

---
# Layered File System in Docker

Docker images and containers use a layered file system.

## Image Layers
- Docker images consist of one or more **read-only layers**
- Each layer contains only the differences from the previous layer

## Container Layer
- When a container is created, Docker adds one **writable layer** on top of the image layers

---

# Benefits of Layered File System

The layered architecture allows multiple images and containers to share common layers.

## Advantages
- Smaller storage footprint
- Faster image transfer
- Faster image builds
- Efficient caching
- Reduced duplication

---

# Quick Reference Commands

| Purpose | Command |
|---|---|
| Pull image | `docker pull ubuntu` |
| Run interactive container | `docker run -it ubuntu bash` |
| Commit container | `docker commit` |
| Build image | `docker build` |
| Tag image | `docker tag` |
| Push image | `docker push` |
| Save image | `docker save` |
| Load image | `docker load` |
| Inspect image | `docker image inspect` |
| Remove dangling images | `docker image prune --dangling=true` |

---

# Best Practices

- Prefer Dockerfile-based automated builds
- Keep Docker images lightweight
- Use official base images whenever possible
- Minimize the number of layers
- Use meaningful image tags
- Regularly remove dangling images
- Avoid storing secrets inside images
- Use `.dockerignore` to reduce build context
