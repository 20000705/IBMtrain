FROM centos:7
RUN yum -y update && yum -y install httpd && yum -y install net-tools
ENV MY_NAME="hqxx"
RUN mkdir /myfiles && echo "hello world" > /myfiles/files.txt
VOLUME /myfiles
COPY ./index.html /var/www/html/index.html
EXPOSE 80
WORKDIR /myfiles
COPY ./index.html .
CMD ["http","-D","FORGROUND"]



