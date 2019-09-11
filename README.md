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


### CAVEATS

* Most (if not all) configurations which can be done after booting up are left untouched
  to simplify the image construction process. The first thing you need to do, on a clean
  installation, for example is to initialize the MySQL storage and the authentication
  provider:

  ```
  docker exec -it phabricator /bin/sh

  # inside container:
  $ cd /p/phabricator/bin
  $ ./storage upgrade
  $ ./auth unlock # set it up via the GUI, then come back here to re-lock it.
  $ ./config set diffusion.allow-http-auth true
  ```

* The image contains a `sudoers` file which allows the `apache` user inside the container
  to use sudo thereby allowing Diffusion all read and write access to repository data on
  mounted volumes. **This may or may not be what you want.** It is, however, easy to
  override by mounting your own `sudoers` file over it.

  ```
  root ALL=(ALL) SETENV: NOPASSWD: ALL
  apache ALL=(ALL) SETENV: NOPASSWD: ALL
  %wheel ALL=(ALL) SETENV: NOPASSWD: ALL
  %sudo ALL=(ALL) SETENV: NOPASSWD: ALL
  ```
