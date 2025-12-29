FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf
RUN chmod 664 /etc/my.cnf.d/my.cnf

COPY ./tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

HEALTHCHECK --interval=10s --timeout=10s --retries=5 \
    CMD mariadb-admin ping --protocol=tcp --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD --silent || exit 1

ENTRYPOINT ["init_db.sh"]
