# Docker Persistent Data Guide

# Persistent Data with Containers

Docker containers are designed so that their internal storage can be easily destroyed.

However, many applications require persistent storage for:

- Configuration files
- Databases
- Application data
- Logs
- Uploaded files

Docker provides two primary solutions for persistent storage:

1. Bind Mounts
2. Volumes

---

# Bind Mounts vs Volumes

When attaching external storage to containers, Docker supports:

- Bind Mounts
- Volumes

Docker allows both methods using:

- `--mount` syntax
- `-v` / `--volume` syntax

---

# Bind Mounts

Bind mounts map a specific path from the host machine into the container.

---

## Characteristics of Bind Mounts

1. Mounts a specific host path into the container
2. Depends on host filesystem structure
3. Less portable
4. Direct access to host files
5. Useful for development environments

---

## Use Cases

- Local development
- Sharing configuration files
- Accessing host logs
- Testing applications

---

# Volumes

Volumes are managed entirely by Docker.

Docker controls the storage location on the host machine.

---

## Characteristics of Volumes

1. Storage managed by Docker
2. More portable
3. Easier backup and migration
4. Can be shared across multiple containers
5. Works in more scenarios
6. Recommended for production environments

---

## Use Cases

- Databases
- Persistent application data
- Multi-container shared storage
- Production workloads

---

# Important Note

Both Bind Mounts and Volumes can be created using:

- `--mount`
- `-v` / `--volume`

This means:

- Bind mounts can use `--mount` or `-v`
- Volumes can use `--mount` or `-v`

---

# Using `--mount` Syntax

## Syntax

```bash
docker run --mount key=value,key=value
```

---

# Common `--mount` Parameters

| Parameter | Description |
|---|---|
| `type` | bind, volume, or tmpfs |
| `source` / `src` | Volume name or host path |
| `destination` / `dst` / `target` | Path inside container |
| `readonly` | Mount as read-only |

---

# Types of Mounts

| Type | Description |
|---|---|
| `bind` | Host directory/file mount |
| `volume` | Docker-managed storage |
| `tmpfs` | Temporary in-memory storage |

---

# Example: Bind Mount using `--mount`

## Step 1: Create Directory and File

```bash
cd ~/
mkdir message
echo "Hey, You!" > message/message.txt
```

---

## Step 2: Mount Directory into Container

```bash
docker run \
  --mount type=bind,source=/home/cloud_user/message,destination=/root,readonly \
  busybox \
  cat /root/message.txt
```

---

## Explanation

| Option | Purpose |
|---|---|
| `type=bind` | Creates bind mount |
| `source=` | Host directory |
| `destination=` | Container path |
| `readonly` | Read-only access |

---

# Example: Volume using `--mount`

```bash
docker run \
  --mount type=volume,source=my-volume,destination=/root \
  busybox \
  sh -c 'echo hello > /root/message.txt && cat /root/message.txt'
```

---

# Using `-v` / `--volume` Syntax

## Syntax

```bash
docker run -v SOURCE:DESTINATION[:OPTIONS]
```

---

# Components of `-v`

| Component | Description |
|---|---|
| `SOURCE` | Volume name or host path |
| `DESTINATION` | Path inside container |
| `OPTIONS` | Additional options like `ro` |

---

# Behavior of SOURCE

| SOURCE Type | Result |
|---|---|
| Volume name | Creates Docker volume |
| Host path | Creates bind mount |

---

# Example: Bind Mount using `-v`

## Step 1: Create Directory and File

```bash
cd ~/
mkdir message
echo "Hey, You!" > message/message.txt
```

---

## Step 2: Mount Host Directory

```bash
docker run \
  -v /home/cloud_user/message:/root:ro \
  busybox \
  cat /root/message.txt
```

---

# Explanation

| Part | Meaning |
|---|---|
| `/home/cloud_user/message` | Host path |
| `/root` | Container path |
| `ro` | Read-only mode |

---

# Example: Volume using `-v`

```bash
docker run \
  -v my-volume:/root \
  busybox \
  sh -c 'cat /root/message.txt'
```

---

# Docker Swarm Important Note

When deploying Docker Swarm services:

- Only `--mount` syntax is supported
- `-v` syntax does NOT work with services

---

# Managing Volumes

Docker provides `docker volume` commands to manage volumes.

---

# Create Volume

```bash
docker volume create myvol
```

---

# List Volumes

```bash
docker volume ls
```

---

# Inspect Volume

```bash
docker volume inspect myvol
```

---

# Remove Volume

```bash
docker volume rm myvol
```

---

# Difference Between Bind Mounts and Volumes

| Feature | Bind Mount | Volume |
|---|---|---|
| Managed by Docker | No | Yes |
| Portable | No | Yes |
| Depends on Host Path | Yes | No |
| Easy Backup | Limited | Yes |
| Share Across Containers | Possible | Easy |
| Recommended for Production | No | Yes |

---

# Quick Reference Commands

| Purpose | Command |
|---|---|
| Create volume | `docker volume create myvol` |
| List volumes | `docker volume ls` |
| Inspect volume | `docker volume inspect myvol` |
| Remove volume | `docker volume rm myvol` |
| Bind mount with --mount | `docker run --mount type=bind...` |
| Volume mount with --mount | `docker run --mount type=volume...` |
| Bind mount with -v | `docker run -v /host:/container` |
| Volume mount with -v | `docker run -v myvol:/container` |

---

# Best Practices

- Use volumes for production applications
- Use bind mounts mainly for development
- Use read-only mounts whenever possible
- Avoid storing sensitive data in containers
- Regularly clean unused volumes
- Use named volumes instead of anonymous volumes
- Use `--mount` syntax for clarity and Swarm compatibility
