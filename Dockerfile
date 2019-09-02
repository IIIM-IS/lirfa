FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y language-pack-en-base
RUN export LC_ALL=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN apt-get install -y software-properties-common
RUN LC_ALL=C.UTF-8 apt-add-repository ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y curl

# Install PHP 5.6
RUN apt-get install -y php5.6 php5.6-mysql php5.6-mcrypt php5.6-cli php5.6-gd php5.6-curl

# Enable apache mods.
RUN a2enmod php5.6
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/5.6/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/5.6/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

WORKDIR /var/www/lirfa
COPY . /var/www/lirfa

RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu trusty universe"
RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.6 mysql-client-5.6

# Expose apache.
EXPOSE 80
EXPOSE 8080
EXPOSE 443
EXPOSE 3306

# Update the default apache site with the config we created.
ADD ./apache-conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD sh ./run_commands.sh
