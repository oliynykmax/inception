FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf
RUN chmod 664 /etc/my.cnf.d/my.cnf

COPY ./tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["init_db.sh"]
