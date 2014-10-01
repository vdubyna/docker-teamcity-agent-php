# docker run -e TEAMCITY_SERVER=http://buildserver:8111 -dt -p 9090:9090 ariya/centos6-teamcity-agent

FROM ariya/centos6-oracle-jre7

MAINTAINER Volodymyr Dubyna <vovikha@gmail.com>

WORKDIR /tmp

ADD ./install/ /

# Install EPEL
RUN yum -y update && yum install -y wget && cd /tmp
# Import Key
RUN wget --no-check-certificate https://fedoraproject.org/static/0608B895.txt -O /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

# Add Repository
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh epel-release-6-8.noarch.rpm && rm epel-release-6-8.noarch.rpm

RUN yum -y update
RUN chmod +x /setup-agent.sh
RUN yum install -y unzip git nodejs npm httpd php php-mbstring xorg-x11-server-Xvfb firefox
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer
RUN mkdir -p /usr/local/lib/selenium && wget -q -P /usr/local/lib/selenium http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar

EXPOSE 9090
CMD /setup-agent.sh run
