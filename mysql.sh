#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%s)
SCRIPTNAME=$( echo $0 | cut -d "." -f1 )
LOGFILE=$TIMESTAMP-$SCRIPTNAME.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $USERID -ne 0 ]
then 
    echo "please run the script with root access"
    exit 1
else     
    echo  "your super user"
fi

VALIDATE() {
    if [ $1 -ne 0 ]
     then 
        echo -e "$2 ..$R FAILED $N"
     else 
           
       echo -e " $2... $G SUCCESS $N"
  fi  
}

  dnf install mysql-server -y &>>$LOGFILE
  VALIDATE $? "installing mysql sever"

  systemctl enable mysqld &>>LOGFILE
  VALIDATE $? "enabling mysql"

  systemctl start mysqld &>>LOGFILE
  VALIDATE $? "start mysql"

  mysql_secure_installation --set-root-pass ExpenseApp@1
  VALIDATE $? "setting up root password"








