#!/bin/bash
mysql_dir=/usr/local/mysql
mysql_comm=${mysql_dir}/bin
PASSWORD='P@ssword991120'
sleep 10
${mysql_comm}/mysql -e "drop database test;"
${mysql_comm}/mysql -e "delete from mysql.user where user='';"
${mysql_comm}/mysql -e "delete from mysql.user where host='::1';"
${mysql_comm}/mysql -e "delete from mysql.user where user='`hostname`';"
${mysql_comm}/mysqladmin -uroot password $PASSWORD
${mysql_comm}/mysql -uroot -p${PASSWORD} -e "grant all privileges on *.* to tszins@'localhost' identified  by 'P@ssword991120' with grant option; "
${mysql_comm}/mysql -uroot -p${PASSWORD} -e "grant all privileges on *.* to tszins@'%'  identified by 'P@ssword991120' with grant option; "
rm -rf $0
