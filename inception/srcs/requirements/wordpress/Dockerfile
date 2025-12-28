FROM alpine:3.22

RUN apk update && apk add --no-cache \
    curl \
    mariadb-client \
    php84 \
    php84-curl \
    php84-fpm \
    php84-gd \
    php84-iconv \
    php84-json \
    php84-mbstring \
    php84-mysqli \
    php84-openssl \
    php84-phar \
    php84-session \
    php84-tokenizer \
    php84-xml \
    php84-zip \
    php84-ctype

RUN ln -s /usr/bin/php84 /usr/bin/php
RUN addgroup -S www-data || true
RUN adduser -S www-data -G www-data || true

COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY ./tools/wp.sh /usr/local/bin/wp.sh
RUN chmod +x /usr/local/bin/wp.sh

EXPOSE 9000

ENTRYPOINT ["wp.sh"]
