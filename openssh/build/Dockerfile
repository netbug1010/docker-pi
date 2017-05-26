#
# Dockerfile for openssh
#

FROM resin/armhf-alpine:3.5
MAINTAINER James Liang <ccie.15078@gmail.com>

RUN set -xe \
    && apk add --no-cache openssh \
    && mkdir -p 700 /root/.ssh \
    && mv /etc/ssh /root/.ssh/ssh \
    && ln -s /root/.ssh/ssh /etc/ssh

COPY docker-entrypoint.sh /entrypoint.sh

WORKDIR /root
VOLUME /root

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
