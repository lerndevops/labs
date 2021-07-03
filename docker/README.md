## What is Docker ?

> **Docker is a Containerization Platform which allows us to containerize an application/software (called as Docker Image) & also lets you run Containerized application/software**

> **Technical Deffinition:**

> Docker is an open source software platform to create, deploy and manage virtualized application containers on a common operating system (OS), with an ecosystem of allied tools.

> Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

## Docker Architecture 

### `Docker Engine`

> Have you tried to install Docker yet? You might have noticed that you’re required to install not just Docker, but also something called dockerd.

> That is because Docker is a client-server application. You must have both parts for running a Docker application on your computer. This client-server tandem is called docker engine.

> The docker client is just a CLI tool to make requests against a REST API, which is responsible for interacting with the docker daemon or dockerd. dockerd will deal with the operative system to ensure the proper behaviour for the containers.

![Docker Engine Flow](https://github.com/lerndevops/slearncka/blob/master/static/docker-engine-components-flow.png)

> Now we have a clear understanding of the main elements of Docker, how does it all work together

> Whenever a request is created in the Docker client, it’s sent to the Docker daemon and it will perform the required actions.

> Let’s use as an example running a redis container. We achieve that by running the instruction docker run redis.

> First, our computer will make a request to the configured docker host API, which is going to interact with the Docker daemon.
At this point, the daemon knows what it must do. It will look up the redis image on the host registry. If it’s not present, a new lookup will be made, this time against the configured image registry (Docker Hub, ECR, ACR, GCR, …) and pulled (downloaded). Then it will spawn a container based in the downloaded image.

![Docker Architecture](https://github.com/lerndevops/slearncka/blob/master/static/Docker-architecture.png)


## what is Docker Image ?

> A package which consists of an application/software with all its dependencies to run, **Called as Docker Image**

> Docker Image will have a base layer of minimal OS in it always, on top of OS layer we install software & its dependenci
es.

> A Docker image is built up from a series of layers. Each layer represents an instruction that we run.

> A Docker image is a lightweight, standalone, executable package of software that includes everything needed to run an a
pplication: code, runtime, system tools, system libraries and settings

> Docker Images are immutable

> Images are stored in a Docker registry such as registry.hub.docker.com

## what is Docker Container ?

> A container is runtime instance of a Docker Image

> A Container is the actual instantiation of the image just like how an object is an instantiation or an instance of a cl
ass.


## Advantages of Containers

#### Physical vs. Virtual Machines vs. Container


| Physical | Virtaul Machines | **Containers** |
| :-------- | :-------------- | :---------- |
| No virtualization | H/W level virtualization | **OS level Vertualization** |
| Huge Maintenance Cost | Huge Maintenance Cost | **No Maintenance Cost** |
| No Scalability | Scalability is Hard | **Easily Scalable** |
| Huge Resource Wastage | Better Resource Usage but Dynamic Allocation is NOT Possible | **Dynamic Resource Allocation isPossible** |
| Takes Longer Time to Initialize App (boot time) | Almost Same as Physical  | **Take Very Less Time to Initialize App (less boot time)** |


## The underlying technology

> Docker is written in Go and takes advantage of several features of the Linux kernel to deliver its functionality.

### `Namespaces`

> Docker uses a technology called namespaces to provide the isolated workspace called the container. When you run a container, Docker creates a set of namespaces for that container.

> These namespaces provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

> Docker Engine uses namespaces such as the following on Linux:

```
	The pid namespace: Process isolation (PID: Process ID).
	The net namespace: Managing network interfaces (NET: Networking).
	The ipc namespace: Managing access to IPC resources (IPC: InterProcess Communication).
	The mnt namespace: Managing filesystem mount points (MNT: Mount).
	The uts namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).
```

### `Control groups`

> Docker Engine on Linux also relies on another technology called control groups (cgroups). A cgroup limits an application to a specific set of resources. 

> Control groups allow Docker Engine to share available hardware resources to containers and optionally enforce limits and constraints. For example, you can limit the memory available to a specific container.


### `Union file systems`

> Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast. 

> Docker Engine uses UnionFS to provide the building blocks for containers. Docker Engine can use multiple UnionFS variants, including AUFS, btrfs, vfs, and DeviceMapper.

### `Container format`

> Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format. 

> The default container format is libcontainer. In the future, Docker may support other container formats by integrating with technologies such as BSD Jails or Solaris Zones.
