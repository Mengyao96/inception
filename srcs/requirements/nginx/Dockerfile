# /src/requirements/nginx/Dockerfile

FROM alpine:3.19

# update , upgrade NGINX and OpenSSL
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# for SSL credential command

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN sed -i 's/\r$//' /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


