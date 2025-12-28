ARG ALPINE_VERSION
ARG DOMAIN_NAME

FROM alpine:${ALPINE_VERSION}

ARG DOMAIN_NAME

RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=maoliiny/CN=${DOMAIN_NAME}"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]