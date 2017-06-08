FROM alpine:3.6

RUN apk add --no-cache ruby ruby-io-console

COPY app /app
COPY policies /app/config/policies
WORKDIR /app

RUN gem install --no-rdoc --no-ri bundler
RUN apk add --no-cache --virtual=dev \
      build-base \
      ruby-dev \
      && \
    bundle install && \
    apk del --no-cache dev
RUN ln -s /app/config/policies /etc/ssh_scan

ENTRYPOINT ["/app/bin/ssh_scan"]
CMD ["-h"]
