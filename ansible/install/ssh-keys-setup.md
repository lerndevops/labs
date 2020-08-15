### create a user on all machines ( controller & all targets )

	useradd ansiblebot -m -d /home/ansiblebot -s /bin/bash

### add user to sudoers for root previliges  on all machines ( all targets )

	echo -e 'ansiblebot  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/ansiblebot

### genereate ssh keys for above user on contrller machine 

```
	1) switch to user ( su - ansiblebot )
	2) run "ssh-keygen" command as user ( this will genereate ssh keys for the user ) 
```

### copy user ssh keys from ansible contrller to all target hosts

```
	1) on ansible controller machine
		cd /home/ansiblebot/.ssh 
		cat id_rsa.pub (copy the content)
```
```
	2) on all taget machines
		   swith to the user ( su - ansiblebot )
		   mkdir -p /home/ansiblebot/.ssh
		   touch /home/ansiblebot/.ssh/authorized_keys
		   chmod -R 700 /home/ansiblebot/.ssh
		   vi /home/ansiblebot/.ssh/authorized_keys  (enter the copied contet of id_rsa.pub from controller & save the file)
```	
	

