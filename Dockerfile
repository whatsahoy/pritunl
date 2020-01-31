FROM ubuntu:xenial

EXPOSE \
  443

ENV LANG=C.UTF-8

RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list 
RUN echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
RUN apt-get update && apt-get --assume-yes install pritunl mongodb-org
RUN apt-get update && apt-get --assume-yes install iptables

COPY files/ /root/

RUN install --owner=root --group=root --mode=0755 --target-directory=/usr/bin /root/scripts/*
RUN install --owner=root --group=root --mode=0755 --target-directory=/usr/bin /root/tests/* 

RUN pritunl set-mongodb 'mongodb://127.0.0.1:27017/pritunl'

ENTRYPOINT ["/usr/bin/entrypoint"]
