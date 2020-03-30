### create a user on all machines

	`useradd ansible -m -d /home/ansible -s /bin/bash`

### add user to sudoers for root previliges  on all machines 

	`echo -e 'ansible  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/ansible`

### genereate ssh key for user on ansible contrller machine 
```
	1) switch to user ( su - ansible )
	2) run "ssh-keygen" command as user ( this will genereate ssh keys for the user ) 
```
### copy user ssh keys from ansible contrller to all target hosts

```
	1) on ansible controller machine
		cd /home/ansible/.ssh 
		cat id_rsa.pub (copy the content)
```
```
	2) on all taget machines
		   swith to the user ( su - ansible )
		   mkdir -p /home/ansible/.ssh
		   touch /home/ansible/.ssh/authorized_keys
		   chmod 600 /home/ansible/.ssh/authorized_keys
		   vi /home/ansible/.ssh/authorized_keys  (copy the contet of id_rsa.pub from ansible controller)
```	
	

