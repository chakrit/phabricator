# PHABRICATOR in Docker

[![Build Status](https://cloud.drone.io/api/badges/chakrit/phabricator/status.svg)](https://cloud.drone.io/chakrit/phabricator)

Minimal image to spin up phabricator in a docker container.

To spin up phabricator:

```
docker run --restart=always --name phabricator -d \
  -v /mnt/phabricator/config:/p/phabricator/conf/local \
  -e APACHE_SERVER_NAME=phabricator.example.com \
  -e PHABRICATOR_BASE_URI=http://phabricator.example.com \
  -e PHABRICATOR_MYSQL_HOST=mysql \
  -e PHABRICATOR_MYSQL_PORT=3306 \
  -e PHABRICATOR_MYSQL_USER=root \
  -e PHABRICATOR_MYSQL_PASS=change_me_dont_deploy_this \
  chakrit/phabricator
```

Visit the site and follow the on-screen instructions. Use `docker exec -it phabricator
/bin/sh` to get a console and use the scripts in the `bin/` folder.

To spin up the daemon, use the `daemon.sh` script:

```
docker run --restart=always --name phabricator -d \
  -v /mnt/phabricator/config:/p/phabricator/conf/local \
  -e APACHE_SERVER_NAME=phabricator.example.com \
  -e PHABRICATOR_BASE_URI=http://phabricator.example.com \
  -e PHABRICATOR_MYSQL_HOST=mysql \
  -e PHABRICATOR_MYSQL_PORT=3306 \
  -e PHABRICATOR_MYSQL_USER=root \
  -e PHABRICATOR_MYSQL_PASS=change_me_dont_deploy_this \
  chakrit/phabricator \
  ./daemon.sh
```

Alternatively, you can also run individual daemons in their own containers by manually
using `phd debug DaemonName`.

### ENV VARS

These are applied to phabricator/apache via the entrypoint.sh startup script:

```
APACHE_SERVER_NAME
PHABRICATOR_BASE_URI
PHABRICATOR_MYSQL_HOST
PHABRICATOR_MYSQL_PORT
PHABRICATOR_MYSQL_USER
PHABRICATOR_MYSQL_PASS
```

The names should be self-explanatory.

