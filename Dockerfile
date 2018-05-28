FROM ubuntu:18.04

RUN mkdir -p /etc/ssl
RUN mkdir -p /tmp

COPY localhost.conf /tmp

RUN apt update
RUN apt install -y --no-install-recommends libnss3-tools
RUN apt install -y --no-install-recommends openssl

RUN openssl req \
        -batch \
        -new \
        -x509 \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/ssl/localhost.key \
        -out /etc/ssl/localhost.crt \
        -config /tmp/localhost.conf \
        -passin pass:localhost1234

RUN openssl pkcs12 -export -out /etc/ssl/localhost.pfx -inkey /etc/ssl/localhost.key -in /etc/ssl/localhost.crt -passout pass:localhost1234 -passin pass:localhost1234
