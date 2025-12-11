FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#default mariadb: skip networking , or only listen to localhost
#need to modify it into monitor all IP(0.0.0.0
RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

#modify config files
RUN sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf \
	&& sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/init_db.sh /usr/local/bin/

RUN sed -i 's/\r$//' /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]
