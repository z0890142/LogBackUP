FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk --no-cache add findutils && \
    rm -rf /var/cache/apk/*
    
Add ./crontab.txt /crontab.txt
Add ./script.sh /script.sh
COPY ./entry.sh /entry.sh
RUN chmod 755 /script.sh /entry.sh
RUN /usr/bin/crontab /crontab.txt
# RUN echo "*/30 * * * * sh /script.sh >> /var/log/script.log 2>&1" > /usr/bin/crontab

CMD ["/entry.sh"]