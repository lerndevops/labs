
# Ansible Ad-Hoc Commands

Ad-hoc commands are one-liner Ansible commands that perform a single task on the target host(s). They are useful for quick tasks without writing a playbook.

You can run ad-hoc commands against hosts defined in your inventory file.

## 1. Running Ad-Hoc Commands with SSH Keys (Recommended)

### Step 1: Ping all hosts in the default inventory
```sh
ansible all -m ping
```

### Step 2: Gather system facts from all hosts
```sh
ansible all -m setup
```

### Step 3: Run a shell command (e.g., check memory) on a group
```sh
ansible dev -m shell -a "free -m"
```

### Step 4: Copy a file to hosts in a group
```sh
ansible iat -m copy -a "src=/tmp/naresh.txt dest=/tmp"
```

### Step 5: Create an empty file on hosts in a group
```sh
ansible prod -m file -a "path=/tmp/helousername.txt state=touch"
```

### Step 6: Run a command with a custom inventory file
```sh
ansible all -i /path/to/inventory -m ping
```

### Step 7: Run a command as root (become)
```sh
ansible all -i /path/to/inventory -b -m ping
ansible dev -i /path/to/inventory -m copy -a "src=/tmp/new.txt dest=/tmp" -b
```

### More Simple Examples

#### Check disk usage on all hosts
```sh
ansible all -m shell -a "df -h"
```

#### List files in /tmp on a group
```sh
ansible dev -m shell -a "ls -l /tmp"
```

#### Reboot all hosts in a group
```sh
ansible qa -m reboot -a "reboot_timeout=300"
```

## 2. Running Ad-Hoc Commands with Username/Password (No SSH Keys)

Add `-u username -k` to prompt for password authentication.

### Step 1: Ping all hosts with username/password
```sh
ansible all -m ping -u username -k
```

### Step 2: Run a shell command with username/password
```sh
ansible dev -m shell -a "free -m" -u username -k
```

### Step 3: Copy a file with username/password
```sh
ansible iat -m copy -a "src=/tmp/naresh.txt dest=/tmp" -u username -k
```

### Step 4: Use a custom inventory with username/password
```sh
ansible all -i /path/to/inventory -u username -k -m ping
ansible dev -i /path/to/inventory -m copy -a "src=/tmp/new.txt dest=/tmp" -u username -k
```

### Step 5: Run as root (become) with username/password
```sh
ansible all -i /path/to/inventory -b -u username -k -K -m ping
ansible dev -i /path/to/inventory -m copy -a "src=/tmp/new.txt dest=/tmp" -b -u username -k -K
```
