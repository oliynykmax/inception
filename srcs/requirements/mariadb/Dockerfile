ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf
COPY ./tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]
CMD ["mysqld", "--user=mysql"]
