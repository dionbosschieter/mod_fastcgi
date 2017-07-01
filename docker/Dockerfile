FROM       debian:latest

# Installation:
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN apt-get update
RUN apt-get install -y wget build-essential libz-dev python autoconf libtool libtool-bin libpcre++-dev libexpat1-dev apache2-dev git
RUN mkdir -vp /root/build/

# build apache24
COPY ./build_apache24.sh /root
RUN bash -e /root/build_apache24.sh

# build mod_fastcgi
COPY ./build_mod_fastcgi.sh /root
RUN bash -e /root/build_mod_fastcgi.sh

EXPOSE 80
