FROM fedora

# minimal install for net tools and others
RUN dnf -y groupinstall "minimal install"
# install basic packages and webmin requirements for LDAP management
RUN dnf -y install curl vim perl openssl perl-Net-SSLeay.x86_64 perl-DateTime.x86_64 perl-Time-Local.noarch perl-DateTime-Locale.noarch perl-LDAP.noarch
# download webmin
RUN curl -L -o /opt/webmin.rpm http://prdownloads.sourceforge.net/webadmin/webmin-1.810-1.noarch.rpm && rpm -i /opt/webmin.rpm

# create a user for webmin
#RUN useradd -g users -m -s /bin/bash webmin && echo MySecret | passwd webmin --stdin
# set root password for webmin
RUN echo SuperSecret | passwd root --stdin


COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/*sh

