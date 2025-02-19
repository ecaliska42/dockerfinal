FROM debian:12

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y nginx openssl

RUN groupadd -r nginx && useradd -r -g nginx nginx

RUN openssl genrsa -out server.key 4096 && \
	openssl req -new -key server.key -subj "/C=AT/ST=VIENNA/O=42VIENNA/OU=IT/CN=ecaliska.42.fr" -out server.csr && \
	openssl req -x509 -in server.csr -key server.key -out server.crt

RUN mv server.crt /etc/ssl/certs/
RUN mv server.csr server.key /etc/ssl/private/

RUN chown -R nginx:nginx /var/www/html/
RUN chmod -R 777 /var/www/html/
RUN chown -R nginx:nginx /etc/ssl/
RUN chmod -R 777 /etc/ssl/

COPY ./conf/default /etc/nginx/sites-available/

RUN mkdir -p /var/lib/nginx/body
RUN mkdir -p /run/nginx

RUN chown -R nginx:nginx /var/lib/nginx
RUN chmod 777 /var/lib/nginx

RUN chown -R nginx:nginx /run/nginx
RUN chmod 777 /run/nginx

CMD ["nginx", "-g", "daemon off;"]
