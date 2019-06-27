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

===========================================================================================

create services in swarm using compose file ( declarative model )

	docker stack deploy -c compose.yml mystack
        docker stack ls
        docker stack ps mystack
        docker stack services mystack
        docker stack rm mystack
        docker service scale mysvc=3
