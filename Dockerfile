FROM ubuntu:16.04
RUN apt-get update && apt-get install -y apache2 subversion libapache2-svn && apt-get clean && rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/svn && RUN svnadmin create /var/lib/svn/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
