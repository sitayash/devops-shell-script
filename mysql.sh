#!/bin/bash
source ./common.sh
check_root

echo "please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "starting mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "setting up root password"
mysql -h 172.31.87.32 -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if  [ $? -ne 0 ]
then  
 mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE  
  VALIDATE $? "mysql root password setup"
else
    echo -e "mysql root password is already setup...$Y skipping $N"
fi          