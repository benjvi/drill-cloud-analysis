#!/bin/sh
apt install default-jre default-jdk jq csvtool awscli
cd /opt
wget http://apache.mirrors.hoobly.com/drill/drill-1.13.0/apache-drill-1.13.0.tar.gz
tar -xvzf apache-drill-1.13.0.tar.gz
rm apache-drill-1.13.0.tar.gz
cd -
echo "Install finished, please add /opt/apache-drill-1.13.0/bin to your PATH"
# if you don't have enough memory to run drill, change the settings as here: http://www.devinline.com/2015/11/apache-drill-setup-and-SQL-query-execution.html 
