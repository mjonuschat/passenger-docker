#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

/pd_build/enable_repos.sh
/pd_build/prepare.sh
/pd_build/utilities.sh

if [[ "$ruby20" = 1 ]]; then /pd_build/ruby-2.0.0.sh; fi
if [[ "$ruby21" = 1 ]]; then /pd_build/ruby-2.1.10.sh; fi
if [[ "$ruby22" = 1 ]]; then /pd_build/ruby-2.2.10.sh; fi
if [[ "$ruby23" = 1 ]]; then /pd_build/ruby-2.3.8.sh; fi
if [[ "$ruby24" = 1 ]]; then /pd_build/ruby-2.4.5.sh; fi
if [[ "$jruby91" = 1 ]]; then /pd_build/jruby-9.1.17.0.sh; fi
if [[ "$python" = 1 ]]; then /pd_build/python.sh; fi
if [[ "$nodejs" = 1 ]]; then /pd_build/nodejs.sh; fi
if [[ "$redis" = 1 ]]; then /pd_build/redis.sh; fi
if [[ "$memcached" = 1 ]]; then /pd_build/memcached.sh; fi

# Must be installed after Ruby, so that we don't end up with two Ruby versions.
/pd_build/nginx-passenger.sh

/pd_build/finalize.sh
