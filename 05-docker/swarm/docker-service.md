# What is a Docker Service?

A Docker Service is used to run applications on a Docker Swarm cluster.

A service defines:

- One or more replica tasks
- The container image to use
- Networking configuration
- Port mappings
- Volumes
- Placement rules

Docker automatically distributes the service tasks across available nodes in the cluster.

Each task runs as a container.

---

# Key Concepts

| Term | Description |
|---|---|
| Service | Definition of the application running in swarm |
| Task | A running container instance of the service |
| Replica | Number of copies of a service |
| Swarm | Cluster of Docker nodes |

---

# Benefits of Docker Services

- High availability
- Load balancing
- Automatic scheduling
- Easy scaling
- Rolling updates
- Self-healing containers

---

# Create a Docker Service

## Basic Syntax

```bash
docker service create [OPTIONS] IMAGE
```

---

# Example: Create Tomcat Service

```bash
docker service create \
  --name mysvc \
  --replicas 4 \
  -p 9080:8080 \
  tomcat
```

---

# Explanation

| Option | Purpose |
|---|---|
| `--name` | Service name |
| `--replicas` | Number of container replicas |
| `-p` | Publish ports |
| `tomcat` | Container image |

---

# List Services

```bash
docker service ls
```

Displays all running services in the swarm.

---

# View Service Tasks

```bash
docker service ps mysvc
```

Displays:
- Tasks
- Node placement
- Task status
- Replica information

---

# Inspect Service

## Full JSON Output

```bash
docker service inspect mysvc
```

---

## Human Readable Output

```bash
docker service inspect --pretty mysvc
```

---

# Remove Service

```bash
docker service rm mysvc
```

---

# Various Service Creation Examples

# 1. Create Nginx Service

```bash
docker service create \
  --name mysvc \
  --replicas 2 \
  -p 9080:80 \
  nginx
```

---

# 2. Limit Replicas Per Node

```bash
docker service create \
  --name nginxsvc \
  --replicas 2 \
  --replicas-max-per-node 1 \
  nginx
```

---

## Explanation

| Option | Description |
|---|---|
| `--replicas-max-per-node` | Limits replicas per node |

This ensures:
- Only one replica runs on each node

---

# 3. Create Service with Volume Mount

```bash
docker service create \
  --name nginxsvc \
  --replicas 3 \
  --mount type=volume,destination=/path/in/container \
  nginx:alpine
```

---

# Explanation

| Parameter | Description |
|---|---|
| `type=volume` | Docker managed volume |
| `destination=` | Mount path inside container |

---

# 4. Create Service with Node Constraints

```bash
docker service create \
  --name tomcatsvc \
  --replicas 3 \
  --constraint 'node.labels.type == queue' \
  tomcat
```

---

# Explanation

This service runs only on nodes where:

```text
node.labels.type == queue
```

---

# Updating Docker Services

Docker allows updating services without downtime using rolling updates.

---

# 1. Update Service with New Image

## Rolling Update

```bash
docker service update --image=tomcat <service-name>
```

---

# Example

```bash
docker service update --image=tomcat:10 mysvc
```

---

# What Happens?

Docker:
1. Stops old containers gradually
2. Starts new containers one by one
3. Maintains service availability

---

# 2. Add New Network to Service

```bash
docker service update \
  --network-add myoverlay \
  <service-name>
```

---

# Example

```bash
docker service update \
  --network-add myoverlay \
  mysvc
```

---

# 3. Add Published Port to Existing Service

```bash
docker service update \
  --publish-add 9080:80 \
  <service-name>
```

---

# Example

```bash
docker service update \
  --publish-add 9080:80 \
  mysvc
```

---

# 4. Add Mount to Existing Service

## Simple Mount

```bash
docker service update \
  --mount-add source=abc,target=/tmp \
  <service-name>
```

---

## Volume Mount

```bash
docker service update \
  --mount-add type=volume,source=abc,target=/tmp \
  <service-name>
```

---

# Example

```bash
docker service update \
  --mount-add type=volume,source=mydata,target=/tmp \
  mysvc
```

---

# Scaling Docker Services

Docker services can be scaled dynamically.

---

# Method 1: Update Replicas

```bash
docker service update --replicas 3 nginx
```

---

# Method 2: Scale Command

```bash
docker service scale nginx=4
```

---

# What Happens During Scaling?

Docker automatically:
- Creates additional containers
- Distributes replicas across nodes
- Balances workload

---

# Service Lifecycle Commands

| Purpose | Command |
|---|---|
| Create service | `docker service create` |
| List services | `docker service ls` |
| View tasks | `docker service ps` |
| Inspect service | `docker service inspect` |
| Remove service | `docker service rm` |
| Update service | `docker service update` |
| Scale service | `docker service scale` |

---

# Example End-to-End Workflow

# Step 1: Create Service

```bash
docker service create \
  --name websvc \
  --replicas 2 \
  -p 8080:80 \
  nginx
```

---

# Step 2: Verify Service

```bash
docker service ls
```

---

# Step 3: Scale Service

```bash
docker service scale websvc=5
```

---

# Step 4: Update Image

```bash
docker service update --image nginx:alpine websvc
```

---

# Step 5: Remove Service

```bash
docker service rm websvc
```

---

# Best Practices

- Use rolling updates for production deployments
- Use overlay networks for swarm services
- Use constraints for workload placement
- Use named volumes for persistent data
- Monitor replica health regularly
- Avoid running all replicas on one node
- Use labels for better node management
- Keep replica count based on workload demand

---

# Important Notes

- Docker Services work only in Docker Swarm mode
- Swarm must be initialized before creating services

## Initialize Swarm

```bash
docker swarm init
```

---

# Quick Reference Commands

| Purpose | Command |
|---|---|
| Initialize swarm | `docker swarm init` |
| Create service | `docker service create` |
| Scale service | `docker service scale nginx=3` |
| Update image | `docker service update --image=nginx nginx` |
| Remove service | `docker service rm nginx` |
| View service tasks | `docker service ps nginx` |
