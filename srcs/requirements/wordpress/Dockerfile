FROM alpine:3.19

#php83-fpm : core, handl php requests
#php83-mysqli: let php talk to mariadb

RUN apk update && apk upgrade && apk add --no-cache \
	php83 \
	php83-fpm\
	php83-mysqli \
	php83-curl \
	php83-dom \
	php83-exif \
	php83-fileinfo \
	php83-mbstring \
	php83-openssl \
	php83-xml \
	php83-zip \
	wget \
	unzip

#let php-frm listen to 9000 (its default por is 127.0.0.1:9000)
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 9000|g' /etc/php83/php-fpm.d/www.conf

#let the system know that php is php83
RUN ln -s /usr/bin/php83 /usr/bin/php

#all wordpress commands need to be run in this folder
WORKDIR /var/www/wordpress

#copy start script
COPY ./tools/auto_config.sh /usr/local/bin/

RUN sed -i 's/\r$//' /usr/local/bin/auto_config.sh

#give exe access
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
#CMD ["sleep", "infinity"]
