### create a user on all machines ( controller & all targets )

	useradd botuser -m -d /home/botuser -s /bin/bash

### add user to sudoers for root previliges  on all machines ( all targets )

	echo -e 'botuser  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/botuser

### genereate ssh keys for above user on contrller machine 

```
	1) switch to user ( su - botuser )
	2) run "ssh-keygen" command as user ( this will genereate ssh keys for the user ) 
```

### copy user ssh keys from ansible contrller to all target hosts

```
	1) on ansible controller machine
		cd /home/botuser/.ssh 
		cat id_rsa.pub (copy the content)
```
```
	2) on all taget machines
		   swith to the user ( su - botuser )
		   mkdir -p /home/botuser/.ssh
		   touch /home/botuser/.ssh/authorized_keys
		   chmod -R 700 /home/botuser/.ssh
		   vi /home/botuser/.ssh/authorized_keys  (enter the copied contet of id_rsa.pub from controller & save the file)
```	
	

