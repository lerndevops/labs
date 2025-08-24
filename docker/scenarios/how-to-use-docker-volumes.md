# why we use volume in docker containers
# In all containers has own logs if container crashed or exit from any reason the how we can troubleshoot bcz as we knows logs are in container to aviod these things
# we user external volumes so containers log can persists.

To check volumes:
    docker volume ls
# volumes are two types
1. Managed by docker called volume
# For Create volume
   docker volume create volumename.
# to check volume location or mountion point  
   docker volume inspect volumename
# We cant attache any volume in running container so we need to create new container with volume
  docker run -d -P --mount type=volume,src=volumename,target=/opt/toomcat/logs image:v1
  # now if we check mounting point all loged has captureed or stored
  # targrt of logs can be different according to application or image build

2. Managed by user called bind volume
# why we need bind volume
# because volume created by dokcer need sudo privladges to access this location to avoide such these conditons we use bind volume
# we will create a dir. in any location wehere we didnt need sudo privladges

  mkdir /home/ubuntu/Dlogos   
# now only chanages in commad is 
   type=bind, src=/home/ubuntu/Dlogs
docker run -d -P --mount type=bind,src=/home/ubuntu/Dlogs,target=/opt/toomcat/logs image:v1

   
