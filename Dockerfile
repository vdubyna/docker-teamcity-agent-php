# docker run -e TEAMCITY_SERVER=http://buildserver:8111 -dt -p 9090:9090 ariya/centos6-teamcity-agent

FROM ariya/centos6-oracle-jre7

MAINTAINER Volodymyr Dubyna <vovikha@gmail.com>

WORKDIR /tmp

ADD ./install /
RUN yum -y update 
RUN yum -y install sudo unzip wget git
RUN adduser teamcity

RUN yum install -y httpd php php-mbstring xvfb firefox xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer

RUN mkdir -p /usr/lib/selenium && wget -P /usr/lib/selenium http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar

RUN mkdir -p /var/log/selenium/ && chmod 777 /var/log/selenium/
RUN chmod +x /etc/init.d/selenium
RUN chmod +x /etc/init.d/xvfb

ENV DISPLAY :99

CMD sudo -u teamcity -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
