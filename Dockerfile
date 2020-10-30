FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk --no-cache add findutils && \
    rm -rf /var/cache/apk/*

Add ./script.sh /script.sh
COPY ./entry.sh /entry.sh
RUN chmod 755 /script.sh /entry.sh
RUN echo "*/30 * * * * bash /script.sh >> /var/log/script.log 2>&1" > /usr/bin/crontab

CMD ["/entry.sh"]