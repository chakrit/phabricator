FROM alpine:edge

# base system
RUN apk add --no-cache \
  git \
  git-daemon \
  ca-certificates \
  gettext \
  procps

# php + app runtime
RUN apk add --no-cache \
  apache2 \
  apache2-ctl \
  php7 \
  php7-apache2 \
  php7-ctype \
  php7-curl \
  php7-fileinfo \
  php7-gd \
  php7-json \
  php7-mbstring \
  php7-mysqli \
  php7-opcache \
  php7-openssl \
  php7-pcntl \
  php7-pear \
  php7-pecl-apcu \
  php7-posix \
  php7-zip \
  python3
RUN pip3 install -q pygments

# the app
RUN mkdir /p
WORKDIR /p

RUN git clone git://github.com/phacility/libphutil && \
  git clone git://github.com/phacility/arcanist && \
  git clone git://github.com/phacility/phabricator

ADD preamble.php           /p/phabricator/support/preamble.php
ADD phabricator-httpd.conf /etc/apache2/conf.d/phabricator.conf
ADD entrypoint.sh          /p/entrypoint.sh
ADD daemon.sh              /p/daemon.sh

# entrypoint
ENV PATH "/p/phabricator/bin:/usr/libexec/git-core:$PATH"
ENTRYPOINT ["./entrypoint.sh"]
