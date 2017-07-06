FROM centos:7

MAINTAINER remyli

RUN yum install -y sudo yum install mysql
RUN yum install -y wget
RUN yum install -y httpd httpd-devel

# enable service
RUN systemctl enable httpd

# exec
CMD ["/sbin/init"]

