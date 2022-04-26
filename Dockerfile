FROM alpine:3.13
#RUN mkdir 'etc/docker' && echo '{ "dns": ["8.8.8.8"] }' > "/etc/docker/daemon.json"
RUN apk add --update docker openrc bash yq curl
RUN rc-update add docker boot

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
