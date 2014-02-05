#!/bin/sh
# put other system startup commands here

# set tc user's password.
echo "tc:tcuser" | chpasswd

# install tcz packages.
sudo -u tc tce-load -i /opt/tcz/*.tcz &

# show ip address
while :
do
  INET_COUNT=$(/sbin/ifconfig | grep inet | wc -l)
  if [ $INET_COUNT -ge 2 ];then
    /sbin/ifconfig eth0 | grep inet | awk '{print $2}' > /dev/tty1
    break
  fi
  sleep 1
done

# waiting backgrounded process.
wait

# sshd
cp -a /usr/local/etc/ssh/sshd_config_example /usr/local/etc/ssh/sshd_config
/usr/local/etc/init.d/openssh start > /dev/null
while :
do
  SSHD_PROCESS=$(ps -ef | grep ssh[d] | wc -l)
  if [ $SSHD_PROCESS -ge 1 ];then
     echo "[info] sshd start" > /dev/tty1
    break
  fi
  sleep 1
done

# mount hdds
for hdd in $(grep ext /etc/fstab | awk '{print $1}')
do
  mount $hdd && echo "[info] mount $hdd." > /dev/tty1
done

# waiting backgrounded process.
wait

echo "[end] opt/bootlocal.sh"
