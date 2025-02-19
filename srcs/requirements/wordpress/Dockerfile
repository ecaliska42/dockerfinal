FROM debian:12

RUN apt-get update && apt-get upgrade -y
RUN apt-get install php-fpm -y
RUN apt-get install php-mysqli -y
RUN apt-get install curl -y
RUN apt-get install default-mysql-client -y

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY ./tools/wp-cli_install.sh .
RUN chmod 777 wp-cli_install.sh

CMD ["./wp-cli_install.sh"]
