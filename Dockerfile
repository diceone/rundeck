FROM centos:6.6

MAINTAINER Dr. Doom <doom@dev-ops.de>

RUN yum -y update

RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel openssh

RUN rpm -Uvh http://repo.rundeck.org/latest.rpm

RUN yum install -y rundeck

EXPOSE 4440 4443

VOLUME  ["/etc/rundeck", "/var/rundeck", "/var/lib/rundeck"]
