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

  dnf module disable nodejs -y &>>$LOGFILE
  VALIDATE $? "disabling nodejs"

  dnf module enable nodejs:20 -y &>>$LOGFILE
  VALIDATE $? "enabling nodejs:20"

  dnf install nodejs -y &>>$LOGFILE
  VALIDATE $? "installing nodejs"

  useradd expense -y &>>$LOGFILE
  VALIDATE $? "Creating expense user"








