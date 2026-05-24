what is Dockefile:
==================
A Dockerfile is set of instructions which are used to construct a Docker Image.
These instructions are called directives.

Dockerfiel directive:
=====================

FROM: start a new build stage and sets the base image. usually must be the first directive in the Dockerfile (except ARG can be placed before FROM).

ENV: set environment variables. These can be refefenced in the Dockerfile itself and are visible to the container at runtime. 

RUN: creates a new layer on top of the previous layer by running a command inside that new layer and commiting the changes.

CMD: specify a default command used to run a container at execution time.

EXPOSE: documents which port(s) are intended to published when running a container

WORKDIR: sets the current working directory for subsequent directives such as ADD, COPY, CMD, ENTRYPOINT, etc. Cna be used multiple time to change the directories throught the Dockerfile. you can also use relative path, which sets the new working direcotry relative to the previous working direcotry.
 
COPY: copy files from the local machine to the image. 

ADD: similar to COPY, but can also pull files using a URL and extract an archive into loose files in the image. 

STOPSIGNAL: specify the signal that will be used to stop the container. 

HEALTHCHECK: speciry a command to run in order to perform a custom health check to verify that the container is working properly.
