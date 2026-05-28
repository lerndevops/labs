# Docker Swarm Complete Guide

# What is Docker Swarm?

Docker Swarm is Docker's native clustering and orchestration solution.

It allows multiple Docker hosts to work together as a single cluster.

Docker Swarm helps in:

- Container orchestration
- High availability
- Load balancing
- Auto scheduling
- Scaling applications
- Rolling updates

---

# Key Features of Docker Swarm

## 1. Clustering

Multiple Docker hosts can be grouped together into a single cluster.

---

## 2. High Availability

Applications continue running even if some nodes fail.

---

## 3. Load Balancing

Traffic is automatically distributed among containers.

---

## 4. Service Scaling

Scale applications up or down easily.

---

## 5. Rolling Updates

Update applications without downtime.

---

## 6. Self Healing

Failed containers are automatically recreated.

---

# Docker Swarm Architecture

Docker Swarm consists of:

1. Manager Nodes
2. Worker Nodes

---

# Manager Node

Manager nodes control the swarm cluster.

## Responsibilities

- Cluster management
- Scheduling services
- Maintaining swarm state
- Handling API requests

---

# Worker Node

Worker nodes run the application containers.

## Responsibilities

- Execute tasks
- Run containers
- Report status to managers

---

# Docker Swarm Concepts

| Concept | Description |
|---|---|
| Node | A Docker host participating in swarm |
| Manager | Controls swarm cluster |
| Worker | Runs application containers |
| Service | Desired state of application |
| Task | Running container instance |
| Overlay Network | Multi-host networking |
| Replica | Number of service copies |

---

# Initialize Docker Swarm

## Command

```bash
docker swarm init
```

---

# Example

```bash
docker swarm init --advertise-addr 192.168.1.10
```

---

# Output Example

```text
Swarm initialized: current node is now a manager.
```

Docker also provides a join token for worker nodes.

---

# View Swarm Join Tokens

## Worker Token

```bash
docker swarm join-token worker
```

---

## Manager Token

```bash
docker swarm join-token manager
```

---

# Join Worker Node to Swarm

Run the join command provided by the manager.

## Example

```bash
docker swarm join \
  --token SWMTKN-xxxx \
  192.168.1.10:2377
```

---

# List Nodes in Swarm

```bash
docker node ls
```

---

# Example Output

| NODE ID | HOSTNAME | STATUS | AVAILABILITY | MANAGER STATUS |
|---|---|---|---|---|
| abc123 | manager1 | Ready | Active | Leader |
| xyz789 | worker1 | Ready | Active |  |

---

# Create a Service in Swarm

## Syntax

```bash
docker service create [OPTIONS] IMAGE
```

---

# Example

```bash
docker service create \
  --name nginxsvc \
  --replicas 3 \
  -p 8080:80 \
  nginx
```

---

# Explanation

| Option | Description |
|---|---|
| `--name` | Service name |
| `--replicas` | Number of container copies |
| `-p` | Publish ports |
| `nginx` | Docker image |

---

# List Services

```bash
docker service ls
```

---

# View Service Tasks

```bash
docker service ps nginxsvc
```

---

# Inspect Service

```bash
docker service inspect nginxsvc
```

---

# Scale a Service

## Method 1

```bash
docker service scale nginxsvc=5
```

---

## Method 2

```bash
docker service update --replicas 5 nginxsvc
```

---

# Rolling Updates

Docker Swarm supports zero-downtime updates.

## Update Image

```bash
docker service update \
  --image nginx:alpine \
  nginxsvc
```

---

# Benefits of Rolling Updates

- No downtime
- Gradual replacement
- Safer deployments
- Easy rollback

---

# Rollback Service

```bash
docker service rollback nginxsvc
```

---

# Remove Service

```bash
docker service rm nginxsvc
```

---

# Docker Swarm Networking

Docker Swarm uses:

- Overlay Networks
- Ingress Networks

---

# Overlay Network

Overlay networks allow containers on different hosts to communicate.

---

# Create Overlay Network

```bash
docker network create \
  --driver overlay \
  myoverlay
```

---

# Attach Service to Overlay Network

```bash
docker service create \
  --name websvc \
  --network myoverlay \
  nginx
```

---

# Ingress Network

Docker automatically creates an ingress network for load balancing.

---

# Routing Mesh

Docker Swarm provides routing mesh.

## Features

- Published ports available on every node
- Traffic automatically routed to active containers

---

# Example

```bash
docker service create \
  -p 8080:80 \
  nginx
```

Access application using any swarm node IP.

---

# Placement Constraints

Control where containers run.

---

# Example

```bash
docker service create \
  --constraint 'node.labels.type == app' \
  nginx
```

---

# Add Labels to Nodes

```bash
docker node update \
  --label-add type=app \
  worker1
```

---

# Drain a Node

Prevent new tasks from running on a node.

```bash
docker node update --availability drain worker1
```

---

# Activate Node Again

```bash
docker node update --availability active worker1
```

---

# Leave Swarm

## Worker Node

```bash
docker swarm leave
```

---

## Manager Node

```bash
docker swarm leave --force
```

---

# Remove Node from Swarm

```bash
docker node rm worker1
```

---

# Docker Stack

Docker Stack allows deployment of multi-service applications using YAML files.

---

# Example docker-compose.yml

```yaml
version: "3"

services:
  web:
    image: nginx
    ports:
      - "8080:80"
```

---

# Deploy Stack

```bash
docker stack deploy -c docker-compose.yml mystack
```

---

# List Stacks

```bash
docker stack ls
```

---

# List Stack Services

```bash
docker stack services mystack
```

---

# Remove Stack

```bash
docker stack rm mystack
```

---

# Docker Swarm Security

Docker Swarm includes built-in security features:

- Mutual TLS authentication
- Encrypted communication
- Secure node joining
- Role-based management

---

# Swarm Ports

| Port | Purpose |
|---|---|
| 2377 | Cluster management |
| 7946 | Node communication |
| 4789 | Overlay network traffic |

---

# Common Docker Swarm Commands

| Purpose | Command |
|---|---|
| Initialize swarm | `docker swarm init` |
| Join swarm | `docker swarm join` |
| Leave swarm | `docker swarm leave` |
| List nodes | `docker node ls` |
| Create service | `docker service create` |
| Scale service | `docker service scale` |
| Update service | `docker service update` |
| Remove service | `docker service rm` |
| Create overlay network | `docker network create --driver overlay` |
| Deploy stack | `docker stack deploy` |

---

# Advantages of Docker Swarm

- Easy to set up
- Native Docker integration
- Lightweight orchestration
- Simple scaling
- Built-in load balancing
- Secure communication

---

# Limitations of Docker Swarm

- Fewer features compared to Kubernetes
- Smaller ecosystem
- Limited advanced orchestration capabilities

---

# Docker Swarm vs Kubernetes

| Feature | Docker Swarm | Kubernetes |
|---|---|---|
| Setup Complexity | Easy | Complex |
| Learning Curve | Low | High |
| Scalability | Moderate | Very High |
| Ecosystem | Smaller | Huge |
| Native Docker Support | Excellent | Indirect |

---

# Best Practices

- Use odd number of manager nodes
- Use overlay networks for services
- Monitor node health regularly
- Use rolling updates in production
- Use node labels for workload placement
- Backup swarm manager state
- Use secrets for sensitive data
- Limit manager node workloads

---

# Example End-to-End Workflow

# Step 1: Initialize Swarm

```bash
docker swarm init
```

---

# Step 2: Create Overlay Network

```bash
docker network create \
  --driver overlay \
  myoverlay
```

---

# Step 3: Create Service

```bash
docker service create \
  --name nginxsvc \
  --replicas 3 \
  --network myoverlay \
  -p 8080:80 \
  nginx
```

---

# Step 4: Verify Service

```bash
docker service ls
```

---

# Step 5: Scale Service

```bash
docker service scale nginxsvc=5
```

---

# Step 6: Update Service

```bash
docker service update \
  --image nginx:alpine \
  nginxsvc
```

---

# Step 7: Remove Service

```bash
docker service rm nginxsvc
```
