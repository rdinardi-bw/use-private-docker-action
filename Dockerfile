FROM alpine:3.13
RUN apk add --update docker openrc bash yq curl
RUN rc-update add docker boot

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
