#We are using Ubuntu 14.04 as our base image
FROM ubuntu:16.10
MAINTAINER kd <kuldeeparyadotcom@gmail.com>

#Update apt-get and install apache2
RUN apt-get update && apt-get install -y apache2 subversion apache2-utils nmap curl

#Create directory for apache2 lock file and run directory
RUN mkdir -p /var/lock/apache2 /var/run/apache2
RUN mkdir -p /var/lib/svn
CMD ["svnadmin", "create", "/var/lib/svn"]

#Set required environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C
COPY dav_svn.conf /etc/apache2/mods-available
#Define default command to run in foreground (with PID 1)
#Remember that only PID 1 process would listen to signals we are going to send via docker kill -s <container> <signal> command
#For example to restart apache2 service within Docker container
CMD [“apachectl”, “-D","FOREGROUND”]

#Epose port 80 to access web server apache2
EXPOSE 80

VOLUME ["/var/lib/svn"]
