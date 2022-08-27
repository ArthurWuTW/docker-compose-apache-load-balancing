if [[ ! -e ./image/tomee-centos/apache-tomee-7.1.4-plus.tar.gz ]]; then
    wget https://dlcdn.apache.org/tomee/tomee-7.1.4/apache-tomee-7.1.4-plus.tar.gz -P ./image/tomee-centos/
fi

if [[ ! -e ./image/apache-centos/apr-1.7.0.tar.gz ]]; then
    wget https://dlcdn.apache.org//apr/apr-1.7.0.tar.gz -P ./image/apache-centos/
fi

if [[ ! -e ./image/apache-centos/apr-util-1.6.1.tar.gz ]]; then
    wget https://dlcdn.apache.org//apr/apr-util-1.6.1.tar.gz -P ./image/apache-centos/
fi

if [[ ! -e ./image/apache-centos/httpd-2.4.54.tar.gz ]]; then
    wget https://dlcdn.apache.org/httpd/httpd-2.4.54.tar.gz -P ./image/apache-centos/
fi

if [[ ! -e ./image/apache-centos/tomcat-connectors-1.2.48-src.tar.gz ]]; then
    wget https://dlcdn.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz -P ./image/apache-centos/
fi

docker-compose up --build --detach

docker-compose exec apache-server /bin/sh -c "cd /usr/local/apache2/bin/ && ./apachectl -k start"
# docker-compose exec tomee1-server /bin/sh -c "/home/user/temp/apache-tomee-plus-7.1.4/bin/startup.sh"