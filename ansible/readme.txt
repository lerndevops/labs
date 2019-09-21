Things to know before working with ansible
	
	1) ansible is agentless ( means, we do not need to run any agent on remote servers for communication )
	
	2) ansible follows push model ( means we push the configuration from ansible controller to remote servers )
	
	3) ansible uses SSH protocol to communicate with remote servers
	
	4) ansible uses below methods for remote servers authentication
	
			password based
			key based

Ansible controller ( is the machine/host/server where we install ansible ) 

	/etc/ansible default directory ( we have two important file in it )
	
		hosts ( default inventory file in which we can mention remote servers we want to apply/push the changes to)
		
		ansible.cfg  ( default ansible configuraton - can be used to customize as per our need )


Ansible Terminlogy 

	1) ansible ad-hoc commands ( single task that can be executed against remote servers )
	
	2) ansible playbooks  ( set of instructions written in a .yml file to execute against remote servers  )
	
	3) ansible facts ( information about remote servers collected ansible before running any task )
	
	4) ansible modules ( are the units of work that ansible ships to remote servers for executing the tasks )
	
	5) ansible role ( to break a playbook into multiple files. This simplifies writing complex playbooks, and it makes them easier to reuse )
	
		look at: https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html     for more terms used in ansible. 
		
