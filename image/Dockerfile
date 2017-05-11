FROM yabawock/baseimage:1.0.1
MAINTAINER Morton Jonuschat <m.jonuschat@mojocode.de>

ADD . /pd_build
RUN /pd_build/install.sh
CMD ["/sbin/my_init"]
EXPOSE 80 443
