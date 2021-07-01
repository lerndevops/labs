`Asnible playbook is a script that consist set of instrucitons which we want to run on remote servers. the script is written using the ansible modules, in human frendly readable format by using yaml.`

`YAML is a data serialization format. If you don’t know what a data serialization format is, think of it as a way to translate a programmatic data structure (lists, arrays, dictionaries, etc) into a format that can be easily stored to disk. The file can then be used to recreate the structure at a later point. JSON is another popular data serialization format, but YAML is much easier to read.`

`Each playbook contains one or more plays, which map hosts to a certain function. Ansible does this through something called tasks, which are basically module calls.`

## execute playbooks with SSH Keys Configured to target hosts 
```
how to run a ansible playbook  ( default invenotry )

	ansible-playbook myplaybook.yml 

how to run ansible playbook with custom inventory

	ansible-playbook -i /path/to/inventory myplaybook.yml

how to run ansible playbook with super user (root)

        ansible-playbook -i /path/to/inventory myplaybook.yml
```

## execute playbooks with No SSH Keys Configured to target hosts 
```
how to run a ansible playbook  ( default invenotry ) with uid/pwd

	ansible-playbook myplaybook.yml -u username -k 

how to run ansible playbook with custom inventory with uid/pwd

	ansible-playbook myplaybook.yml -i /path/to/inventory -u username -k 

how to run ansible playbook with super user (root) with uid/pwd

        ansible-playbook myplaybook.yml -i /path/to/inventory -u username -kK
```
