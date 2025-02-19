FROM debian:12

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/init.sql /etc/mysql/init.sql
COPY ./tools/script.sh .

RUN mkdir /run/mysqld

RUN mkdir /var/log/mysql
RUN chown -R mysql:mysql /var/log/mysql

RUN chown -R mysql:mysql /run/mysqld 
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod -R 755 /var/lib/mysql
RUN chmod 777 script.sh

CMD ["./script.sh"]
