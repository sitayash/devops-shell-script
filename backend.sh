#!/bin/bash
source ./common.sh
check_root


dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "disabling defualt nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "enabling nodejs:20 version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Installing nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then  
    useradd expense  &>>$LOGFILE
    VALIDATE $? "creating expense user"
else 
    echo -e "expense user already created...$Y skipping $N"    

fi
mkdir -p /app &>>$LOGFILE
VALIDATE $? "craeting app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading backend code"
cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "EXtracted backend code"

npm install &>>$LOGFILE
VALIDATE $? "Installing nodejs dependencies"


cp  /home/ec2-user/devops-shell-script/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service"





systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon Reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Starting backend"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling backend"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Client"


mysql -h 172.31.93.187 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"