FROM centos 

# install basic packages and webmin requirements for LDAP management
RUN yum install -y perl perl-Net-SSLeay openssl perl-LDAP perl-XML-Parser perl-Encode-Detect openssh-clients
# download webmin
RUN curl -L -o /opt/webmin.rpm http://prdownloads.sourceforge.net/webadmin/webmin-1.850-1.noarch.rpm && rpm -i /opt/webmin.rpm

# create a user for webmin
#RUN useradd -g users -m -s /bin/bash webmin && echo MySecret | passwd webmin --stdin
# set root password for webmin
RUN echo SuperSecret | passwd root --stdin


COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/*sh

