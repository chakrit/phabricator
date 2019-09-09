FROM alpine:edge

RUN apk add --no-cache \
  git ca-certificates gettext

RUN mkdir /p
WORKDIR /p

RUN git clone git://github.com/phacility/libphutil && \
  git clone git://github.com/phacility/arcanist && \
  git clone git://github.com/phacility/phabricator

RUN apk add --no-cache \
  apache2 apache2-ctl php7 php7-apache2 \
  php7-ctype \
  php7-curl \
  php7-json \
  php7-mbstring \
  php7-mysqli \
  php7-openssl \
  php7-pear

ADD phabricator-httpd.conf /etc/apache2/conf.d/phabricator.conf
ADD init.sh /p/init.sh
CMD ["./init.sh"]
