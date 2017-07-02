FROM ubuntu:14.04
MAINTAINER Fernando Franceschi

#Update apt-get and install apache2
RUN apt-get update && apt-get install -y apache2 subversion apache2-utils libapache2-svn

#Create directory for apache2 lock file and run directory
RUN mkdir -p /var/lock/apache2 /var/run/apache2
RUN mkdir -p /var/lib/svn
CMD svnadmin create /var/lib/svn
CMD chown www-data:www-data -R /var/lib/svn

#Set required environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C
COPY dav_svn.conf /etc/apache2/mods-available

EXPOSE 80

VOLUME ["/var/lib/svn"]
CMD /usr/sbin/apache2ctl -D FOREGROUND
