#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Brightbox Ruby 1.9.3, 2.0, 2.1, 2.2 and 2.3
echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list

## NGINX Stable Releases
echo deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main > /etc/apt/sources.list.d/nginx-stable.list

## PostgreSQL Global Development Group (PGDG)repository
echo deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main > /etc/apt/sources.list.d/pgdg.list

## Phusion Passenger
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list
else
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list
fi

## Rowan's Redis PPA
echo deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu trusty main > /etc/apt/sources.list.d/redis.list

## OpenJDK 8 PPA
echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main > /etc/apt/sources.list.d/openjdk8.list

# The recv-keys part takes a bit of time, so it's faster to receive multiple keys at once.
#
# Brightbox
# Phusion Passenger
# Rowan's Redis PPA
# OpenJDK 8 PPA
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
	C3173AA6 \
	561F9B9CAC40B2F7 \
	C7917B12 \
	C300EE8C \
	ACCC4CF8 \
	DA1A4A13543B466853BAF164EB9B1D8886F44E2A

## NodeSource's Node.js repository
curl --fail -sL https://deb.nodesource.com/setup_4.x | bash -
