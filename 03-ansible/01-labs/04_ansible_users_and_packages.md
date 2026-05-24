# Ansible Lab 04 - Users and Packages

## Playbook

```yaml
---
- name: Configure Users
  hosts: ubuntu_servers
  become: yes

  tasks:

    - name: Create devops user
      user:
        name: devops
        shell: /bin/bash
        create_home: yes

    - name: Install packages
      apt:
        name:
          - git
          - curl
          - vim
        state: present
        update_cache: yes
```