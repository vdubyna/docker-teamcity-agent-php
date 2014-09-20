# docker run -e TEAMCITY_SERVER=http://buildserver:8111 -dt -p 9090:9090 ariya/centos6-teamcity-agent

FROM ariya/centos6-oracle-jre7

MAINTAINER VOlodymyr Dubyna <vovikha@gmail.com>

WORKDIR /tmp

ADD ./install /
RUN yum update && yum -y install sudo net-tools unzip wget vim-enhanced mc git nc
RUN adduser teamcity

RUN yum install -y httpd php xvfb firefox xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer

RUN mkdir -p /usr/lib/selenium && wget -P /usr/lib/selenium/selenium-server-standalone.jar http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar

RUN mkdir -p /var/log/selenium/ && chmod 777 /var/log/selenium/
RUN chmod +x /etc/init.d/selenium && systemctl start selenium
RUN chmod +x /etc/init.d/xvfb && systemctl start xvfb

ENV DISPLAY :99

EXPOSE 9090
CMD sudo -u teamcity -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
