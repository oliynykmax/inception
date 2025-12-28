ARG ALPINE_VERSION
ARG PHP_VERSION
ARG WORDPRESS_VERSION

FROM alpine:${ALPINE_VERSION}

ARG PHP_VERSION
ARG WORDPRESS_VERSION

RUN apk update && apk upgrade &&     apk add --no-cache     php82     php82-fpm     php82-mysqli     php82-json     php82-curl     php82-dom     php82-exif     php82-fileinfo     php82-imagick     php82-mbstring     php82-openssl     php82-xml     php82-zip     curl

RUN curl -LO https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz &&     tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz &&     mv wordpress /var/www/html &&     rm wordpress-${WORDPRESS_VERSION}.tar.gz &&     chown -R nobody:nobody /var/www/html

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY ./tools/setup_wp.sh /usr/local/bin/setup_wp.sh
RUN chmod +x /usr/local/bin/setup_wp.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]
CMD ["php-fpm82", "-F"]