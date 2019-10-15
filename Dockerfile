FROM ubuntu:18.04

MAINTAINER patrick@romowicz.de

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y supervisor
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
EXPOSE 9001

RUN apt-get update && apt-get install -y nginx php-fpm
RUN rm -f /etc/nginx/sites-enabled/* && rm -f /var/www/html/*
ADD app /var/www/html/
COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf

EXPOSE 80

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.2-fpm.log

CMD ["supervisord"]