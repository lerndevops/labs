Docker Daemon/Engine:
=====================

	A server which is a type of long-running program called a daemon process (the dockerd process)

	The Docker daemon/engine is a service that runs on your host operating system. 
	It is primarily designed to run on Linux because it depends on a number of Linux kernel features, but there are a few waysto run Docker on MacOS and Windows too.

	The Docker daemon itself exposes a REST API

Docker Client:
==============

	The Docker client provides a command line interface (CLI) that allows you to issue build, run, and stop application commands to a Docker daemon.

	The Docker client can reside on the same host as the daemon or connect to a daemon on a remote host. A docker client can communicate with more than one daemon.


![Docker Architecturre](DockerArchitecture.png?style=centerme)


Container Format: 
=================

	Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format.
	The default container format is libcontainer.
	In the future, Docker may support other container formats by integrating with technologies such as BSD Jails or Solaris Zones

