#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$($0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2...FAILURE"
        exit 1
    else
       echo "$2...SUCCESS"
    fi       
        

}

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
