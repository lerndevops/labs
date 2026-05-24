# Ansible Lab 03 - First Playbook

## Playbook

```yaml
---
- name: Install Nginx
  hosts: ubuntu_servers
  become: yes

  tasks:

    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

## Execute

```bash
ansible-playbook -i inventory.ini install_nginx.yml
```