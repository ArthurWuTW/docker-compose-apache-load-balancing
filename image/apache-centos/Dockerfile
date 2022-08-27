FROM centos:7
MAINTAINER "ArthurWuTW <lion811004@gmail.com>"


ARG CONTAINER_USER
ARG CONTAINER_HOME
ARG CONTAINER_NAME
ARG TIMEZONE
ARG HOST_USER_GID
ARG HOST_USER_UID

WORKDIR /tmp

# Disable interactive configuration
ENV DEBIAN_FRONTEND=noninteractive

# Setup host's timezone
RUN yum update -y
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE:?} /etc/localtime
RUN yum install -y tzdata

# Install host's certification
RUN yum install ca-certificates -y && \
  update-ca-trust

# Install yum dependencies
RUN yum update -y && \
  yum install -y \
    ncurses \
    vim \
    openssh \
    openssh-server \
    firewalld \
    epel-release \
    passwd \
    cracklib-dicts \
    openssh-clients \
    git \
    git-core

RUN yum install -y \
    pcre \
    wget \ 
    perl \
    gcc \
    expat-devel \
    pcre-devel \
    make \
    net-tools

# Create user
COPY create-user exit_on_error.sh ./
RUN ./create-user && \
  rm create-user exit_on_error.sh

# Install apache
RUN mkdir /home/user/temp
COPY apr-1.7.0.tar.gz apr-util-1.6.1.tar.gz httpd-2.4.54.tar.gz /home/user/temp/
RUN cd /home/user/temp && tar zxvf apr-1.7.0.tar.gz && rm -rf apr-1.7.0.tar.gz
RUN cd /home/user/temp && tar zxvf apr-util-1.6.1.tar.gz && rm -rf apr-util-1.6.1.tar.gz 
RUN cd /home/user/temp && tar zxvf httpd-2.4.54.tar.gz && rm -rf httpd-2.4.54.tar.gz

RUN cd /home/user/temp/apr-1.7.0 && ./configure && make && make install
RUN cd /home/user/temp/apr-util-1.6.1 && ./configure --with-apr=/usr/local/apr && make && make install
RUN cd /home/user/temp/httpd-2.4.54 && ./configure --with-apr=/usr/local/apr && make && make install

RUN sed -i "s/#ServerName www.example.com:80/ServerName 127.0.0.1:80/" /usr/local/apache2/conf/httpd.conf

# Install mod_jk
COPY tomcat-connectors-1.2.48-src.tar.gz /home/user/temp/
RUN cd /home/user/temp && tar zxvf tomcat-connectors-1.2.48-src.tar.gz
RUN cd /home/user/temp/tomcat-connectors-1.2.48-src/native && \
  ./configure -with-apxs=/usr/local/apache2/bin/apxs && \
  make
RUN cd /home/user/temp/tomcat-connectors-1.2.48-src/native/apache-2.0 && \
  cp mod_jk.so /usr/local/apache2/modules
COPY httpd.conf_apache /usr/local/apache2/conf/httpd.conf
COPY workers.properties_apache /usr/local/apache2/workers.properties


CMD ["/usr/sbin/init"]
