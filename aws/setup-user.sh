#!/bin/bash

now=`date +%d%b%Y-%H%M`

exp()
{
	"$1" <(cat <<-EOF
	spawn passwd $USER
	expect "Enter new UNIX password:"
	send -- "$passw\r"
	expect "Retype new UNIX password:"
	send -- "$passw\r"
	expect eof
	EOF
	)
	echo "password for USER $USER updated successfully - adding to sudoers file now"
}

setup_pass()
{

if [ $1 == "sles" ];then
  
   if [ ! -f /usr/bin/expect ] && [ ! -f /bin/expect ];then
#        zypper -y update
        zypper install -y expect
        exp "/usr/bin/expect"
   else
        exp "/usr/bin/expect"
   fi

elif [ $1 == "ubuntu" ];then
   
   if [ ! -f /usr/bin/expect ] && [ ! -f /bin/expect ];then
        apt-get update
        apt install -y expect
        exp "/usr/bin/expect"
   else
        exp "/usr/bin/expect"
   fi

elif [ $1 == "amzn" ];then

   echo $1
   if [ ! -f /usr/bin/expect ] && [ ! -f /bin/expect ];then
        rpm -Uvh http://epel.mirror.net.in/epel/6/x86_64/epel-release-6-8.noarch.rpm
        yum install -y expect
        exp "/usr/bin/expect"
   else
        exp "/usr/bin/expect"
   fi

elif [ $1 == "centos" ];then

   echo $1
   if [ ! -f /usr/bin/expect ] && [ ! -f /bin/expect ];then
        rpm -Uvh http://epel.mirror.net.in/epel/6/x86_64/epel-release-6-8.noarch.rpm
        yum install -y expect
        exp "/bin/expect"
   else
        exp "/bin/expect"
   fi
else
   echo "could not find case $1"
fi

}

update_conf()
{
   sudofile="/etc/sudoers"
   sshdfile="/etc/ssh/sshd_config"
   mkdir -p /home/backup
   if [ -f $sudofile ];then
        cp -p $sudofile /home/backup/sudoers-$now
        sa=`grep $USER $sudofile | wc -l`
        if [ $sa -gt 0 ];then
             echo "$USER user already present in $sudofile - no changes required"
             grep $USER $sudofile
        else
#             echo "$USER ALL=(ALL) ALL" >> $sudofile
             echo "$USER ALL=(ALL) NOPASSWD: ALL" >> $sudofile
             echo "updated the sudoers file successfully"
        fi
   else
        echo "could not find $sudofile"
   fi

   if [ -f $sshdfile ];then
        cp -p $sshdfile /home/backup/sshd_config-$now
        sed -i '/ClientAliveInterval.*0/d' $sshdfile
        sed -i '/PermitRootLogin.*yes/d' $sshdfile
        sed -i '/PasswordAuthentication.*no/d' $sshdfile
        sed -i '/PasswordAuthentication.*yes/d' $sshdfile
        sed -i '/PermitRootLogin.*prohibit-password/d' $sshdfile
        echo "PermitRootLogin yes" >> $sshdfile
        echo "PasswordAuthentication yes" >> $sshdfile
        echo "ClientAliveInterval 240" >> $sshdfile
        echo "updated $sshdfile Successfully -- restarting sshd service"
        service sshd restart
   else
        echo "could not find $sshdfile"
   fi
}

############### MAIN ###################

USER="devops"
GROUP="devops"
passw="jdokuans"

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi

case "$osname" in
  sles|amzn|ubuntu|centos)
     userdel -r $USER 
     groupdel $GROUP
     sleep 3
     groupadd $GROUP
     useradd $USER -m -d /home/$USER -s /bin/bash -g $GROUP
     setup_pass $osname
     update_conf
    ;;
  *)
    echo "could not determine the correct osname -- found $osname"
    ;;
esac
exit 0
