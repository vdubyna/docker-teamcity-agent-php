# docker run -e TEAMCITY_SERVER=http://buildserver:8111 -dt -p 9090:9090 ariya/centos6-teamcity-agent

FROM ariya/centos6-oracle-jre7

MAINTAINER Volodymyr Dubyna <vovikha@gmail.com>

WORKDIR /tmp

ADD ./install/ /
RUN yum -y update 
RUN yum install -y unzip git httpd php php-mbstring xorg-x11-server-Xvfb firefox xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer
RUN mkdir -p /usr/local/lib/selenium && wget -q -P /usr/local/lib/selenium http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar

EXPOSE 9090
CMD /setup-agent.sh run
