#!/bin/sh

#anti dumb design

#check if already there
if [ -f ./wp-config.php ]
then
	echo "WordPress already started"
else
	if [ ! -f /usr/local/bin/wp ]; then
	#download wp-cli, convert it into exe
		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
		chmod +x wp-cli.phar
		mv wp-cli.phar /usr/local/bin/wp
	fi

	#download wordpress  core 
	wp core download --allow-root

	echo "Waiting for MariaDB to start..."
	until mysql -h mariadb -u $SQL_USER -p$SQL_PASSWORD -e "SELECT 1" >/dev/null 2>&1; do sleep 2
	done
	echo "MariaDB is ready!"

	#generate config files
	wp config create \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'

	#install wordpress
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL --allow-root

	wp user create \
		$USER1_LOGIN $USER1_EMAIL \
		--role=author \
		--user_pass=$USER1_PASSWORD --allow-root
fi

exec /usr/sbin/php-fpm83 -F

