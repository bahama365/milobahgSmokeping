FROM ubuntu:16.04
LABEL maintainer=milobahg
RUN apt-get update -y; apt-get upgrade -y; apt-get install smokeping \
  apache2 sendmail fping supervisor -y; a2enmod cgi
RUN mkdir -p /var/run/smokeping
ADD config.d/ /etc/smokeping/config.d/
ADD supervisord.conf /etc/supervisor/supervisord.conf
CMD /usr/bin/supervisord -n
