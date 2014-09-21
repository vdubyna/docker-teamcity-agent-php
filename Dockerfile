# docker run -e TEAMCITY_SERVER=http://buildserver:8111 -dt -p 9090:9090 ariya/centos6-teamcity-agent

FROM ariya/centos6-oracle-jre7

MAINTAINER Volodymyr Dubyna <vovikha@gmail.com>

WORKDIR /tmp

ADD ./install/ /
RUN mv /xvfb /etc/init.d/xvfb
RUN mv /selenium /etc/init.d/selenium
RUN yum -y update 
RUN yum install -y unzip git httpd php php-mbstring xorg-x11-server-Xvfb firefox xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer
RUN mkdir -p /usr/local/lib/selenium && wget -q -P /usr/local/lib/selenium http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar
RUN mkdir -p /var/log/selenium/ && chmod a+w /var/log/selenium/
RUN chmod +x /etc/init.d/selenium
RUN chkconfig selenium on 
RUN ls -la /etc/init.d/
RUN service selenium start
RUN chmod +x /etc/init.d/xvfb && chkconfig xvfb on && service xvfb start

EXPOSE 9090
CMD /setup-agent.sh run
