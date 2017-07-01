FROM ubuntu:16.04
RUN apt-get update && apt-get install -y apache2 subversion libapache2-svn nmap curl && apt-get clean && \
  rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/svn && svnadmin create /var/lib/svn/ \
  && echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf && a2enconf servername && \
  chown www-data:www-data -R /var/lib/svn/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
COPY dav_svn.conf /etc/apache2/mods-available
COPY init.sh /tmp/
RUN chmod +x /tmp/init.sh
RUN /tmp/init.sh &
EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
VOLUME ["/var/lib/svn"]
#ENTRYPOINT /tmp/init.sh
