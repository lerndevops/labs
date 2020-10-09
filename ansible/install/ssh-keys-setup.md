### create a user on all machines ( controller & all targets )

	useradd naresh -m -d /home/naresh -s /bin/bash

### add user to sudoers for root previliges  on all machines ( all targets )

	echo -e 'naresh  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/naresh

### genereate ssh keys for above user on contrller machine 

```
	1) switch to user ( su - naresh )
	2) run "ssh-keygen" command as user ( this will genereate ssh keys for the user ) 
```
```
        on ansible controller machine
		cd /home/naresh/.ssh 
		cat id_rsa.pub (copy the content)
```
### copy user ssh keys from ansible contrller to all target hosts

```
	1) on all target machines
		   swith to the user ( su - naresh )
		   mkdir -p /home/naresh/.ssh
		   touch /home/naresh/.ssh/authorized_keys
		   chmod -R 700 /home/naresh/.ssh
		   vi /home/naresh/.ssh/authorized_keys  (enter the copied contet of id_rsa.pub from controller & save the file)
```	
	

