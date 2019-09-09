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
    tail --pid="$P" -f /dev/null # wait for $P to exit
  done

  sleep 3
done
