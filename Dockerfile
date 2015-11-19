FROM centos:6.6

MAINTAINER Dr. Doom <doom@dev-ops.de>

RUN yum -y update

RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel openssh

RUN rpm -Uvh http://repo.rundeck.org/latest.rpm

RUN yum install -y rundeck

RUN mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./container-startup.sh /bin/container-startup.sh

EXPOSE 4440 4443

VOLUME  ["/etc/rundeck", "/var/rundeck", "/var/lib/rundeck"]

CMD ["/bin/container-startup.sh"]
