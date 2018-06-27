#!/bin/bash

TOMCAT_HOST=192.168.43.130 
TOMCAT_USER=ramesh
TOMCAT_PWD=ramesh
TOMCAT_HOME=/Softwares/apache-tomcat-8.5.24
#
WAR_FILE_PATH=target/TecharroSoft.war

echo "Bringing tomcat server down for deployment..."
sleep 3

$TOMCAT_HOME/bin/shutdown.sh 1>/dev/null 2>&1

#1>file.log 2>&1
if [ -f $WAR_FILE_PATH ];then
    echo "deploying TecharroSoft application..."
    sleep 4
    sshpass -p "ramesh" ssh $TOMCAT_USER@$TOMCAT_HOST
    scp  $WAR_FILE_PATH $TOMCAT_USER@$TOMCAT_HOST:$TOMCAT_HOME/webapps
else
   echo "war file doesn't exist! Please check the build"
fi

echo "starting tomcat server..."
$TOMCAT_HOME/bin/startup.sh 1>/dev/null 2>&1

echo "deployment is successful! Email notification has been sent!"
