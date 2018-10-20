#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Node.js (also needed for Rails asset compilation)
minimal_apt_get_install nodejs

run npm update npm -g
if [[ ! -e /usr/bin/node ]]; then
  run ln -s /usr/bin/nodejs /usr/bin/node
fi
