FROM centos

ARG DEFAULT_PASS=SuperSecret
ARG WEBMIN_URL="http://prdownloads.sourceforge.net/webadmin/webmin-1.900-1.noarch.rpm"

# install basic packages and webmin requirements for LDAP management
RUN yum install -y net-tools perl perl-Net-SSLeay openssl perl-LDAP perl-XML-Parser perl-Encode-Detect openssh-clients
# download webmin
RUN curl -L -o /opt/webmin.rpm $WEBMIN_URL && rpm -i /opt/webmin.rpm

# create a user for webmin
#RUN useradd -g users -m -s /bin/bash webmin && echo MySecret | passwd webmin --stdin
# set root password for webmin
RUN echo $DEFAULT_PASS | passwd root --stdin

COPY files/* /opt/
RUN chmod 755 /opt/*sh

ENTRYPOINT /opt/start.sh

