FROM armhf/alpine:3.5
MAINTAINER James Liang <ccie.15078@gmail.com>

RUN apk --no-cache add mariadb mariadb-client pwgen

ADD files/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
