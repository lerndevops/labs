update_conf()
{
   sudofile="/etc/sudoers"
   sshdfile="/etc/ssh/sshd_config"
   sshdconfd="/etc/ssh/sshd_config.d"
   mkdir -p /home/backup
   if [ -f $sudofile ];then
        cp -p $sudofile /home/backup/sudoers-$now
        sa=`grep $USER $sudofile | wc -l`
        if [ $sa -gt 0 ];then
             echo "$USER user already present in $sudofile - no changes required"
             grep $USER $sudofile
        else
             echo "$USER ALL=(ALL) NOPASSWD: ALL" >> $sudofile
             echo "updated the sudoers file successfully"
        fi
   else
        echo "could not find $sudofile"
   fi
   if [ -d $sshdconfd ];then
       if [ -f $sshdconfd/60-cloudimg-settings.conf ];then
            sed -i '/PasswordAuthentication.*no/d' $sshdconfd/60-cloudimg-settings.conf
            sed -i '/PasswordAuthentication.*yes/d' $sshdconfd/60-cloudimg-settings.conf
            echo "PasswordAuthentication yes" >> $sshdconfd/60-cloudimg-settings.conf
       else
          echo "$sshdconfd/60-cloudimg-settings.conf does not exist"  
       fi
   else
      echo "$sshdconfd does not exist... continue with $sshdfile"
   fi          
   if [ -f $sshdfile ];then
        cp -p $sshdfile /home/backup/sshd_config-$now
        sed -i '/ClientAliveInterval.*0/d' $sshdfile
        echo "ClientAliveInterval 240" >> $sshdfile
        sed -i '/PasswordAuthentication.*no/d' $sshdfile
        sed -i '/PasswordAuthentication.*yes/d' $sshdfile
        echo "PasswordAuthentication yes" >> $sshdfile
        echo "updated $sshdfile Successfully -- restarting sshd service"
        service sshd restart || sudo /usr/sbin/sshd
   else
        echo "could not find $sshdfile"
   fi
}
