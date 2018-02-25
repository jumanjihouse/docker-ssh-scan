ssh_scan
========

This git repo provides [mozilla/ssh_scan](https://github.com/mozilla/ssh_scan)
in a Docker container.

Project:            https://github.com/jumanjihouse/docker-ssh-scan<br/>
Docker image:       https://registry.hub.docker.com/u/jumanjiman/ssh_scan/<br/>

[![Download size](https://images.microbadger.com/badges/image/jumanjiman/ssh_scan.svg)](http://microbadger.com/images/jumanjiman/ssh_scan "View on microbadger.com")&nbsp;
[![Version](https://images.microbadger.com/badges/version/jumanjiman/ssh_scan.svg)](http://microbadger.com/images/jumanjiman/ssh_scan "View on microbadger.com")&nbsp;
[![Source code](https://images.microbadger.com/badges/commit/jumanjiman/ssh_scan.svg)](http://microbadger.com/images/jumanjiman/ssh_scan "View on microbadger.com")&nbsp;
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/ssh_scan.svg)](https://hub.docker.com/r/jumanjiman/ssh_scan)&nbsp;
[![CircleCI](https://circleci.com/gh/jumanjihouse/docker-ssh-scan.svg?style=svg&circle-token=aa7b5360722dd344c66e044f2d75aeac002bbf4d)](https://circleci.com/gh/jumanjihouse/docker-ssh-scan/tree/master 'View CI builds')


How-to
------

### Build and test

We use circleci to build, test, and publish the image to Docker hub.

    ci/build
    ci/test


### Pull an already-built image

    docker pull jumanjiman/ssh_scan


### Tags

We provide multiple tags:

* optimistic:  `jumanjiman/ssh_scan:latest`
* pessimistic: `jumanjiman/ssh_scan:<version>_<builddate>_git_<hash>`

Example:

    jumanjiman/ssh_scan:0.0.21-14-g36f8a92_20170608T1421_git_7361b44
                        ^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^     ^^^^^^^
                                |                |              |
                                |                |              +--> hash from this git repo
                                |                |
                                |                +-----------------> build date and time
                                |
                                +----------------------------------> version of ssh_scan


### Labels

Each built image has labels that generally follow http://label-schema.org/

We add a label, `ci-build-url`, that is not currently part of the schema.
This extra label provides a permanent link to the CI build for the image.

View the ci-build-url label on a built image:

    docker inspect \
      -f '{{ index .Config.Labels "io.github.jumanjiman.ci-build-url" }}' \
      jumanjiman/ssh_scan

Query all the labels inside a built image:

    docker inspect jumanjiman/ssh_scan | jq -M '.[].Config.Labels'


### Run

Interactively:

    docker run --rm -it \
    --read-only \
    --cap-drop all \
    jumanjiman/ssh_scan --target <some_ip> --port <some_port> --policy /etc/ssh_scan/stribika.yml
