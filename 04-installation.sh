#!/bin/bash
USERID=$(id -u)

if  [ $USERID -ne 0 ]
then
    echo "please run this script with root access."
    exit 1
else
     echo "you are super user."
fi
         
dnf install mysql -y

if [ $? -ne 0 ]
then 
    echo "installation if mysql..FAILURE"
    exit 1
else
   echo "Installation of mysql...SUCCESS"
fi       

if [ $? -ne 0 ]
then 
    echo "installation if git..FAILURE"
    exit 1
else
   echo "Installation of git...SUCCESS"
fi   
echo "is script proceeding?"    
