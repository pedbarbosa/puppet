FROM centos:7
MAINTAINER Pedro Barbosa <pedbarbosa@users.noreply.github.com>
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y install puppet-server hostname tar
ADD autosign.conf /etc/puppet/autosign.conf
CMD puppet master --verbose --no-daemonize
EXPOSE 8140
