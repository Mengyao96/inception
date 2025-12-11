# /src/requirements/nginx/Dockerfile

FROM alpine:3.19

# update , upgrade NGINX and OpenSSL
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# for SSL credential command
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=student/CN=inception.com"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN sed -i 's/\r$//' /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


