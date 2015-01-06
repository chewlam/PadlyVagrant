# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.15

# Set correct environment variables.
ENV HOME /root
RUN mkdir -p /etc/my_init.d

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD include/start_sshd.sh /etc/my_init.d/start_sshd.sh
ADD include/start_web.sh /root/start_web.sh

ADD .vimrc /root/.vimrc

MAINTAINER Chew Lam 

EXPOSE 22 80 4567

# Setup for mongodb shell install
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list



RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y make git curl openssh-server ruby-full mongodb-org-shell


RUN echo 'root:flamingo' | chpasswd

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]



RUN gem install bundler mongo bson_ext sinatra json rack

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

