#!/bin/bash
set -e
source /pd_build/buildconfig
source /etc/environment

header "Installing Phusion Passenger..."

## Phusion Passenger requires Ruby. Install it through RVM, not APT,
## so that the -customizable variant cannot end up having Ruby installed
## from APT and Ruby installed from RVM.
run /pd_build/ruby_support/prepare.sh
run /usr/local/rvm/bin/rvm install ruby-2.3.1
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby2.3 ruby-2.3.1 ruby
run /pd_build/ruby_support/finalize.sh

## Install Phusion Passenger.
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	run apt-get install -y nginx-extras passenger-enterprise
else
	run apt-get install -y nginx-extras passenger
fi
run cp /pd_build/config/30_presetup_nginx.sh /etc/my_init.d/
run cp /pd_build/config/nginx.conf /etc/nginx/nginx.conf
run mkdir -p /etc/nginx/main.d
run cp /pd_build/config/nginx_main_d_default.conf /etc/nginx/main.d/default.conf

## Install Nginx runit service.
run mkdir /etc/service/nginx
run cp /pd_build/runit/nginx /etc/service/nginx/run
run touch /etc/service/nginx/down

run mkdir /etc/service/nginx-log-forwarder
run cp /pd_build/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run

# Fix nginx log rotation
sed -i 's|invoke-rc.d nginx rotate >/dev/null 2>&1|if [ -f /var/run/nginx.pid ]; then \\\n\t\t\tkill -USR1 `cat /var/run/nginx.pid` >/dev/null 2>\&1; \\\n\t\tfi \\|g' /etc/logrotate.d/nginx

## Precompile Ruby extensions.
if [[ -e /usr/bin/ruby2.4 ]]; then
  run ruby2.4 -S passenger-config build-native-support
  run setuser app ruby2.4 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.3 ]]; then
	run ruby2.3 -S passenger-config build-native-support
	run setuser app ruby2.3 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.2 ]]; then
	run ruby2.2 -S passenger-config build-native-support
	run setuser app ruby2.2 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.1 ]]; then
	run ruby2.1 -S passenger-config build-native-support
	run setuser app ruby2.1 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.0 ]]; then
	run ruby2.0 -S passenger-config build-native-support
	run setuser app ruby2.0 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/jruby ]]; then
	run jruby --dev -S passenger-config build-native-support
	run setuser app jruby -S passenger-config build-native-support
fi
