#! /bin/bash

sudo yum install -y mysql
mysql -h ${db_host} -u${db_root_user} -p${db_root_password} -e "CREATE DATABASE IF NOT EXISTS ${db_name};CREATE USER IF NOT EXISTS '${db_ranger_user}'@'%' IDENTIFIED BY '${db_ranger_passwod}';GRANT ALL PRIVILEGES ON ranger.* TO '${db_ranger_user}'@'%' WITH GRANT OPTION;" 

sudo yum install -y java-1.8.0-openjdk-devel
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0' | sudo tee /etc/profile.d/java.sh
echo 'Defaults env_keep += "JAVA_HOME" ' | sudo tee -a /etc/sudoers
source /etc/profile.d/java.sh

sudo yum install -y mysql
mysql -h ${db_host} -u${db_root_user} -p${db_root_password} -e "CREATE DATABASE IF NOT EXISTS ${db_name};CREATE USER IF NOT EXISTS '${db_ranger_user}'@'%' IDENTIFIED BY '${db_ranger_passwod}';GRANT ALL PRIVILEGES ON ranger.* TO '${db_ranger_user}'@'%' WITH GRANT OPTION;" 

cd ~
sudo yum install -y wget
sudo wget https://downloads.mysql.com/archives/get/file/mysql-connector-java-5.1.46.tar.gz
sudo tar -zxvf mysql-connector-java-5.1.46.tar.gz
sudo cp mysql-connector-java-5.1.46/mysql-connector-java-5.1.46.jar /usr/share/java/

cd /usr/local
sudo wget https://s3.amazonaws.com/paid-qubole/ranger-1.1.0/ranger-1.1.0-admin.tar.gz 
sudo tar zxf ./ranger-1.1.0-admin.tar.gz 
sudo ln -s ranger-1.1.0-admin ranger-admin 
sudo rm ranger-1.1.0-admin.tar.gz 
cd ranger-admin 

sudo sed -i 's/mysql-connector-java.jar/mysql-connector-java-5.1.46.jar/g' install.properties  
sudo sed -i 's/db_root_password=/db_root_password='${db_root_password}'/g' install.properties  
sudo sed -i 's/db_host=localhost/db_host='${db_host}'/g' install.properties 
sudo sed -i 's/db_password=/db_password='${db_ranger_passwod}'/g' install.properties 

sudo sed -i 's~audit_solr_urls=~audit_solr_urls=http://'${solr_url}':6083/solr/ranger_audits~g' install.properties

sudo ./setup.sh | sudo tee /tmp/setup_log.txt

sudo ./set_globals.sh 
sudo ./set_globals.sh

cd /usr/bin 
sudo ln -sf /usr/local/ranger-admin/ews/start-ranger-admin.sh ranger-admin-start 
sudo ln -sf /usr/local/ranger-admin/ews/stop-ranger-admin.sh ranger-admin-stop

sudo service ranger-admin start

sudo service ranger-admin stop

cd /usr/local/ranger-admin
sudo ./setup.sh | sudo tee -a /tmp/setup_log.txt
sudo service ranger-admin start | sudo tee -a /tmp/setup_log.txt