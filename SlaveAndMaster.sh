#!/usr/bin/enc bash
#
# author: zhm
# email: 980593705@qq.com
# data: 2019/04/18
# usage: change master 

if [ ! -e /usr/sbin/ifconfig ];then 
  yum -y install net-tools
fi

IP=$(ifconfig | awk -F" " 'NR==2 { print $2 }'|awk -F"." '{ print $4 }')
sed -ri s/server_id.*/server_id=$IP/g ./my.cnf

Passwd='Zhm..1023'
mysql -uroot -p"$Passwd" -e"stop slave;"
mysql -uroot -p"$Passwd" -e"reset slave;"
read -p"input master ip:" Ip
read -p"input master username" Username
read -sp"input master-usr's passwd:" passwd_usr
read -p"input master_log_file: " File
read -p"input master_log_pos: " Pos

mysql -uroot -p"$Passwd" -e"change master to master_host='$Ip',master_user='$Username',master_password='$passwd_usr',master_log_file='$File',master_log_pos=$Pos;"
mysql -uroot -p"$Passwd" -e"start slave;"
mysql -uroot -p"$Passwd" -e"show slave status\G;"
