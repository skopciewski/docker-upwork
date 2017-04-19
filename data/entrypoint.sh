#!/bin/bash
[[ "$TRACE" ]] && set -x
set -e

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

create_user() {
  # create group with USER_GID
  if ! getent group ${CONTAINER_USER} >/dev/null; then
    groupadd -f -g ${USER_GID} ${CONTAINER_USER} >/dev/null 2>&1
  fi

  # create user with USER_UID
  if ! getent passwd ${CONTAINER_USER} >/dev/null; then
    adduser --disabled-login --uid ${USER_UID} --gid ${USER_GID} \
      --gecos 'Upwork' ${CONTAINER_USER} >/dev/null 2>&1
  fi
  chown ${CONTAINER_USER}:${CONTAINER_USER} -R /home/${CONTAINER_USER}
}

launch_upwork() {
  cd /home/${CONTAINER_USER}
  exec sudo -HEu ${CONTAINER_USER} PULSE_SERVER=/run/pulse/native QT_GRAPHICSSYSTEM="native" upwork
}

case "$1" in
  upwork)
    echo "Upwork"
    create_user
    launch_upwork
    ;;
  *)
    echo "Command"
    exec $@
    ;;
esac
