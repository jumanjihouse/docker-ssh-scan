FROM alpine:3.13

RUN apk add --no-cache \
      openssh-client \
      ruby \
      ruby-etc \
      ruby-io-console \
      && :

COPY app /app
COPY policies /app/config/policies
WORKDIR /app

RUN gem install --no-document bundler
RUN apk add --no-cache --virtual=dev \
      build-base \
      ruby-dev \
      && \
    bundle config set no-cache 'true' && \
    bundle install --without=development && \
    apk del --no-cache dev
RUN ln -s /app/config/policies /etc/ssh_scan

ENTRYPOINT ["/app/bin/ssh_scan"]
CMD ["-h"]

VOLUME /app/data
# https://github.com/mozilla/ssh_scan/blob/1169f8712d1f97f970/bin/ssh_scan#L22
ENV HOME /app/data

ARG CI_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF
ARG APP_VERSION

LABEL \
    io.github.jumanjiman.ci-build-url=${CI_BUILD_URL} \
    io.github.jumanjiman.version=${APP_VERSION} \
    io.github.jumanjiman.build-date=${BUILD_DATE} \
    io.github.jumanjiman.vcs-ref=${VCS_REF} \
    io.github.jumanjiman.license="Mozilla Public License 2.0" \
    io.github.jumanjiman.docker.dockerfile="/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-ssh-scan.git"
