# Ansible Lab 05 - File and Service Management

## Playbook

```yaml
---
- name: Configure Apache
  hosts: ubuntu_servers
  become: yes

  tasks:

    - name: Install apache2
      apt:
        name: apache2
        state: present

    - name: Create index page
      copy:
        dest: /var/www/html/index.html
        content: "Hello from Ansible"

    - name: Restart apache
      service:
        name: apache2
        state: restarted
```