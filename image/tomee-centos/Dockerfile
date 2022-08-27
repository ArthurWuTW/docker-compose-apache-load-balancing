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

RUN mkdir /home/user/temp

RUN yum install -y java-1.8.0-openjdk-devel
COPY apache-tomee-7.1.4-plus.tar.gz /home/user/temp/ 
RUN cd /home/user/temp && tar zxvf apache-tomee-7.1.4-plus.tar.gz

COPY server.xml_tomee /home/user/temp/apache-tomee-plus-7.1.4/conf/server.xml
COPY test_dir /home/user/temp/apache-tomee-plus-7.1.4/webapps/test

CMD ["/usr/sbin/init"]
