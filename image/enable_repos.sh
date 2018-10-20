#!/bin/bash
set -e
source /pd_build/buildconfig

header "Preparing APT repositories"

## PostgreSQL Global Development Group (PGDG)repository
echo deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main > /etc/apt/sources.list.d/pgdg.list

## Phusion Passenger
echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list

## Rowan's Redis PPA
echo deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu xenial main > /etc/apt/sources.list.d/redis.list

## OpenJDK 8 PPA
echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main > /etc/apt/sources.list.d/openjdk8.list

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

## Update package information
run apt-get update

## NodeSource's Node.js repository
curl --fail -sL https://deb.nodesource.com/setup_6.x | bash -
