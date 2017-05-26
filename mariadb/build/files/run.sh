#!/bin/sh
set -x

if [ ! -f /var/lib/mysql/ibdata1 ]; then
       echo "[INFO] MySQL data directory not found, creating initial DBs"
       mysql_install_db --user=mysql

       if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
            MYSQL_ROOT_PASSWORD=`pwgen 16 1`
            echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
       fi

       MYSQL_DATABASE=${MYSQL_DATABASE:-""}
       MYSQL_USER=${MYSQL_USER:-""}
       MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

       mysqld_safe & mysqladmin --silent --wait=30 ping || exit 1
       echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES; DROP DATABASE test;" | mysql
       if [ "$MYSQL_DATABASE" != "" ]; then
             echo "[i] Creating database: $MYSQL_DATABASE"
             echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql
             if [ "$MYSQL_USER" != "" ]; then
                   echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
                   echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql
             fi
       fi
       mysqladmin shutdown
else
       echo "[i] MySQL directory already present, skipping creation"
       chown -R mysql:mysql /var/lib/mysql
fi

mysqld_safe

