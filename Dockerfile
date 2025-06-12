FROM docker:cli

RUN apk add --no-cache bash curl coreutils

COPY push_on_start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/push_on_start.sh

CMD ["bash", "/usr/local/bin/push_on_start.sh"]
