#!/bin/bash

chmod -R 777 /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    mysqld --user=mysql --init-file=/etc/mysql/init.sql --datadir=/var/lib/mysql &
    sleep 10
    # mysqladmin -u root -prootpassword shutdown
    mysqladmin -u $SQLUSER -p$SQLPW shutdown
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql
