FROM alpine:3.12
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> "/etc/apk/repositories"
RUN apk add --update docker openrc bash yq curl
RUN rc-update add docker boot

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
