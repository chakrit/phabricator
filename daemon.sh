#!/bin/sh

set +x

/p/phabricator/bin/phd start

alias allphps="pgrep php"

while true
do
  if [ -z "$(allphps)" ]; then
    exit 0
  fi

  for P in $(allphps)
  do
    echo "waiting for $P"
    lsof -p "$P" +r &>/dev/null
  done

  sleep 30
done
