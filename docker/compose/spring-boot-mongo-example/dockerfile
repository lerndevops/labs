FROM lerndevops/openjdk8:alpine

RUN apk update && apk add /bin/sh
RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app
COPY spring-boot-mongo.jar $PROJECT_HOME/spring-boot-mongo.jar
WORKDIR $PROJECT_HOME
EXPOSE 8080
CMD ["java", "-Dspring.data.mongodb.uri=mongodb://mongo:27017/spring-mongo","-Djava.security.egd=file:/dev/./urandom","-jar","./spring-boot-mongo.jar"]
