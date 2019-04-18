#!/usr/bin/env bash
#
# Author: ZHM
# Email:980583705@qq.com
# Date: 2019/04/18
# usage: transfer key

rpm -qa | grep expect
if [ ! $? -eq 0 ];then 
  yum -y install expect
fi

CreateKey(){
  /usr/bin/expect <<-EOF
  spawn ssh-keygen
  expect ":" { send "\r" }
  expect ":" { send "\r" }
  expect ":" { send "\r" }
  expect eof
EOF
}

TransferKey(){
/usr/bin/expect <<-EOF
  spawn ssh-copy-id $User@$Ip
  expect "yes/no" { send "yes\r" }
  expect "password:" { send "$Passwd\r" }
  expect eof
EOF
}

Information(){
  read -p"please input your username: " User
  read -p"please input your IPaddress: " Ip
  read -p"please input your passeord: " Passwd
  
}

if [ -f $HOME/.ssh/id_rsa ];then
  Information
  TransferKey
else
  CreateKey
  Information
  TransferKey
fi



