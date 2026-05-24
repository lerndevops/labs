# Ansible Lab 07 - Handlers and Loops

## Playbook

```yaml
---
- name: Loops and Handlers
  hosts: ubuntu_servers
  become: yes

  vars:
    packages:
      - git
      - curl
      - wget

  tasks:

    - name: Install packages
      apt:
        name: "{{ item }}"
        state: present
      loop: "{{ packages }}"

    - name: Update web page
      copy:
        dest: /var/www/html/index.html
        content: "Updated"

      notify: restart nginx

  handlers:

    - name: restart nginx
      service:
        name: nginx
        state: restarted
```