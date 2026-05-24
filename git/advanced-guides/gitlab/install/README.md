## Install and Configure GitLab CE on Ubuntu

> **`Installing Required Dependencies`**
```
sudo apt update
sudo apt install ca-certificates curl openssh-server postfix
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
```
> **`Install GitLab CE`**
```
sudo apt install gitlab-ce
```

> **`Set the GitLab URL`**
```
vi /etc/gitlab/gitlab.rb

external_url 'https://gitlab.example.com' or "set your ip"
```

> **`reconfigure Gitlab`**
```
sudo gitlab-ctl reconfigure
```

> **`Login to GitLab UI`**
```
from the browser

  http://vmip:80

default credentials 
      username: root
      password: <find from below file on your server>

           cat /etc/gitlab/initial_root_password
```
