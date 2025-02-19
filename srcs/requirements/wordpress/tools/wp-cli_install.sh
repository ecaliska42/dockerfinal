#!/bin/bash

until mysqladmin ping -h mariadb --silent -u root -p"${MYSQL_ROOT_PASSWORD}"; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

chmod 777 -R /var/www/html
cd /var/www/html

if ! command -v wp &> /dev/null; then
    echo "STATUS:Wordpress is not installed"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if ! wp core is-installed --allow-root; then
    wp core download --allow-root
    wp config create --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DBPASS --dbhost=$DBHOST --allow-root
    wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_UNAME_ADMIN --admin_password=$WP_PW_ADMIN --admin_email=$WP_MAIL_ADMIN --allow-root
    wp user create $WP_UNAME $WP_MAIL --user_pass=$WP_PW --allow-root
else
    echo "ERROR:WordPress is already installed."
fi


exec php-fpm8.2 -F
