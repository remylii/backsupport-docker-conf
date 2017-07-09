FROM library/amazonlinux:2017.03

MAINTAINER remyli

RUN yum update -y
RUN yum install -y wget zip unzip vim git

# mysql
RUN yum -y install http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
RUN yum install -y mysql-community-client

# apache
RUN yum -y install httpd24 httpd24-httpd-devel

COPY ./httpd.conf /etc/httpd/conf/httpd.conf

# php
RUN yum -y install php70 php70-mbstring php70-pdo php70-pecl-zip php70-mysqlnd
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require "laravel/installer"
ENV PATH $PATH:/root/.composer/vendor/bin

EXPOSE 80

# exec
CMD ["/sbin/init"]
