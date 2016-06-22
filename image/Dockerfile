FROM phusion/baseimage:0.9.18
MAINTAINER Morton Jonuschat <m.jonuschat@mojocode.de>

ADD . /pd_build
RUN /pd_build/install.sh
CMD ["/sbin/my_init"]
EXPOSE 80 443
