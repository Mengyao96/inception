#!/bin/sh

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]
then 
	echo "Database already exists"
else
	#first running
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	#temprarily start database
	echo "Starting temporary server for initialization..."
	/usr/bin/mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

-- 1. to delete defaul empty password for the root user (for safety)
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1','::1');

--2. set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';

--3. create worpress special database
CREATE DATABASE $SQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;

--4. create a user for wordpress and give it rights
-- % : allows to be connected from any IP
CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES on $SQL_DATABASE.* TO '$SQL_USER'@'%';

FLUSH PRIVILEGES;
EOF
fi

#officially start the db
#use exec to let mysqld become the PID1 process
# --console: output dirary to the terminal
echo "Starting MariaDB Server..."
exec /usr/bin/mysqld --user=mysql --console
