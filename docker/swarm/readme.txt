how to create a service in docker swarm

example1: 
	docker service create --name mysvc --replicas 4 -p 9080:8080 tomcat
	docker service ls
	docker service mysvc ps
	docker service inspect mysvc
        docker service scale mysvc=3
	docker service rm mysvc 

example2: 
	docker service create --name mysvc1 --replicas 4 -p 80:80 nginx
        docker service ls
        docker service mysvc ps
        docker service inspect mysvc1
        docker service scale mysvc1=3
        docker service rm mysvc1

various options while creating service 

	docker service create --name nginxsvc --replicas 2 --replicas-max-per-node 1 nginx
	docker service create --name nginxsvc --replicas 3 --mount type=volume,destination=/path/in/container nginx:alpine
	docker service create --name tomcatsvc --replicas 3 --constraint 'node.labels.type == queue' tomcat

======================================================================================================

Updating Service 

updating service with new network
	docker service update --network-add myoverlay <servicename/id>
	
updating / adding service port after creating a service 
	docker service update --publish-add 9080:80 <servicename/id>
	
updating / adding mount on service after creating service 
	docker service update --mount-add source=abc,target=/tmp <servicename/id>
	docker service update --mount-add type=volume,source=abc,target=/tmp <servicename/id>

======================================================================================================

create services in swarm using compose file ( declarative model )

	docker stack deploy -c compose.yml mystack
        docker stack ls
        docker stack ps mystack
        docker stack services mystack
        docker stack rm mystack
        docker service scale mysvc=3


