#!/bin/sh

set -e
cd /p/phabricator/bin

checkconfig() {
  if [ -n "$2" ]; then
    ./config set "$1" "$2"
  fi
}

checkconfig phabricator.base-uri "$PHABRICATOR_BASE_URI"
checkconfig mysql.host           "$PHABRICATOR_MYSQL_HOST"
checkconfig mysql.port           "$PHABRICATOR_MYSQL_PORT"
checkconfig mysql.user           "$PHABRICATOR_MYSQL_USER"
checkconfig mysql.pass           "$PHABRICATOR_MYSQL_PASS"

envsubst < /etc/apache2/conf.d/phabricator.conf > /tmp/phab.conf
mv /tmp/phab.conf /etc/apache2/conf.d/phabricator.conf

if [ -z "$*" ]; then
  apachectl -D FOREGROUND
else
  "$@"
fi
