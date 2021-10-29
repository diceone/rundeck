FROM centos:6.10

MAINTAINER Dr. Doom <doom@dev-ops.de>

RUN yum -y update

RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel openssh
RUN yum -y install epel-release
RUN yum -y install supervisor

RUN rpm -Uvh http://repo.rundeck.org/latest.rpm

RUN yum install -y rundeck

RUN mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./container-startup.sh /bin/container-startup.sh

# Change MYHOST to your IP or hostname
RUN sed -i "s/localhost:4440/$MYHOST:4440/g" /etc/rundeck/rundeck-config.properties
RUN sed -i "s/localhost:4440/$MYHOST:4440/g" /etc/rundeck/framework.properties
# Change the Rundeck admin password
RUN sed -i "s/^admin:admin/admin:$RDPASS/g" /etc/rundeck/realm.properties
RUN sed -i "s/framework.server.password = admin/framework.server.password = $RDPASS/g" /etc/rundeck/framework.properties

EXPOSE 4440 4443

VOLUME  ["/etc/rundeck", "/var/rundeck", "/var/lib/rundeck"]

CMD ["/bin/container-startup.sh"]
