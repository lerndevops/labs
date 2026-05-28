# Docker Networking Guide

# Introduction to Docker Networking

Containers present unique challenges when it comes to networking.

Docker provides multiple built-in networking solutions to address these challenges.

Docker implements container networking using the:

- **Container Networking Model (CNM)**

Docker manages networking for containers using this framework.

---

# Container Networking Model (CNM)

The CNM uses the following core concepts:

---

## 1. Sandbox

A Sandbox is an isolated unit containing all networking components associated with a single container.

### Key Points
- Usually implemented using a Linux network namespace
- Provides isolation for container networking

---

## 2. Endpoint

An Endpoint connects a sandbox to a network.

### Key Points
- A container can have multiple endpoints
- A container has exactly one endpoint per connected network

---

## 3. Network

A Network is a collection of endpoints connected together.

### Purpose
Allows communication between containers and services.

---

## 4. Network Driver

The Network Driver handles the actual implementation of networking.

### Responsibility
- Creates networks
- Connects containers
- Manages traffic flow

---

## 5. IPAM Driver

IPAM = IP Address Management

### Responsibilities
- Allocates subnets automatically
- Assigns IP addresses to networks and containers

---

# Docker Network Drivers

Docker includes several built-in network drivers known as:

## Native Network Drivers

These drivers implement the CNM concepts.

---

# Available Native Network Drivers

1. Host
2. Bridge
3. Overlay
4. Macvlan
5. None

---

# Using Network Drivers

Use the `--net` flag with `docker run` to attach a network driver.

## Example
```bash
docker run --net bridge nginx
```

---

# 1. Host Network Driver

The Host Network Driver allows containers to directly use the host's network stack.

---

## Characteristics

1. Containers use the host networking resources directly
2. No separate network namespace isolation
3. All containers share the host network namespace
4. No two containers can use the same port

---

## Use Cases

- Simple networking setup
- Single-host deployments
- Applications requiring high performance networking

---

## Example
```bash
docker run --net host nginx
```

---

# 2. Bridge Network Driver

The Bridge Network Driver uses Linux bridge networks to provide connectivity between containers on the same host.

---

## Characteristics

1. Default network driver for standalone containers
2. Creates a Linux bridge for Docker networks
3. Docker automatically creates a default bridge called `docker0`
4. Containers connect to `docker0` if no network is specified

---

## Use Cases

- Isolated networking between containers
- Single-host container communication

---

## Example
```bash
docker run --net bridge nginx
```

---

# 3. Overlay Network Driver

The Overlay Network Driver provides networking between containers across multiple Docker hosts.

Usually used with Docker Swarm.

---

## Characteristics

1. Uses VXLAN data plane
2. Enables communication across multiple hosts
3. Automatically configures networking components
4. Transparent networking between swarm nodes

---

## Use Cases

- Docker Swarm clusters
- Multi-host container communication

---

## Example
```bash
docker network create --driver overlay my-overlay-net
```

---

# 4. Macvlan Network Driver

The Macvlan Network Driver directly connects container interfaces to host interfaces.

---

## Characteristics

1. Direct association with Linux interfaces
2. Avoids Linux bridge usage
3. Lower latency
4. More lightweight networking
5. More complex configuration

---

## Use Cases

- Extremely low latency requirements
- Containers needing IP addresses from external subnet

---

## Example
```bash
docker network create -d macvlan my-macvlan
```

---

# 5. None Network Driver

The None Network Driver provides no networking.

---

## Characteristics

1. Complete isolation
2. No external connectivity
3. No interfaces or endpoints
4. Separate network namespace still exists

---

## Use Cases

- Highly secure containers
- Custom manual networking setup

---

## Example
```bash
docker run --net none nginx
```

---

# Managing Docker Networks

Docker provides `docker network` commands to manage custom networks.

If no driver is specified, Docker uses the Bridge driver by default.

---

# List Networks

```bash
docker network ls
```

---

# Create Network

## Default Bridge Network
```bash
docker network create NETWORK
```

---

## Create Bridge Network
```bash
docker network create --driver bridge NETWORK
```

---

## Create Overlay Network
```bash
docker network create --driver overlay NETWORK
```

---

# Inspect Network

```bash
docker network inspect NETWORK
```

---

# Remove Network

```bash
docker network rm NETWORK
```

---

# Connect Container to Network

```bash
docker network connect NETWORK CONTAINER
```

---

# Disconnect Container from Network

```bash
docker network disconnect NETWORK CONTAINER
```

---

# Embedded DNS in Docker

Docker networks include an embedded DNS server.

This allows containers and services to communicate using:

- Container names
- Service names
- Network aliases

---

# Create Network Alias

## Using docker run
```bash
docker run --network-alias ALIAS
```

---

## Using docker network connect
```bash
docker network connect --alias ALIAS
```

---

# Example: Network Alias Communication

## Step 1: Create Network

```bash
docker network create my-net
```

---

## Step 2: Run Nginx Container with Alias

```bash
docker run -d \
  --name my-net-nginx \
  --network my-net \
  --network-alias my-nginx-alias \
  nginx
```

---

## Step 3: Access Container Using Name

```bash
docker exec my-net-busybox curl my-net-nginx:80
```

---

## Step 4: Access Container Using Alias

```bash
docker exec my-net-busybox curl my-nginx-alias:80
```

---

# Add Alias to Existing Container

## Run Container

```bash
docker run -d --name my-net-nginx2 nginx
```

---

## Connect with Alias

```bash
docker network connect \
  --alias another-alias \
  my-net \
  my-net-nginx2
```

---

## Access Using Alias

```bash
docker exec my-net-busybox curl another-alias:80
```

---

# Publishing Ports for Services

Docker Swarm supports two modes for publishing service ports.

---

# 1. Ingress Mode

Ingress is the default mode.

---

## Characteristics

1. Uses routing mesh
2. Published port listens on every node
3. Traffic is automatically routed to service tasks
4. Works across all swarm nodes

---

## Use Cases

- Load balancing
- High availability services

---

## Example

```bash
docker service create \
  -p 8081:80 \
  --name nginx_ingress_pub \
  nginx
```

---

# 2. Host Mode

Host mode publishes ports directly on the node running the container task.

---

## Characteristics

1. Direct host-to-container communication
2. No routing mesh
3. Traffic reaches only the local task
4. Cannot use same static port for multiple replicas on same node

---

## Use Cases

- High-performance networking
- Applications requiring direct node access

---

## Example

```bash
docker service create \
  -p mode=host,published=8082,target=80 \
  --name nginx_host_pub \
  nginx
```

---

# Quick Reference Commands

| Purpose | Command |
|---|---|
| List networks | `docker network ls` |
| Create bridge network | `docker network create mynet` |
| Create overlay network | `docker network create --driver overlay mynet` |
| Inspect network | `docker network inspect mynet` |
| Remove network | `docker network rm mynet` |
| Connect container | `docker network connect mynet container1` |
| Disconnect container | `docker network disconnect mynet container1` |
| Run container with host networking | `docker run --net host nginx` |
| Run container with bridge networking | `docker run --net bridge nginx` |
| Run isolated container | `docker run --net none nginx` |

---

# Best Practices

- Use custom bridge networks instead of default bridge
- Use overlay networks for multi-host communication
- Use network aliases for service discovery
- Avoid host networking unless necessary
- Use ingress mode for scalable swarm services
- Use none network for isolated secure workloads
- Monitor and clean unused Docker networks regularly
