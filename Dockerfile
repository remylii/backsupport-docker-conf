FROM centos:7

MAINTAINER remyli

RUN yum update -y
RUN yum install -y wget zip unzip vim

# mysql
RUN yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
RUN yum install -y mysql-community-client

# apache
RUN yum -y install centos-release-scl
RUN yum -y install httpd24 httpd24-httpd-devel

COPY ./httpd.conf /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf

# enable service
RUN systemctl enable httpd24-httpd

# php
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum -y install php php71-mbstring php71-pdo php71-pecl-zip php71-mysqlnd --enablerepo=remi-php71
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require "laravel/installer"
ENV PATH $PATH:/root/.composer/vendor/bin

EXPOSE 80

# exec
CMD ["/sbin/init", "systemctl start httpd24-httpd"]
