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
    bundle install --no-cache --without=development && \
    apk del --no-cache dev
RUN ln -s /app/config/policies /etc/ssh_scan

ENTRYPOINT ["/app/bin/ssh_scan"]
CMD ["-h"]

VOLUME /app/data

ARG CI_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    io.github.jumanjiman.ci-build-url=${CI_BUILD_URL} \
    io.github.jumanjiman.version=${VERSION} \
    io.github.jumanjiman.build-date=${BUILD_DATE} \
    io.github.jumanjiman.vcs-ref=${VCS_REF} \
    io.github.jumanjiman.license="Mozilla Public License 2.0" \
    io.github.jumanjiman.docker.dockerfile="/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-ssh-scan.git"
