FROM ubuntu:20.04

RUN adduser wordpress

RUN apt update && apt upgrade -y
RUN apt install -y php-fpm php-mysql nginx supervisor

RUN mkdir -p /var/www/wordpress
COPY ./code /var/www/wordpress
RUN chown -R wordpress:wordpress /var/www/wordpress

COPY ./configs/wp-config.php /var/www/wordpress/wp-config.php
COPY ./configs/wordpress.conf /etc/php/7.4/fpm/pool.d/wordpress.conf
COPY ./configs/nginx.conf /etc/nginx/sites-available/default
COPY ./configs/supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-n"]
EXPOSE 80