FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/public_certificate.crt \
    -keyout /etc/nginx/ssl/private.key \
    -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=42/OU=Hive/CN=maoliiny.42.fr"

RUN addgroup -S www-data || true
RUN adduser -S www-data -G www-data || true

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/lib/nginx /var/log/nginx

EXPOSE 443

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
